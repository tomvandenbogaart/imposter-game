import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/utils/app_logger.dart';

class AdService {
  InterstitialAd? _interstitialAd;
  bool _isInitialized = false;
  bool _isLoadingAd = false;

  // Test ad unit IDs for development
  static const _testInterstitialAndroid = 'ca-app-pub-3940256099942544/1033173712';
  static const _testInterstitialIos = 'ca-app-pub-3940256099942544/4411468910';

  String get _interstitialAdUnitId {
    if (Platform.isIOS) {
      return dotenv.env['ADMOB_INTERSTITIAL_IOS'] ?? _testInterstitialIos;
    }
    return dotenv.env['ADMOB_INTERSTITIAL_ANDROID'] ?? _testInterstitialAndroid;
  }

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      AppLogger.i('AdMob initialized successfully');
    } catch (e) {
      AppLogger.e('Failed to initialize AdMob', e);
    }
  }

  Future<void> loadInterstitialAd() async {
    if (_isLoadingAd || _interstitialAd != null) return;

    _isLoadingAd = true;
    AppLogger.d('Loading interstitial ad...');

    await InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isLoadingAd = false;
          AppLogger.i('Interstitial ad loaded');

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              AppLogger.d('Interstitial ad dismissed');
              ad.dispose();
              _interstitialAd = null;
              // Pre-load next ad
              loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              AppLogger.e('Failed to show interstitial', error);
              ad.dispose();
              _interstitialAd = null;
            },
            onAdShowedFullScreenContent: (ad) {
              AppLogger.d('Interstitial ad shown');
            },
          );
        },
        onAdFailedToLoad: (error) {
          _isLoadingAd = false;
          AppLogger.e('Failed to load interstitial: ${error.message}');
        },
      ),
    );
  }

  /// Show interstitial ad if available
  /// Returns true if ad was shown, false otherwise
  Future<bool> showInterstitialAd() async {
    if (_interstitialAd == null) {
      AppLogger.w('Interstitial ad not ready');
      // Try to load for next time
      loadInterstitialAd();
      return false;
    }

    try {
      await _interstitialAd!.show();
      return true;
    } catch (e) {
      AppLogger.e('Error showing interstitial', e);
      return false;
    }
  }

  bool get isAdReady => _interstitialAd != null;
  bool get isInitialized => _isInitialized;

  void dispose() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    AppLogger.i('Ad service disposed');
  }
}
