import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../l10n/app_localizations.dart';

/// Extension on BuildContext for easy access to localizations
extension LocalizationExtension on BuildContext {
  /// Access the app's localized strings
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// Extension on BuildContext for responsive design helpers
extension ResponsiveExtension on BuildContext {
  /// Device type detection
  bool get isPhone => 1.sw < 600;
  bool get isTablet => 1.sw >= 600 && 1.sw < 1200;
  bool get isDesktop => 1.sw >= 1200;

  /// Orientation detection
  bool get isLandscape => 1.sw > 1.sh;
  bool get isPortrait => 1.sw <= 1.sh;

  /// Tablet in landscape (needs special grid treatment)
  bool get isTabletLandscape => isTablet && isLandscape;

  /// Responsive padding for screens
  double get screenPadding => isTablet ? 32.w : 24.w;

  /// Grid column count for voting screens
  int get votingGridColumns {
    if (isTabletLandscape) return 4;
    if (isTablet || isLandscape) return 3;
    return 2;
  }

  /// Card dimensions that adapt to screen size
  double get cardWidth => isTablet ? 320.w : 280.w;
  double get cardHeight => isTablet ? 440.h : 400.h;
}
