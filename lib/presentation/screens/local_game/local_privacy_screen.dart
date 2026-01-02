import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';
import '../../providers/local_game_provider.dart';
import '../../widgets/buttons/hold_to_confirm_button.dart';
import '../../widgets/buttons/primary_button.dart';

class LocalPrivacyScreen extends ConsumerWidget {
  const LocalPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(localGameProvider);
    final currentPlayer = gameState.currentPlayer;

    if (currentPlayer == null) {
      // All players done, go to next phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (gameState.phase == LocalGamePhase.revealing) {
          ref.read(localGameProvider.notifier).goToAllSet();
          context.go('/local/allset');
        } else if (gameState.phase == LocalGamePhase.voting) {
          ref.read(localGameProvider.notifier).showResults();
          context.go('/local/results');
        }
      });
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isVotingPhase = gameState.phase == LocalGamePhase.voting;
    final progress = gameState.currentPlayerIndex + 1;
    final total = gameState.players.length;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Progress indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isVotingPhase
                          ? context.l10n.privacy_vote_label
                          : context.l10n.privacy_player_label,
                      style: AppTypography.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        context.l10n.privacy_progress(progress, total),
                        style: AppTypography.buttonSmall.copyWith(
                          color: AppColors.cyan,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms),

                const Spacer(),

                // Pass to message
                Text(
                  context.l10n.privacy_passPhoneTo,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                const SizedBox(height: 8),

                // Player name
                Text(
                  currentPlayer.name,
                  style: AppTypography.display,
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms)
                    .slideY(begin: 0.2),

                const SizedBox(height: 16),

                Text(
                  isVotingPhase
                      ? context.l10n.privacy_toCastVote
                      : context.l10n.privacy_toSeeRole,
                  style: AppTypography.bodySmall,
                ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

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
                        Icons.visibility_off_rounded,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          context.l10n.privacy_ensurePrivacy(currentPlayer.name),
                          style: AppTypography.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

                const SizedBox(height: 24),

                // Continue button
                if (gameState.settings.revealProtection)
                  HoldToConfirmButton(
                    label: context.l10n.privacy_holdToContinue_button,
                    holdDuration: const Duration(milliseconds: 1000),
                    hapticFeedback: gameState.settings.hapticFeedback,
                    onConfirmed: () {
                      if (isVotingPhase) {
                        context.go('/local/voting');
                      } else {
                        context.go('/local/reveal');
                      }
                    },
                  ).animate().fadeIn(delay: 600.ms, duration: 400.ms)
                else
                  PrimaryButton(
                    label: context.l10n.privacy_continue_button,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () {
                      if (isVotingPhase) {
                        context.go('/local/voting');
                      } else {
                        context.go('/local/reveal');
                      }
                    },
                  ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
