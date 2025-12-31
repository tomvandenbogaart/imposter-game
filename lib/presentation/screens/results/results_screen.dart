import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/vote_repository.dart';
import '../../providers/room_provider.dart';
import '../../providers/game_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/cards/glass_card.dart';

class ResultsScreen extends ConsumerStatefulWidget {
  final String roomId;

  const ResultsScreen({super.key, required this.roomId});

  @override
  ConsumerState<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends ConsumerState<ResultsScreen> {
  @override
  void initState() {
    super.initState();
    // Reset vote state for next round
    ref.read(voteNotifierProvider.notifier).reset();
  }

  Future<void> _playAgain() async {
    try {
      await startRound(widget.roomId);
      if (mounted) {
        context.go('/game/${widget.roomId}/reveal');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error starting new round: $e')),
        );
      }
    }
  }

  Future<void> _backToLobby() async {
    await ref.read(currentRoomProvider.notifier).updateStatus(RoomStatus.waiting);
    if (mounted) {
      context.go('/lobby/${widget.roomId}');
    }
  }

  Future<void> _leaveRoom() async {
    await ref.read(currentRoomProvider.notifier).leaveRoom();
    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomStreamProvider(widget.roomId));
    final playersAsync = ref.watch(playersStreamProvider(widget.roomId));
    final isHost = ref.watch(isHostProvider);

    final room = roomAsync.valueOrNull;
    final roundId = room?.currentRoundId;

    if (roundId == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final roundAsync = ref.watch(roundStreamProvider(roundId));
    final votesAsync = ref.watch(votesStreamProvider(roundId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Results Header
              roundAsync.when(
                data: (round) {
                  if (round == null) return const SizedBox.shrink();

                  return votesAsync.when(
                    data: (votes) {
                      final voteRepo = VoteRepository();
                      final mostVotedId = voteRepo.getMostVotedPlayer(votes);
                      final imposterCaught = mostVotedId == round.imposterPlayerId;

                      return _ResultsHeader(
                        imposterCaught: imposterCaught,
                        imposterPlayerId: round.imposterPlayerId,
                        players: playersAsync.valueOrNull ?? [],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Error: $e'),
              ),

              const SizedBox(height: 32),

              // Vote Results
              Expanded(
                child: votesAsync.when(
                  data: (votes) => _VoteResults(
                    votes: votes,
                    players: playersAsync.valueOrNull ?? [],
                    imposterPlayerId: roundAsync.valueOrNull?.imposterPlayerId,
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              if (isHost) ...[
                PrimaryButton(
                  label: 'Play Again',
                  icon: Icons.replay_rounded,
                  onPressed: _playAgain,
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
                const SizedBox(height: 12),
                SecondaryButton(
                  label: 'Back to Lobby',
                  onPressed: _backToLobby,
                ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2),
              ] else ...[
                Text(
                  'Waiting for host...',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ).animate().fadeIn(delay: 600.ms),
              ],

              const SizedBox(height: 12),

              TextButton(
                onPressed: _leaveRoom,
                child: Text(
                  'Leave Room',
                  style: AppTypography.button.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultsHeader extends StatelessWidget {
  final bool imposterCaught;
  final String? imposterPlayerId;
  final List<Player> players;

  const _ResultsHeader({
    required this.imposterCaught,
    required this.imposterPlayerId,
    required this.players,
  });

  @override
  Widget build(BuildContext context) {
    final imposter = players.where((p) => p.id == imposterPlayerId).firstOrNull;

    return Column(
      children: [
        Icon(
          imposterCaught ? Icons.celebration_rounded : Icons.sentiment_very_dissatisfied_rounded,
          size: 80,
          color: imposterCaught ? AppColors.winnerGold : AppColors.error,
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .scale(begin: const Offset(0.5, 0.5), curve: Curves.elasticOut),

        const SizedBox(height: 16),

        Text(
          imposterCaught ? 'Imposter Caught!' : 'Imposter Wins!',
          style: AppTypography.display.copyWith(
            color: imposterCaught ? AppColors.winnerGold : AppColors.error,
            fontSize: 32,
          ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),

        const SizedBox(height: 12),

        GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          gradient: AppColors.imposterGradient,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.psychology_rounded,
                color: AppColors.textPrimary,
              ),
              const SizedBox(width: 12),
              Text(
                'The imposter was ${imposter?.displayName ?? 'Unknown'}',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.9, 0.9)),
      ],
    );
  }
}

class _VoteResults extends StatelessWidget {
  final List<Vote> votes;
  final List<Player> players;
  final String? imposterPlayerId;

  const _VoteResults({
    required this.votes,
    required this.players,
    required this.imposterPlayerId,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate vote counts
    final voteCounts = <String, int>{};
    for (final vote in votes) {
      voteCounts[vote.votedPlayerId] = (voteCounts[vote.votedPlayerId] ?? 0) + 1;
    }

    // Sort players by vote count
    final sortedPlayers = List<Player>.from(players);
    sortedPlayers.sort((a, b) {
      final aVotes = voteCounts[a.id] ?? 0;
      final bVotes = voteCounts[b.id] ?? 0;
      return bVotes.compareTo(aVotes);
    });

    return ListView.builder(
      itemCount: sortedPlayers.length,
      itemBuilder: (context, index) {
        final player = sortedPlayers[index];
        final voteCount = voteCounts[player.id] ?? 0;
        final isImposter = player.id == imposterPlayerId;

        return _VoteResultTile(
          player: player,
          voteCount: voteCount,
          isImposter: isImposter,
          totalVotes: votes.length,
        )
            .animate()
            .fadeIn(delay: (index * 100 + 400).ms)
            .slideX(begin: index.isEven ? -0.1 : 0.1);
      },
    );
  }
}

class _VoteResultTile extends StatelessWidget {
  final Player player;
  final int voteCount;
  final bool isImposter;
  final int totalVotes;

  const _VoteResultTile({
    required this.player,
    required this.voteCount,
    required this.isImposter,
    required this.totalVotes,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalVotes > 0 ? voteCount / totalVotes : 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isImposter ? AppColors.error : AppColors.surfaceLight,
          width: isImposter ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: isImposter
                      ? AppColors.imposterGradient
                      : AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    player.displayName[0].toUpperCase(),
                    style: AppTypography.h2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Name and role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.displayName,
                      style: AppTypography.playerName,
                    ),
                    if (isImposter)
                      Text(
                        'IMPOSTER',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),

              // Vote count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$voteCount votes',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Vote bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.surfaceLight,
              valueColor: AlwaysStoppedAnimation<Color>(
                isImposter ? AppColors.error : AppColors.cyan,
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
