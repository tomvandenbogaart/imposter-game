import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/vote_repository.dart';
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
  bool _navigationTriggered = false;

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
    final room = roomAsync.valueOrNull;

    // Watch round state and navigate to results when ready
    if (room?.currentRoundId != null) {
      final roundAsync = ref.watch(roundStreamProvider(room!.currentRoundId!));
      final round = roundAsync.valueOrNull;

      if (round?.state == RoundState.results && !_navigationTriggered) {
        _navigationTriggered = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.go('/game/${widget.roomId}/results');
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.screenPadding),
          child: Column(
            children: [
              Text(
                'Who is the Imposter?',
                style: AppTypography.h1,
              ).animate().fadeIn(duration: 400.ms),

              SizedBox(height: 8.h),

              Text(
                hasVoted ? 'Waiting for others...' : 'Vote for the imposter',
                style: AppTypography.bodySmall,
              ).animate().fadeIn(delay: 200.ms),

              SizedBox(height: 24.h),

              // Vote Progress
              roomAsync.when(
                data: (room) {
                  if (room?.currentRoundId == null) return const SizedBox.shrink();
                  final players = playersAsync.valueOrNull ?? [];
                  print('🟡 Creating _VoteProgress with roundId=${room!.currentRoundId}, totalPlayers=${players.length}');
                  return _VoteProgress(
                    roundId: room.currentRoundId!,
                    totalPlayers: players.length,
                    players: players,
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

              SizedBox(height: 24.h),

              // Player Grid for voting
              Expanded(
                child: playersAsync.when(
                  data: (players) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.votingGridColumns,
                      childAspectRatio: context.isTablet ? 1.0 : 0.85,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
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

              SizedBox(height: 24.h),

              // Submit Vote Button
              if (!hasVoted)
                GestureDetector(
                  onTap: _selectedPlayerId != null ? _submitVote : null,
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: _selectedPlayerId != null
                          ? AppColors.primaryGradient
                          : null,
                      color: _selectedPlayerId == null ? AppColors.surfaceLight : null,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: voteState.isLoading
                          ? SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.w,
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

class _VoteProgress extends ConsumerStatefulWidget {
  final String roundId;
  final int totalPlayers;
  final List<Player> players;

  const _VoteProgress({
    required this.roundId,
    required this.totalPlayers,
    required this.players,
  });

  @override
  ConsumerState<_VoteProgress> createState() => _VoteProgressState();
}

class _VoteProgressState extends ConsumerState<_VoteProgress> {
  bool _transitionTriggered = false;

  void _checkAllVoted(int voteCount, List<Vote> votes) {
    print('🟡 _checkAllVoted: voteCount=$voteCount, totalPlayers=${widget.totalPlayers}, triggered=$_transitionTriggered');
    if (voteCount >= widget.totalPlayers &&
        widget.totalPlayers > 0 &&
        !_transitionTriggered) {
      _transitionTriggered = true;
      print('🟢 All votes in! Calculating and saving result...');
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          final repository = ref.read(roundRepositoryProvider);
          final round = await repository.getRoundById(widget.roundId);

          // Calculate result now before any votes are deleted
          final voteRepo = VoteRepository();
          final mostVotedId = voteRepo.getMostVotedPlayer(votes);
          final groupWins = mostVotedId == round?.imposterPlayerId;

          // Build vote counts per player
          final voteCounts = <String, int>{};
          for (final vote in votes) {
            voteCounts[vote.votedPlayerId] = (voteCounts[vote.votedPlayerId] ?? 0) + 1;
          }

          // Find imposter name
          final imposter = widget.players.where((p) => p.id == round?.imposterPlayerId).firstOrNull;
          final imposterName = imposter?.displayName;

          // Build vote results snapshot with player names
          final voteResults = widget.players.map((player) {
            return VoteResult(
              playerId: player.id,
              playerName: player.displayName,
              voteCount: voteCounts[player.id] ?? 0,
              isImposter: player.id == round?.imposterPlayerId,
            );
          }).toList();

          print('🟢 Result: groupWins=$groupWins, mostVotedId=$mostVotedId, imposterId=${round?.imposterPlayerId}, imposterName=$imposterName');

          // Save result and transition to results state
          await repository.saveRoundResult(
            roundId: widget.roundId,
            groupWins: groupWins,
            mostVotedPlayerId: mostVotedId,
            imposterName: imposterName,
            voteResults: voteResults,
          );
          print('🟢 Round result saved and state updated to results');
        } catch (e) {
          print('🔴 Error saving round result: $e');
          // Ignore - another player may have already updated
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final votesAsync = ref.watch(votesStreamProvider(widget.roundId));

    return votesAsync.when(
      data: (votes) {
        final voteCount = votes.length;
        final progress =
            widget.totalPlayers > 0 ? voteCount / widget.totalPlayers : 0.0;

        // Check if all players have voted
        _checkAllVoted(voteCount, votes);

        return Column(
          children: [
            Text(
              '$voteCount / ${widget.totalPlayers} votes',
              style: AppTypography.bodySmall,
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.surfaceLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.cyan),
                minHeight: 8.h,
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
    final gradient = isSelected
        ? AppColors.primaryGradient
        : AppColors.surfaceGradient;

    final borderColor = isSelected ? AppColors.gold : AppColors.surfaceLight;

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.orange.withValues(alpha: 0.4),
                      blurRadius: 12.r,
                      offset: Offset(0, 4.h),
                    ),
                  ]
                : null,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  player.displayName,
                  style: AppTypography.h3.copyWith(
                    color: isDisabled
                        ? AppColors.textMuted
                        : isSelected
                            ? AppColors.background
                            : AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isMe) ...[
                  SizedBox(height: 4.h),
                  Text(
                    '(You)',
                    style: AppTypography.caption.copyWith(
                      color: isSelected
                          ? AppColors.background
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
