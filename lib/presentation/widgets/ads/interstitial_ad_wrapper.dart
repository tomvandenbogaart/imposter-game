import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/ad_provider.dart';

/// A utility class for showing interstitial ads at appropriate moments
class InterstitialAdWrapper {
  /// Call this between rounds or at screen transitions
  /// Returns true if an ad was shown, false otherwise
  static Future<bool> showIfNeeded(WidgetRef ref) async {
    final adController = ref.read(adControllerProvider.notifier);
    return await adController.showInterstitialIfNeeded();
  }

  /// Check if ads should be shown (user doesn't have no-ads entitlement)
  static bool shouldShowAds(WidgetRef ref) {
    return ref.read(shouldShowAdsProvider);
  }
}
