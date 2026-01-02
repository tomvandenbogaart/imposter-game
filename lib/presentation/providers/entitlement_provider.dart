import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/entitlement.dart';
import '../../data/services/entitlement_service.dart';
import 'auth_provider.dart';

// Service provider
final entitlementServiceProvider = Provider<EntitlementService>((ref) {
  return EntitlementService();
});

// Entitlement state notifier
class EntitlementNotifier extends StateNotifier<AsyncValue<UserEntitlements>> {
  final EntitlementService _service;

  EntitlementNotifier(this._service) : super(const AsyncValue.loading()) {
    loadEntitlements();
  }

  Future<void> loadEntitlements() async {
    state = const AsyncValue.loading();
    try {
      final entitlements = await _service.fetchEntitlements();
      state = AsyncValue.data(entitlements);
    } catch (e, st) {
      // Fall back to cached entitlements on error
      final cached = await _service.getCachedEntitlements();
      state = AsyncValue.data(cached);
    }
  }

  Future<void> validatePurchase({
    required String store,
    required String storeProductId,
    required String storeTransactionId,
    String? purchaseToken,
  }) async {
    final entitlements = await _service.validatePurchase(
      store: store,
      storeProductId: storeProductId,
      storeTransactionId: storeTransactionId,
      purchaseToken: purchaseToken,
    );
    state = AsyncValue.data(entitlements);
  }

  Future<void> refresh() async {
    await loadEntitlements();
  }

  Future<void> clearOnLogout() async {
    await _service.clearCache();
    state = const AsyncValue.data(UserEntitlements());
  }
}

final entitlementNotifierProvider =
    StateNotifierProvider<EntitlementNotifier, AsyncValue<UserEntitlements>>(
        (ref) {
  final service = ref.watch(entitlementServiceProvider);
  final notifier = EntitlementNotifier(service);

  // Re-load entitlements when auth state changes
  ref.listen(authStateProvider, (previous, next) {
    final hasSession = next.valueOrNull?.session != null;
    if (hasSession) {
      notifier.loadEntitlements();
    }
  });

  return notifier;
});

// Convenience providers for easy access
final hasNoAdsProvider = Provider<bool>((ref) {
  return ref.watch(entitlementNotifierProvider).valueOrNull?.hasNoAds ?? false;
});

final hasAllPacksProvider = Provider<bool>((ref) {
  return ref.watch(entitlementNotifierProvider).valueOrNull?.hasAllPacks ??
      false;
});

final hasPremiumProvider = Provider<bool>((ref) {
  final entitlements = ref.watch(entitlementNotifierProvider).valueOrNull;
  return entitlements?.hasPremium ?? false;
});

final hasBundleProvider = Provider<bool>((ref) {
  final entitlements = ref.watch(entitlementNotifierProvider).valueOrNull;
  return entitlements?.hasBundle ?? false;
});
