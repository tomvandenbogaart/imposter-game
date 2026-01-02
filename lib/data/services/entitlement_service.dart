import 'package:shared_preferences/shared_preferences.dart';
import '../models/entitlement.dart';
import '../../core/utils/app_logger.dart';

/// Service for managing device-based IAP entitlements
/// Entitlements are stored locally in SharedPreferences
class EntitlementService {
  // Cache keys
  static const _keyHasNoAds = 'entitlement_no_ads';
  static const _keyHasAllPacks = 'entitlement_all_packs';

  /// Fetch entitlements from local cache
  /// For device-based IAP, we only use locally cached entitlements
  Future<UserEntitlements> fetchEntitlements() async {
    return await getCachedEntitlements();
  }

  /// Get cached entitlements (for offline access)
  Future<UserEntitlements> getCachedEntitlements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasNoAds = prefs.getBool(_keyHasNoAds) ?? false;
      final hasAllPacks = prefs.getBool(_keyHasAllPacks) ?? false;

      AppLogger.i(
          'Returning cached entitlements: hasNoAds=$hasNoAds, hasAllPacks=$hasAllPacks');

      return UserEntitlements(
        hasNoAds: hasNoAds,
        hasAllPacks: hasAllPacks,
      );
    } catch (e) {
      AppLogger.e('Failed to get cached entitlements', e);
      return const UserEntitlements();
    }
  }

  Future<void> _cacheEntitlements(bool hasNoAds, bool hasAllPacks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyHasNoAds, hasNoAds);
      await prefs.setBool(_keyHasAllPacks, hasAllPacks);
      AppLogger.d('Cached entitlements locally');
    } catch (e) {
      AppLogger.e('Failed to cache entitlements', e);
    }
  }

  /// Clear cached entitlements (on logout)
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyHasNoAds);
      await prefs.remove(_keyHasAllPacks);
      AppLogger.i('Cleared entitlement cache');
    } catch (e) {
      AppLogger.e('Failed to clear entitlement cache', e);
    }
  }

  /// Grant entitlement locally based on product ID (no server validation)
  /// Used for device-based IAP without user accounts
  Future<UserEntitlements> grantLocalEntitlement(String productId) async {
    AppLogger.i('Granting local entitlement for product: $productId');

    final prefs = await SharedPreferences.getInstance();
    bool hasNoAds = prefs.getBool(_keyHasNoAds) ?? false;
    bool hasAllPacks = prefs.getBool(_keyHasAllPacks) ?? false;

    // Grant based on product ID
    switch (productId) {
      case 'remove_ads':
        hasNoAds = true;
        break;
      case 'all_packs':
        hasAllPacks = true;
        break;
      case 'packs_no_ads':
        // Bundle grants both
        hasNoAds = true;
        hasAllPacks = true;
        break;
    }

    // Cache the updated entitlements
    await _cacheEntitlements(hasNoAds, hasAllPacks);

    AppLogger.i(
        'Local entitlements granted: hasNoAds=$hasNoAds, hasAllPacks=$hasAllPacks');

    return UserEntitlements(
      hasNoAds: hasNoAds,
      hasAllPacks: hasAllPacks,
    );
  }
}
