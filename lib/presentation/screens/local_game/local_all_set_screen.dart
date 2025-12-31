import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../providers/local_timer_provider.dart';
import '../../widgets/buttons/primary_button.dart';

class LocalAllSetScreen extends ConsumerWidget {
  const LocalAllSetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(localGameProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),

                // Success icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cyan.withValues(alpha: 0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 64,
                    color: AppColors.background,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      curve: Curves.elasticOut,
                      duration: 800.ms,
                    ),

                const SizedBox(height: 32),

                // Title
                Text(
                  'All Set!',
                  style: AppTypography.display,
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms)
                    .slideY(begin: 0.2),

                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'All players have seen their cards',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

                const SizedBox(height: 48),

                // Player count summary
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.surfaceLight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(
                        label: 'Players',
                        value: '${gameState.players.length}',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.surfaceLight,
                      ),
                      _StatItem(
                        label: 'Timer',
                        value: '${gameState.settings.timerDuration ~/ 60}:${(gameState.settings.timerDuration % 60).toString().padLeft(2, '0')}',
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.surfaceLight,
                      ),
                      const _StatItem(
                        label: 'Imposter',
                        value: '1',
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 700.ms, duration: 400.ms),

                const Spacer(),

                // Instructions
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.surfaceLight,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.cyan,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Discuss to find the imposter. The imposter blends in without knowing the word!',
                          style: AppTypography.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 900.ms, duration: 400.ms),

                const SizedBox(height: 24),

                // Start discussion button
                PrimaryButton(
                  label: 'Start Discussion',
                  icon: Icons.chat_bubble_rounded,
                  onPressed: () {
                    ref.read(localGameProvider.notifier).startDiscussion();
                    ref.read(localTimerProvider.notifier).startTimer(
                      gameState.settings.timerDuration,
                    );
                    context.go('/local/discussion');
                  },
                ).animate().fadeIn(delay: 1000.ms, duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.h3,
        ),
        Text(
          label,
          style: AppTypography.caption,
        ),
      ],
    );
  }
}
