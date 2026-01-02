import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _localeKey = 'selected_locale';

/// Supported locales for the app
const supportedLocales = [
  Locale('en'), // English (default)
  Locale('nl'), // Dutch
  Locale('de'), // German
  Locale('fr'), // French
  Locale('es'), // Spanish
];

/// Get the display name for a locale
String getLocaleDisplayName(Locale? locale) {
  if (locale == null) return 'System Default';
  switch (locale.languageCode) {
    case 'en':
      return 'English';
    case 'nl':
      return 'Nederlands';
    case 'de':
      return 'Deutsch';
    case 'fr':
      return 'Français';
    case 'es':
      return 'Español';
    default:
      return locale.languageCode;
  }
}

/// Get the flag emoji for a locale
String getLocaleFlag(Locale? locale) {
  if (locale == null) return '🌐';
  switch (locale.languageCode) {
    case 'en':
      return '🇬🇧';
    case 'nl':
      return '🇳🇱';
    case 'de':
      return '🇩🇪';
    case 'fr':
      return '🇫🇷';
    case 'es':
      return '🇪🇸';
    default:
      return '🌐';
  }
}

/// Notifier for managing the app's locale state
class LocaleNotifier extends StateNotifier<Locale?> {
  LocaleNotifier() : super(null) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_localeKey);
    if (savedLocale != null) {
      state = Locale(savedLocale);
    }
  }

  /// Set the locale manually, or null for system default
  Future<void> setLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_localeKey);
    } else {
      await prefs.setString(_localeKey, locale.languageCode);
    }
    state = locale;
  }

  /// Check if using system default
  bool get isSystemDefault => state == null;
}

/// Provider for the locale state (null = system default)
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier();
});

/// Provider that resolves to the actual locale being used
/// Falls back to English if no manual selection and system locale not supported
final resolvedLocaleProvider = Provider<Locale>((ref) {
  final manualLocale = ref.watch(localeProvider);
  if (manualLocale != null) {
    return manualLocale;
  }
  // System default - will be resolved by Flutter's localization system
  // Return English as fallback for code that needs a concrete locale
  return supportedLocales.first;
});
