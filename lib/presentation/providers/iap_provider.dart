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
    _subscription = _iapService.purchaseStream.listen(_handlePurchaseUpdate);
  }

  Future<void> _handlePurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
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
          state = state.copyWith(status: AppPurchaseStatus.verifying);

          try {
            // Send to backend for validation and entitlement granting
            await _entitlementNotifier.validatePurchase(
              store: _iapService.storeName,
              storeProductId: purchase.productID,
              storeTransactionId: purchase.purchaseID ?? '',
              purchaseToken: purchase.verificationData.serverVerificationData,
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
            AppLogger.e('Purchase validation error', e);
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
    state = state.copyWith(
      status: AppPurchaseStatus.loading,
      restoredCount: 0,
      errorMessage: null,
    );

    await _iapService.restorePurchases();

    // Wait a moment for restore to complete
    await Future.delayed(const Duration(seconds: 2));

    if (state.status == AppPurchaseStatus.loading) {
      // No purchases were restored
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
