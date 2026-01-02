import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../core/utils/app_logger.dart';

class IAPService {
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool _isInitialized = false;

  final _purchaseUpdatedController =
      StreamController<List<PurchaseDetails>>.broadcast();
  Stream<List<PurchaseDetails>> get purchaseStream =>
      _purchaseUpdatedController.stream;

  // Product IDs - must match store configurations
  static const Set<String> productIds = {
    'remove_ads',
    'all_packs',
    'packs_no_ads',
  };

  Future<bool> initialize() async {
    if (_isInitialized) {
      AppLogger.i('IAP service already initialized');
      return true;
    }

    final available = await _iap.isAvailable();
    if (!available) {
      AppLogger.w('IAP not available on this device');
      return false;
    }

    // Listen to purchase updates
    _subscription = _iap.purchaseStream.listen(
      (purchaseDetailsList) {
        AppLogger.i('IAP stream received ${purchaseDetailsList.length} purchases');
        for (final p in purchaseDetailsList) {
          AppLogger.i('  - ${p.productID}: ${p.status} (id: ${p.purchaseID})');
        }
        _purchaseUpdatedController.add(purchaseDetailsList);
      },
      onDone: () {
        AppLogger.i('IAP stream done');
        _subscription?.cancel();
      },
      onError: (error) => AppLogger.e('Purchase stream error', error),
    );

    _isInitialized = true;
    AppLogger.i('IAP service initialized');
    return true;
  }

  Future<List<ProductDetails>> loadProducts() async {
    final response = await _iap.queryProductDetails(productIds);

    if (response.notFoundIDs.isNotEmpty) {
      AppLogger.w('Products not found: ${response.notFoundIDs}');
    }

    if (response.error != null) {
      AppLogger.e('Error loading products', response.error);
    }

    AppLogger.i('Loaded ${response.productDetails.length} products');
    return response.productDetails;
  }

  Future<bool> purchaseProduct(ProductDetails product) async {
    final purchaseParam = PurchaseParam(productDetails: product);

    try {
      // Non-consumable purchase (permanent entitlement)
      final success = await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      AppLogger.i('Purchase initiated for ${product.id}: $success');
      return success;
    } catch (e) {
      AppLogger.e('Purchase failed', e);
      return false;
    }
  }

  Future<void> restorePurchases() async {
    AppLogger.i('Restoring purchases...');
    try {
      await _iap.restorePurchases();
      AppLogger.i('Restore purchases call completed');
    } catch (e) {
      AppLogger.e('Restore purchases failed', e);
      rethrow;
    }
  }

  Future<void> completePurchase(PurchaseDetails purchase) async {
    if (purchase.pendingCompletePurchase) {
      await _iap.completePurchase(purchase);
      AppLogger.i('Purchase completed: ${purchase.productID}');
    }
  }

  String get storeName => Platform.isIOS ? 'ios' : 'android';

  void dispose() {
    _subscription?.cancel();
    _purchaseUpdatedController.close();
    AppLogger.i('IAP service disposed');
  }
}
