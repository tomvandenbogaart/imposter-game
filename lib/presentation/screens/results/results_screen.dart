import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/word_repository.dart';
import '../../providers/room_provider.dart';
import '../../providers/game_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/decorations/party_background.dart';

class ResultsScreen extends ConsumerStatefulWidget {
  final String roomId;

  const ResultsScreen({super.key, required this.roomId});

  @override
  ConsumerState<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends ConsumerState<ResultsScreen> {
  Word? _word;
  int? _lastKnownPlayerCount;

  @override
  void initState() {
    super.initState();
    // Reset vote state for next round (delayed to avoid modifying provider during build)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(voteNotifierProvider.notifier).reset();
      _loadWord();
    });
  }

  void _checkForPlayerLeave(int currentCount) {
    print('🔵 _checkForPlayerLeave called: lastKnown=$_lastKnownPlayerCount, current=$currentCount');
    if (_lastKnownPlayerCount != null && currentCount < _lastKnownPlayerCount!) {
      print('🔴 Player left! prev=$_lastKnownPlayerCount, current=$currentCount');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A player has left the room'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    _lastKnownPlayerCount = currentCount;
  }

  Future<void> _loadWord() async {
    final room = ref.read(roomStreamProvider(widget.roomId)).valueOrNull;
    if (room?.currentRoundId == null) return;

    final roundAsync = ref.read(roundStreamProvider(room!.currentRoundId!));
    final round = roundAsync.valueOrNull;
    if (round?.wordId == null) return;

    final wordRepo = WordRepository();
    final word = await wordRepo.getWordById(round!.wordId!);
    if (mounted) {
      setState(() {
        _word = word;
      });
    }
  }

  Future<void> _playAgain() async {
    // Check if we have enough players
    final players = ref.read(playersStreamProvider(widget.roomId)).valueOrNull ?? [];
    if (players.length < 2) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Need at least 2 players to play. Returning to lobby.')),
      );
      // Go back to lobby to wait for more players
      await ref.read(currentRoomProvider.notifier).updateStatus(RoomStatus.waiting);
      if (mounted) {
        context.go('/lobby/${widget.roomId}');
      }
      return;
    }

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
    try {
      await ref.read(currentRoomProvider.notifier).leaveRoom();
    } catch (_) {
      // Ignore errors - just navigate home anyway
    }
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
    final players = playersAsync.valueOrNull ?? [];

    // Check for player leave after every rebuild
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkForPlayerLeave(players.length);
      }
    });

    if (roundId == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final roundAsync = ref.watch(roundStreamProvider(roundId));
    final round = roundAsync.valueOrNull;

    // Use stored result (calculated when voting ended, before any votes were deleted)
    final groupWins = round?.groupWins ?? false;
    final storedVoteResults = round?.voteResults ?? [];

    // Check for tie using stored vote results
    final maxVotes = storedVoteResults.isEmpty
        ? 0
        : storedVoteResults.map((v) => v.voteCount).reduce((a, b) => a > b ? a : b);
    final playersWithMaxVotes = storedVoteResults.where((v) => v.voteCount == maxVotes).length;
    final isTie = playersWithMaxVotes > 1 && maxVotes > 0;

    // Use stored imposter name (fallback to current player if still in room)
    final imposter = players.where((p) => p.id == round?.imposterPlayerId).firstOrNull;
    final imposterName = round?.imposterName ?? imposter?.displayName ?? 'Unknown';

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
                      'Round ${round?.roundNumber ?? 1}',
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
                          imposterName,
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
                          _word?.word ?? 'Loading...',
                          style: AppTypography.h3.copyWith(
                            color: AppColors.gold,
                          ),
                        ),
                        if (_word?.hint != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Hint: ${_word!.hint}',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ).animate().fadeIn(delay: 600.ms, duration: 400.ms),

                  const SizedBox(height: 16),

                  // Vote breakdown
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vote Results',
                          style: AppTypography.playerName.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...storedVoteResults.map((voteResult) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                if (voteResult.isImposter)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: const BoxDecoration(
                                      color: AppColors.imposterRed,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                Expanded(
                                  child: Text(
                                    voteResult.playerName,
                                    style: AppTypography.body.copyWith(
                                      color: voteResult.isImposter
                                          ? AppColors.imposterRed
                                          : AppColors.textPrimary,
                                      fontWeight: voteResult.isImposter
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${voteResult.voteCount} vote${voteResult.voteCount == 1 ? '' : 's'}',
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
                  if (isHost) ...[
                    // Show warning if not enough players
                    if (players.length < 2)
                      Text(
                        'Need at least 2 players to play (${players.length} connected)',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ).animate().fadeIn(),
                    if (players.length < 2)
                      const SizedBox(height: 8),
                    PrimaryButton(
                      label: 'Play Again',
                      icon: Icons.replay_rounded,
                      onPressed: players.length >= 2 ? _playAgain : null,
                    ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
                    const SizedBox(height: 12),
                    SecondaryButton(
                      label: 'Back to Lobby',
                      onPressed: _backToLobby,
                    ).animate().fadeIn(delay: 1000.ms, duration: 400.ms),
                  ] else ...[
                    Text(
                      'Waiting for host...',
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ).animate().fadeIn(delay: 900.ms),
                  ],

                  const SizedBox(height: 12),

                  SecondaryButton(
                    label: 'Leave Room',
                    icon: Icons.exit_to_app_rounded,
                    onPressed: _leaveRoom,
                  ).animate().fadeIn(delay: 1100.ms, duration: 400.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
