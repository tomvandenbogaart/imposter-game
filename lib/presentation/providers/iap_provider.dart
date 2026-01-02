import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../data/models/purchase_state.dart';
import '../../data/services/iap_service.dart';
import '../../core/utils/app_logger.dart';
import 'entitlement_provider.dart';

// Service provider
final iapServiceProvider = Provider<IAPService>((ref) {
  final service = IAPService();
  ref.onDispose(() => service.dispose());
  return service;
});

// Products from store
final storeProductsProvider =
    FutureProvider<List<ProductDetails>>((ref) async {
  final service = ref.watch(iapServiceProvider);
  await service.initialize();
  return service.loadProducts();
});

// Purchase state notifier
class PurchaseNotifier extends StateNotifier<PurchaseState> {
  final IAPService _iapService;
  final EntitlementNotifier _entitlementNotifier;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  PurchaseNotifier(this._iapService, this._entitlementNotifier)
      : super(const PurchaseState()) {
    _listenToPurchases();
  }

  void _listenToPurchases() {
    AppLogger.i('PurchaseNotifier: Subscribing to purchase stream');
    _subscription = _iapService.purchaseStream.listen(
      _handlePurchaseUpdate,
      onError: (e) => AppLogger.e('PurchaseNotifier stream error', e),
      onDone: () => AppLogger.i('PurchaseNotifier stream done'),
    );
  }

  final Set<String> _processedTransactions = {};

  Future<void> _handlePurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      // Skip already processed transactions to prevent loops
      final transactionId = purchase.purchaseID ?? purchase.productID;
      final alreadyProcessed = _processedTransactions.contains(transactionId);

      if (alreadyProcessed) {
        AppLogger.i('Purchase already processed: ${purchase.productID} (id: $transactionId)');
        // For restored purchases, still grant entitlements (idempotent) and update UI
        if (purchase.status == PurchaseStatus.restored) {
          await _entitlementNotifier.grantEntitlementForProduct(purchase.productID);
          state = state.copyWith(
            status: AppPurchaseStatus.restored,
            restoredCount: state.restoredCount + 1,
          );
        }
        // Still need to complete the purchase
        if (purchase.pendingCompletePurchase) {
          await _iapService.completePurchase(purchase);
        }
        continue;
      }

      AppLogger.i(
          'Purchase update: ${purchase.productID} - ${purchase.status}');

      switch (purchase.status) {
        case PurchaseStatus.pending:
          state = state.copyWith(
            status: AppPurchaseStatus.purchasing,
            currentProductId: purchase.productID,
          );
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // Mark as processed to prevent re-processing
          _processedTransactions.add(transactionId);

          state = state.copyWith(status: AppPurchaseStatus.verifying);

          try {
            // Grant entitlements locally based on product ID
            // The App Store / Play Store has already validated the purchase
            await _entitlementNotifier.grantEntitlementForProduct(
              purchase.productID,
            );

            // Complete the purchase with the store
            await _iapService.completePurchase(purchase);

            state = state.copyWith(
              status: purchase.status == PurchaseStatus.restored
                  ? AppPurchaseStatus.restored
                  : AppPurchaseStatus.success,
              restoredCount: purchase.status == PurchaseStatus.restored
                  ? state.restoredCount + 1
                  : state.restoredCount,
            );
          } catch (e) {
            AppLogger.e('Purchase processing error', e);
            state = state.copyWith(
              status: AppPurchaseStatus.error,
              errorMessage: e.toString(),
            );
            // Still complete the purchase to avoid being stuck
            await _iapService.completePurchase(purchase);
          }
          break;

        case PurchaseStatus.error:
          state = state.copyWith(
            status: AppPurchaseStatus.error,
            errorMessage: purchase.error?.message ?? 'Purchase failed',
          );
          await _iapService.completePurchase(purchase);
          break;

        case PurchaseStatus.canceled:
          state = state.copyWith(
            status: AppPurchaseStatus.idle,
            currentProductId: null,
          );
          break;
      }
    }
  }

  Future<void> purchase(ProductDetails product) async {
    state = state.copyWith(
      status: AppPurchaseStatus.loading,
      currentProductId: product.id,
      errorMessage: null,
    );

    final success = await _iapService.purchaseProduct(product);
    if (!success) {
      state = state.copyWith(
        status: AppPurchaseStatus.error,
        errorMessage: 'Could not initiate purchase',
        currentProductId: null,
      );
      return;
    }

    // Set a timeout - if no response within 10 seconds, reset to idle
    // This handles cases where the purchase sheet is dismissed without a stream event
    Future.delayed(const Duration(seconds: 10), () {
      if (state.status == AppPurchaseStatus.loading &&
          state.currentProductId == product.id) {
        state = state.copyWith(
          status: AppPurchaseStatus.idle,
          currentProductId: null,
        );
      }
    });
  }

  Future<void> restorePurchases() async {
    AppLogger.i('PurchaseNotifier: Starting restore purchases');

    // Clear entitlements first - they will be re-granted if StoreKit returns valid purchases
    await _entitlementNotifier.clearAllEntitlements();

    state = state.copyWith(
      status: AppPurchaseStatus.loading,
      restoredCount: 0,
      errorMessage: null,
    );

    await _iapService.restorePurchases();

    // Wait a moment for restore to complete
    AppLogger.i('PurchaseNotifier: Waiting for restore events...');
    await Future.delayed(const Duration(seconds: 2));

    AppLogger.i('PurchaseNotifier: After wait, status=${state.status}, restoredCount=${state.restoredCount}');
    if (state.status == AppPurchaseStatus.loading) {
      // No purchases were restored
      AppLogger.i('PurchaseNotifier: No purchases restored (status still loading)');
      state = state.copyWith(
        status: AppPurchaseStatus.restored,
        restoredCount: 0,
      );
    }
  }

  void resetState() {
    state = const PurchaseState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final purchaseNotifierProvider =
    StateNotifierProvider<PurchaseNotifier, PurchaseState>((ref) {
  final iapService = ref.watch(iapServiceProvider);
  final entitlementNotifier = ref.watch(entitlementNotifierProvider.notifier);
  return PurchaseNotifier(iapService, entitlementNotifier);
});

// IAP initializer - ensures proper ordering on startup
final iapInitializerProvider = FutureProvider<void>((ref) async {
  // 1. First load cached entitlements so UI shows correct state immediately
  await ref.read(entitlementNotifierProvider.notifier).loadCachedEntitlements();

  // 2. Get the notifier (this creates it and starts stream subscription)
  final purchaseNotifier = ref.read(purchaseNotifierProvider.notifier);

  // 3. Initialize IAP service
  final iapService = ref.read(iapServiceProvider);
  await iapService.initialize();

  // 4. Small delay to ensure stream subscription is ready
  await Future.delayed(const Duration(milliseconds: 100));

  // 5. Now restore purchases - events will be caught by the listener
  await purchaseNotifier.restorePurchases();
});
