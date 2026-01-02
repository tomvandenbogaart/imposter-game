import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/entitlement.dart';
import 'supabase_service.dart';
import '../../core/utils/app_logger.dart';

class EntitlementService {
  final SupabaseClient _client = SupabaseService.client;

  // Cache keys
  static const _keyHasNoAds = 'entitlement_no_ads';
  static const _keyHasAllPacks = 'entitlement_all_packs';

  /// Fetch entitlements from Supabase
  Future<UserEntitlements> fetchEntitlements() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      AppLogger.w('No user logged in, returning empty entitlements');
      return const UserEntitlements();
    }

    try {
      final response = await _client
          .from('entitlements')
          .select('''
            id,
            user_id,
            product_id,
            source,
            granted_at,
            expires_at,
            created_at,
            product:products(id, type, store_product_id)
          ''')
          .eq('user_id', userId);

      bool hasNoAds = false;
      bool hasAllPacks = false;
      final entitlements = <Entitlement>[];

      for (final row in response as List) {
        final entitlement = Entitlement.fromJson(row);
        entitlements.add(entitlement);

        // Check product type from joined data
        final product = row['product'] as Map<String, dynamic>?;
        if (product != null) {
          final type = product['type'] as String?;
          if (type == 'ads') hasNoAds = true;
          if (type == 'packs') hasAllPacks = true;
        }
      }

      // Cache locally for offline access
      await _cacheEntitlements(hasNoAds, hasAllPacks);

      AppLogger.i(
          'Fetched entitlements: hasNoAds=$hasNoAds, hasAllPacks=$hasAllPacks');

      return UserEntitlements(
        hasNoAds: hasNoAds,
        hasAllPacks: hasAllPacks,
        rawEntitlements: entitlements,
      );
    } catch (e) {
      AppLogger.e('Failed to fetch entitlements', e);
      // Return cached entitlements on error
      return await getCachedEntitlements();
    }
  }

  /// Validate purchase with Supabase edge function
  Future<UserEntitlements> validatePurchase({
    required String store,
    required String storeProductId,
    required String storeTransactionId,
    String? purchaseToken,
  }) async {
    AppLogger.i('Validating purchase: $storeProductId on $store');

    try {
      final response = await _client.functions.invoke(
        'validate-purchase',
        body: {
          'store': store,
          'store_product_id': storeProductId,
          'store_transaction_id': storeTransactionId,
          'purchase_token': purchaseToken,
        },
      );

      if (response.status != 200) {
        final error = response.data?['error'] ?? 'Validation failed';
        AppLogger.e('Purchase validation failed: $error');
        throw Exception(error);
      }

      AppLogger.i('Purchase validated successfully');

      // Re-fetch entitlements after successful validation
      return await fetchEntitlements();
    } catch (e) {
      AppLogger.e('Purchase validation error', e);
      rethrow;
    }
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
}
