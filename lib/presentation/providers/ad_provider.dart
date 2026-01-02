import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/ad_service.dart';
import 'entitlement_provider.dart';

// Service provider
final adServiceProvider = Provider<AdService>((ref) {
  final service = AdService();
  ref.onDispose(() => service.dispose());
  return service;
});

// Ad controller that respects entitlements
class AdController extends StateNotifier<bool> {
  final AdService _adService;
  final bool _hasNoAds;

  AdController(this._adService, this._hasNoAds) : super(false) {
    if (!_hasNoAds) {
      _initialize();
    }
  }

  Future<void> _initialize() async {
    await _adService.initialize();
    await _adService.loadInterstitialAd();
    state = _adService.isAdReady;
  }

  /// Show interstitial ad if user doesn't have no-ads entitlement
  /// Returns true if ad was shown, false otherwise
  Future<bool> showInterstitialIfNeeded() async {
    if (_hasNoAds) return false;

    final shown = await _adService.showInterstitialAd();
    state = _adService.isAdReady;
    return shown;
  }

  bool get shouldShowAds => !_hasNoAds;
  bool get isAdReady => state;
}

final adControllerProvider = StateNotifierProvider<AdController, bool>((ref) {
  final adService = ref.watch(adServiceProvider);
  final hasNoAds = ref.watch(hasNoAdsProvider);
  return AdController(adService, hasNoAds);
});

/// Provider to check if ads should be shown
final shouldShowAdsProvider = Provider<bool>((ref) {
  final hasNoAds = ref.watch(hasNoAdsProvider);
  return !hasNoAds;
});
