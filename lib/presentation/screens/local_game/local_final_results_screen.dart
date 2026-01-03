import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';
import '../../providers/local_game_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/decorations/party_background.dart';

class LocalFinalResultsScreen extends ConsumerWidget {
  const LocalFinalResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(localGameProvider);
    final winners = gameState.winners;
    final leaderboard = gameState.leaderboard;

    // Get winner player names
    final winnerNames = winners.map((id) {
      final player = gameState.players.firstWhere(
        (p) => p.id == id,
        orElse: () => const LocalPlayer(id: '', name: 'Unknown'),
      );
      return player.name;
    }).toList();

    final isMultipleWinners = winnerNames.length > 1;
    final hasAnyPoints = leaderboard.any((e) => e.value > 0);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: ConfettiBurst(
          trigger: true,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Winner header section
                  Column(
                    children: [
                      // Trophy icon
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          gradient: AppColors.celebrationGradient,
                          borderRadius: BorderRadius.circular(44),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gold.withValues(alpha: 0.4),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.emoji_events_rounded,
                          size: 44,
                          color: Colors.white,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .scale(
                            begin: const Offset(0.5, 0.5),
                            curve: Curves.elasticOut,
                            duration: 800.ms,
                          ),

                      const SizedBox(height: 16),

                      // Winner text
                      Text(
                        hasAnyPoints
                            ? (isMultipleWinners ? 'It\'s a Tie!' : 'Winner!')
                            : 'Game Over!',
                        style: AppTypography.display.copyWith(
                          color: AppColors.gold,
                        ),
                      ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

                      if (hasAnyPoints && winnerNames.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          winnerNames.join(' & '),
                          style: AppTypography.h2.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                      ],

                      if (!hasAnyPoints) ...[
                        const SizedBox(height: 4),
                        Text(
                          'No one scored any points!',
                          style: AppTypography.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
                      ],
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Final Leaderboard - takes most of the space
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.surfaceLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.leaderboard_rounded,
                                color: AppColors.gold,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Final Standings',
                                style: AppTypography.h3,
                              ),
                              const Spacer(),
                              Text(
                                '${leaderboard.length} players',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: leaderboard.length,
                              itemBuilder: (context, index) {
                                final entry = leaderboard[index];
                                final player = gameState.players.firstWhere(
                                  (p) => p.id == entry.key,
                                  orElse: () => const LocalPlayer(id: '', name: 'Unknown'),
                                );
                                final isWinner = winners.contains(entry.key) && entry.value > 0;

                                return _LeaderboardRow(
                                  rank: index + 1,
                                  playerName: player.name,
                                  score: entry.value,
                                  isWinner: isWinner,
                                ).animate().fadeIn(
                                  delay: Duration(milliseconds: 700 + (50 * index)),
                                  duration: 300.ms,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 650.ms, duration: 400.ms),
                  ),

                  const SizedBox(height: 16),

                  // Action buttons - more compact
                  PrimaryButton(
                    label: 'Play Again',
                    icon: Icons.replay_rounded,
                    onPressed: () {
                      ref.read(localGameProvider.notifier).resetForNextRound();
                      context.go('/local');
                    },
                  ).animate().fadeIn(delay: 1100.ms, duration: 400.ms),

                  const SizedBox(height: 10),

                  SecondaryButton(
                    label: 'Exit to Home',
                    icon: Icons.home_rounded,
                    onPressed: () {
                      ref.read(localGameProvider.notifier).resetAll();
                      context.go('/');
                    },
                  ).animate().fadeIn(delay: 1200.ms, duration: 400.ms),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  final int rank;
  final String playerName;
  final int score;
  final bool isWinner;

  const _LeaderboardRow({
    required this.rank,
    required this.playerName,
    required this.score,
    required this.isWinner,
  });

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return AppColors.gold;
      case 2:
        return Colors.grey.shade400;
      case 3:
        return Colors.brown.shade300;
      default:
        return AppColors.surfaceLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isWinner ? AppColors.gold.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isWinner ? AppColors.gold : AppColors.surfaceLight,
          width: isWinner ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _getRankColor(),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                '$rank',
                style: AppTypography.bodySmall.copyWith(
                  color: rank <= 3 ? Colors.white : AppColors.textMuted,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Player name
          Expanded(
            child: Text(
              playerName,
              style: AppTypography.body.copyWith(
                color: isWinner ? AppColors.gold : AppColors.textPrimary,
                fontWeight: isWinner ? FontWeight.w600 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Score
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isWinner
                  ? AppColors.gold.withValues(alpha: 0.2)
                  : AppColors.cyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$score pts',
              style: AppTypography.bodySmall.copyWith(
                color: isWinner ? AppColors.gold : AppColors.cyan,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
