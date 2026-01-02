import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';
import '../../providers/local_game_provider.dart';
import '../../providers/ad_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/decorations/party_background.dart';

class LocalResultsScreen extends ConsumerStatefulWidget {
  const LocalResultsScreen({super.key});

  @override
  ConsumerState<LocalResultsScreen> createState() => _LocalResultsScreenState();
}

class _LocalResultsScreenState extends ConsumerState<LocalResultsScreen> {
  bool _hasShownAd = false;

  @override
  void initState() {
    super.initState();
    // Show interstitial ad when results screen loads (between rounds)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showAdIfNeeded();
    });
  }

  Future<void> _showAdIfNeeded() async {
    if (_hasShownAd) return;
    _hasShownAd = true;

    final adController = ref.read(adControllerProvider.notifier);
    await adController.showInterstitialIfNeeded();
  }

  Future<void> _goToNextRound() async {
    ref.read(localGameProvider.notifier).continueToNextRound();
    final success = await ref.read(localGameProvider.notifier).startRound();
    if (success && mounted) {
      context.go('/local/privacy');
    }
  }

  void _goToFinalResults() {
    ref.read(localGameProvider.notifier).showFinalResults();
    context.go('/local/final-results');
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(localGameProvider);
    final groupWins = gameState.groupWins;
    final isTie = gameState.isTie;
    final isFinalRound = gameState.isFinalRound;
    final correctVoters = gameState.correctVoters;

    // Find the imposter player
    final imposter = gameState.players.isEmpty
        ? null
        : gameState.players.cast<LocalPlayer?>().firstWhere(
              (p) => p?.id == gameState.imposterPlayerId,
              orElse: () => null,
            );

    if (imposter == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: ConfettiBurst(
          trigger: groupWins,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Round indicator
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.surfaceLight),
                    ),
                    child: Text(
                      'Round ${gameState.roundNumber} of ${gameState.settings.numberOfRounds}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.cyan,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  // Result title
                  Text(
                    groupWins ? 'Group Wins!' : 'Imposter Wins!',
                    style: AppTypography.h1.copyWith(
                      color: groupWins ? AppColors.gold : AppColors.imposterRed,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 600.ms)
                      .slideY(begin: 0.2),

                  const SizedBox(height: 4),

                  // Subtitle
                  Text(
                    isTie
                        ? 'The vote was tied!'
                        : groupWins
                            ? 'The imposter was found!'
                            : 'The imposter escaped!',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

                  const SizedBox(height: 20),

                  // Imposter reveal card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppColors.imposterGradient,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.imposterRed,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          imposter.name,
                          style: AppTypography.h3.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'was the Imposter',
                          style: AppTypography.caption.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

                  const SizedBox(height: 12),

                  // Word reveal card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.surfaceLight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          gameState.selectedWord?.word ?? 'Unknown',
                          style: AppTypography.h3.copyWith(
                            color: AppColors.gold,
                          ),
                        ),
                        if (gameState.selectedWord?.hint != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Hint: ${gameState.selectedWord!.hint}',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ).animate().fadeIn(delay: 600.ms, duration: 400.ms),

                  const SizedBox(height: 16),

                  // Current standings with points awarded indicator
                  if (gameState.playerScores.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: correctVoters.isNotEmpty
                              ? AppColors.cyan.withValues(alpha: 0.3)
                              : AppColors.surfaceLight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (correctVoters.isNotEmpty) ...[
                                const Icon(
                                  Icons.star_rounded,
                                  color: AppColors.cyan,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                'Current Standings',
                                style: AppTypography.playerName.copyWith(
                                  color: correctVoters.isNotEmpty
                                      ? AppColors.cyan
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...gameState.leaderboard.take(3).map((entry) {
                            final player = gameState.players.firstWhere(
                              (p) => p.id == entry.key,
                              orElse: () => const LocalPlayer(id: '', name: 'Unknown'),
                            );
                            final scoredThisRound = correctVoters.contains(entry.key);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      player.name,
                                      style: AppTypography.body.copyWith(
                                        color: scoredThisRound
                                            ? AppColors.cyan
                                            : AppColors.textPrimary,
                                        fontWeight: scoredThisRound
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  if (scoredThisRound)
                                    Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.cyan.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '+1',
                                        style: AppTypography.caption.copyWith(
                                          color: AppColors.cyan,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  Text(
                                    '${entry.value} pts',
                                    style: AppTypography.body.copyWith(
                                      color: AppColors.cyan,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ).animate().fadeIn(delay: 700.ms, duration: 400.ms),

                  const SizedBox(height: 24),

                  // Action buttons
                  if (isFinalRound) ...[
                    PrimaryButton(
                      label: 'See Final Results',
                      icon: Icons.emoji_events_rounded,
                      onPressed: _goToFinalResults,
                    ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
                    const SizedBox(height: 12),
                    SecondaryButton(
                      label: 'Play Again',
                      icon: Icons.replay_rounded,
                      onPressed: () {
                        ref.read(localGameProvider.notifier).resetForNextRound();
                        context.go('/local');
                      },
                    ).animate().fadeIn(delay: 1000.ms, duration: 400.ms),
                  ] else ...[
                    PrimaryButton(
                      label: 'Next Round',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: _goToNextRound,
                    ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
                    const SizedBox(height: 12),
                    SecondaryButton(
                      label: 'End Game Early',
                      icon: Icons.stop_rounded,
                      onPressed: _goToFinalResults,
                    ).animate().fadeIn(delay: 1000.ms, duration: 400.ms),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
