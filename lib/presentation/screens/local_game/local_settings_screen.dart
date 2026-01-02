import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../providers/locale_provider.dart';

class LocalSettingsScreen extends ConsumerWidget {
  const LocalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(localGameProvider);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.localSettings_title,
          style: AppTypography.h2,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Number of rounds
              _SettingsCard(
                title: context.l10n.localSettings_numberOfRounds,
                value: '${gameState.settings.numberOfRounds}',
                child: Slider(
                  value: gameState.settings.numberOfRounds.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  activeColor: AppColors.cyan,
                  inactiveColor: AppColors.surfaceLight,
                  onChanged: (value) {
                    ref.read(localGameProvider.notifier).setNumberOfRounds(value.toInt());
                  },
                ),
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: 16),

              // Timer duration
              _SettingsCard(
                title: context.l10n.localSettings_discussionTime,
                value: '${gameState.settings.timerDuration ~/ 60}:${(gameState.settings.timerDuration % 60).toString().padLeft(2, '0')}',
                child: Slider(
                  value: gameState.settings.timerDuration.toDouble(),
                  min: 60,
                  max: 180,
                  divisions: 12,
                  activeColor: AppColors.cyan,
                  inactiveColor: AppColors.surfaceLight,
                  onChanged: (value) {
                    ref.read(localGameProvider.notifier).setTimerDuration(value.toInt());
                  },
                ),
              ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

              const SizedBox(height: 16),

              // Reveal protection toggle
              _SettingsToggle(
                title: context.l10n.localSettings_revealProtection_title,
                subtitle: context.l10n.localSettings_revealProtection_subtitle,
                value: gameState.settings.revealProtection,
                onChanged: (value) {
                  ref.read(localGameProvider.notifier).setRevealProtection(value);
                },
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

              const SizedBox(height: 16),

              // Allow pause toggle
              _SettingsToggle(
                title: context.l10n.localSettings_allowPause_title,
                subtitle: context.l10n.localSettings_allowPause_subtitle,
                value: gameState.settings.allowPause,
                onChanged: (value) {
                  ref.read(localGameProvider.notifier).setAllowPause(value);
                },
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

              const SizedBox(height: 16),

              // Haptic feedback toggle
              _SettingsToggle(
                title: context.l10n.localSettings_hapticFeedback_title,
                subtitle: context.l10n.localSettings_hapticFeedback_subtitle,
                value: gameState.settings.hapticFeedback,
                onChanged: (value) {
                  ref.read(localGameProvider.notifier).setHapticFeedback(value);
                },
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

              const SizedBox(height: 16),

              // Language selection
              _SettingsCard(
                title: context.l10n.localSettings_language_title,
                value: '',
                child: DropdownButton<Locale?>(
                  value: currentLocale,
                  isExpanded: true,
                  underline: const SizedBox(),
                  dropdownColor: AppColors.surface,
                  style: AppTypography.body,
                  hint: Row(
                    children: [
                      Text(getLocaleFlag(null), style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 12),
                      Text(
                        context.l10n.localSettings_language_system,
                        style: AppTypography.body.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  items: [
                    DropdownMenuItem<Locale?>(
                      value: null,
                      child: Row(
                        children: [
                          Text(getLocaleFlag(null), style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 12),
                          Text(
                            context.l10n.localSettings_language_system,
                            style: AppTypography.body,
                          ),
                        ],
                      ),
                    ),
                    ...supportedLocales.map((locale) => DropdownMenuItem(
                      value: locale,
                      child: Row(
                        children: [
                          Text(getLocaleFlag(locale), style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 12),
                          Text(
                            getLocaleDisplayName(locale),
                            style: AppTypography.body,
                          ),
                        ],
                      ),
                    )),
                  ],
                  onChanged: (locale) {
                    ref.read(localeProvider.notifier).setLocale(locale);
                  },
                ),
              ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget child;

  const _SettingsCard({
    required this.title,
    required this.value,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceLight,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTypography.playerName),
              if (value.isNotEmpty)
                Text(
                  value,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.cyan,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggle({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceLight,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.playerName),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.cyan,
            activeTrackColor: AppColors.cyan.withValues(alpha: 0.3),
            inactiveThumbColor: AppColors.textMuted,
            inactiveTrackColor: AppColors.surfaceLight,
          ),
        ],
      ),
    );
  }
}
