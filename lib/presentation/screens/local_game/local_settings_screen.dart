import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../providers/word_pack_provider.dart';

class LocalSettingsScreen extends ConsumerWidget {
  const LocalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(localGameProvider);
    final wordPacksAsync = ref.watch(wordPacksProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Settings',
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
                title: 'Number of Rounds',
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
                title: 'Discussion Time',
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

              // Word pack selection
              _SettingsCard(
                title: 'Word Pack',
                value: '',
                child: wordPacksAsync.when(
                  data: (packs) => DropdownButton<String>(
                    value: gameState.settings.selectedPackId,
                    isExpanded: true,
                    underline: const SizedBox(),
                    dropdownColor: AppColors.surface,
                    style: AppTypography.body,
                    hint: Text(
                      'Select a pack',
                      style: AppTypography.body.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Text(
                          'Random (All Packs)',
                          style: AppTypography.body,
                        ),
                      ),
                      ...packs.map((pack) => DropdownMenuItem(
                        value: pack.id,
                        child: Text(
                          pack.name,
                          style: AppTypography.body,
                        ),
                      )),
                    ],
                    onChanged: (value) {
                      ref.read(localGameProvider.notifier).setSelectedPack(value);
                    },
                  ),
                  loading: () => const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  error: (e, _) => Text(
                    'Failed to load packs',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

              const SizedBox(height: 16),

              // Reveal protection toggle
              _SettingsToggle(
                title: 'Reveal Protection',
                subtitle: 'Require hold to reveal cards',
                value: gameState.settings.revealProtection,
                onChanged: (value) {
                  ref.read(localGameProvider.notifier).setRevealProtection(value);
                },
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

              const SizedBox(height: 16),

              // Allow pause toggle
              _SettingsToggle(
                title: 'Allow Pause',
                subtitle: 'Enable pause during discussion',
                value: gameState.settings.allowPause,
                onChanged: (value) {
                  ref.read(localGameProvider.notifier).setAllowPause(value);
                },
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

              const SizedBox(height: 16),

              // Haptic feedback toggle
              _SettingsToggle(
                title: 'Haptic Feedback',
                subtitle: 'Vibrate on card reveal and votes',
                value: gameState.settings.hapticFeedback,
                onChanged: (value) {
                  ref.read(localGameProvider.notifier).setHapticFeedback(value);
                },
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
