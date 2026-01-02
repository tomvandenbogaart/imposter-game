import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/entitlement.dart';
import '../../data/services/entitlement_service.dart';

// Service provider
final entitlementServiceProvider = Provider<EntitlementService>((ref) {
  return EntitlementService();
});

// Entitlement state notifier
class EntitlementNotifier extends StateNotifier<AsyncValue<UserEntitlements>> {
  final EntitlementService _service;

  EntitlementNotifier(this._service)
      : super(const AsyncValue.loading()) {
    // Load cached entitlements immediately on creation
    _initializeEntitlements();
  }

  Future<void> _initializeEntitlements() async {
    await loadCachedEntitlements();
  }

  /// Load cached entitlements from local storage
  /// Call this explicitly on startup to ensure entitlements are loaded before UI renders
  Future<void> loadCachedEntitlements() async {
    final cached = await _service.getCachedEntitlements();
    state = AsyncValue.data(cached);
  }

  /// Refresh entitlements from local cache
  /// For device-based IAP, we only use locally cached entitlements
  Future<void> refresh() async {
    await loadCachedEntitlements();
  }

  /// Grant entitlement locally based on product ID (no server validation)
  Future<void> grantEntitlementForProduct(String productId) async {
    final entitlements = await _service.grantLocalEntitlement(productId);
    state = AsyncValue.data(entitlements);
  }

  Future<void> clearOnLogout() async {
    await _service.clearCache();
    state = const AsyncValue.data(UserEntitlements());
  }

  /// Clear all entitlements (for testing/debugging)
  Future<void> clearAllEntitlements() async {
    await _service.clearCache();
    state = const AsyncValue.data(UserEntitlements());
  }
}

final entitlementNotifierProvider =
    StateNotifierProvider<EntitlementNotifier, AsyncValue<UserEntitlements>>(
        (ref) {
  final service = ref.watch(entitlementServiceProvider);
  return EntitlementNotifier(service);
  // Note: For device-based IAP, entitlements are stored locally via SharedPreferences.
  // No need to re-fetch from server when auth state changes.
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
