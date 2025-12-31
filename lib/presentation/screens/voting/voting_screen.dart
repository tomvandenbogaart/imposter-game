import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';
import '../../providers/room_provider.dart';
import '../../providers/game_provider.dart';

class VotingScreen extends ConsumerStatefulWidget {
  final String roomId;

  const VotingScreen({super.key, required this.roomId});

  @override
  ConsumerState<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends ConsumerState<VotingScreen> {
  String? _selectedPlayerId;

  @override
  void initState() {
    super.initState();
    _watchRoundState();
  }

  void _watchRoundState() {
    ref.listenManual(
      roomStreamProvider(widget.roomId),
      (previous, next) {
        final room = next.valueOrNull;
        if (room?.currentRoundId != null) {
          ref.listenManual(
            roundStreamProvider(room!.currentRoundId!),
            (prevRound, nextRound) {
              final round = nextRound.valueOrNull;
              if (round?.state == RoundState.results) {
                context.go('/game/${widget.roomId}/results');
              }
            },
          );
        }
      },
    );
  }

  Future<void> _submitVote() async {
    if (_selectedPlayerId == null) return;

    final room = ref.read(roomStreamProvider(widget.roomId)).valueOrNull;
    if (room?.currentRoundId == null) return;

    try {
      await ref.read(voteNotifierProvider.notifier).submitVote(
        room!.currentRoundId!,
        _selectedPlayerId!,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting vote: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomStreamProvider(widget.roomId));
    final playersAsync = ref.watch(playersStreamProvider(widget.roomId));
    final currentPlayerAsync = ref.watch(currentPlayerProvider);
    final voteState = ref.watch(voteNotifierProvider);

    final hasVoted = voteState.valueOrNull != null;
    final currentPlayerId = currentPlayerAsync.valueOrNull?.id;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Who is the Imposter?',
                style: AppTypography.h1,
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: 8),

              Text(
                hasVoted ? 'Waiting for others...' : 'Vote for the imposter',
                style: AppTypography.bodySmall,
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 24),

              // Vote Progress
              roomAsync.when(
                data: (room) {
                  if (room?.currentRoundId == null) return const SizedBox.shrink();
                  return _VoteProgress(
                    roundId: room!.currentRoundId!,
                    totalPlayers: playersAsync.valueOrNull?.length ?? 0,
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // Player Grid for voting
              Expanded(
                child: playersAsync.when(
                  data: (players) => GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      final player = players[index];
                      final isMe = player.id == currentPlayerId;
                      final isSelected = player.id == _selectedPlayerId;

                      return _VoteCard(
                        player: player,
                        isMe: isMe,
                        isSelected: isSelected,
                        isDisabled: isMe || hasVoted,
                        onTap: isMe || hasVoted
                            ? null
                            : () => setState(() => _selectedPlayerId = player.id),
                      )
                          .animate()
                          .fadeIn(delay: (index * 100).ms)
                          .scale(begin: const Offset(0.9, 0.9));
                    },
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),

              const SizedBox(height: 24),

              // Submit Vote Button
              if (!hasVoted)
                GestureDetector(
                  onTap: _selectedPlayerId != null ? _submitVote : null,
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: _selectedPlayerId != null
                          ? AppColors.primaryGradient
                          : null,
                      color: _selectedPlayerId == null ? AppColors.surfaceLight : null,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: voteState.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.background,
                              ),
                            )
                          : Text(
                              'Submit Vote',
                              style: AppTypography.button.copyWith(
                                color: _selectedPlayerId != null
                                    ? AppColors.background
                                    : AppColors.textMuted,
                              ),
                            ),
                    ),
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2)
              else
                Text(
                  'Vote submitted!',
                  style: AppTypography.body.copyWith(
                    color: AppColors.success,
                  ),
                ).animate().fadeIn().scale(),
            ],
          ),
        ),
      ),
    );
  }
}

class _VoteProgress extends ConsumerWidget {
  final String roundId;
  final int totalPlayers;

  const _VoteProgress({required this.roundId, required this.totalPlayers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final votesAsync = ref.watch(votesStreamProvider(roundId));

    return votesAsync.when(
      data: (votes) {
        final voteCount = votes.length;
        final progress = totalPlayers > 0 ? voteCount / totalPlayers : 0.0;

        return Column(
          children: [
            Text(
              '$voteCount / $totalPlayers votes',
              style: AppTypography.bodySmall,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.surfaceLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
                minHeight: 8,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 300.ms);
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _VoteCard extends StatelessWidget {
  final Player player;
  final bool isMe;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  const _VoteCard({
    required this.player,
    required this.isMe,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          color: isSelected ? null : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.cyan
                : isMe
                    ? AppColors.textMuted
                    : AppColors.surfaceLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  player.displayName[0].toUpperCase(),
                  style: AppTypography.h2.copyWith(
                    color: isSelected ? AppColors.textPrimary : AppColors.cyan,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              player.displayName,
              style: AppTypography.playerName.copyWith(
                color: isSelected
                    ? AppColors.textPrimary
                    : isMe
                        ? AppColors.textMuted
                        : AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (isMe)
              Text(
                '(You)',
                style: AppTypography.caption,
              ),
          ],
        ),
      ),
    );
  }
}
