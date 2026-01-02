import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';
import '../../providers/room_provider.dart';
import '../../providers/game_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/local_game/timer_arc.dart';
import '../../widgets/buttons/primary_button.dart';

class DiscussionScreen extends ConsumerStatefulWidget {
  final String roomId;

  const DiscussionScreen({super.key, required this.roomId});

  @override
  ConsumerState<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends ConsumerState<DiscussionScreen> {
  String? _starterPlayerName;
  bool _timerStarted = false;
  bool _hasVotedToSkip = false;
  bool _timerExpiredHandled = false;

  @override
  void initState() {
    super.initState();
    _selectStarterPlayer();
  }

  void _selectStarterPlayer() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final players = ref.read(playersStreamProvider(widget.roomId)).valueOrNull;
      if (players != null && players.isNotEmpty) {
        final random = Random();
        final starter = players[random.nextInt(players.length)];
        setState(() {
          _starterPlayerName = starter.displayName;
        });
      }
    });
  }

  void _startTimerIfNeeded(Round round) {
    if (_timerStarted) return;
    if (round.endsAt != null) {
      _timerStarted = true;
      ref.read(timerProvider.notifier).startTimer(round.endsAt!);
    }
  }

  void _toggleSkipVote(String? myPlayerId) async {
    final room = ref.read(roomStreamProvider(widget.roomId)).valueOrNull;
    if (room?.currentRoundId == null || myPlayerId == null) {
      print('🔴 Skip vote failed: roundId=${room?.currentRoundId}, playerId=$myPlayerId');
      return;
    }

    print('🟢 Toggling skip vote for player $myPlayerId');
    final repository = ref.read(skipVoteRepositoryProvider);

    try {
      if (_hasVotedToSkip) {
        await repository.removeSkipVote(room!.currentRoundId!, myPlayerId);
        setState(() {
          _hasVotedToSkip = false;
        });
      } else {
        await repository.submitSkipVote(room!.currentRoundId!, myPlayerId);
        setState(() {
          _hasVotedToSkip = true;
        });
      }
      print('🟢 Skip vote toggled successfully');
    } catch (e) {
      print('🔴 Skip vote error: $e');
    }
  }

  void _transitionToVoting(String roundId) async {
    if (_timerExpiredHandled) return;
    _timerExpiredHandled = true;

    print('🟢 Timer expired, transitioning to voting');
    try {
      final repository = ref.read(roundRepositoryProvider);
      await repository.updateRoundState(roundId, RoundState.voting);
    } catch (e) {
      print('🔴 Error transitioning to voting: $e');
    }
  }

  void _checkAllSkipped(int skipCount, int playerCount, String roundId) {
    if (skipCount >= playerCount && playerCount > 0) {
      // All players voted to skip, transition to voting
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          final repository = ref.read(roundRepositoryProvider);
          await repository.updateRoundState(roundId, RoundState.voting);
        } catch (e) {
          // Ignore - another player may have already updated
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomStreamProvider(widget.roomId));
    final playersAsync = ref.watch(playersStreamProvider(widget.roomId));
    final timerDuration = ref.watch(timerProvider);
    final room = roomAsync.valueOrNull;

    // Derive myPlayerId reactively from watched players stream
    final user = ref.watch(currentUserProvider);
    final players = playersAsync.valueOrNull ?? [];
    final myPlayerId = players.where((p) => p.userId == user?.id).firstOrNull?.id;

    // Watch round for state changes
    Round? round;
    if (room?.currentRoundId != null) {
      final roundAsync = ref.watch(roundStreamProvider(room!.currentRoundId!));
      round = roundAsync.valueOrNull;

      // Start timer when we have the round
      if (round != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startTimerIfNeeded(round!);
        });
      }

      // Navigate to voting when state changes
      if (round?.state == RoundState.voting) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.go('/game/${widget.roomId}/voting');
          }
        });
      }

      // Handle timer expiry - transition to voting when timer reaches zero
      if (_timerStarted && timerDuration.inSeconds <= 0 && !_timerExpiredHandled) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _transitionToVoting(room.currentRoundId!);
        });
      }
    }

    // Calculate timer progress
    final totalDuration = 120; // 2 minutes
    final remainingSeconds = timerDuration.inSeconds;
    final progress = remainingSeconds / totalDuration;
    final isUrgent = remainingSeconds <= 30;

    final minutes = timerDuration.inMinutes;
    final seconds = timerDuration.inSeconds % 60;
    final formattedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.screenPadding),
            child: Column(
              children: [
                // Title
                Text(
                  'Discussion',
                  style: AppTypography.h2,
                ).animate().fadeIn(duration: 400.ms),

                SizedBox(height: 8.h),

                Text(
                  'Find the imposter!',
                  style: AppTypography.bodySmall,
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                SizedBox(height: 16.h),

                // Show who starts the discussion
                if (_starterPlayerName != null)
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppColors.primaryGradient.createShader(bounds),
                    child: Text(
                      '$_starterPlayerName starts!',
                      style: AppTypography.h1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 36.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 400.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        duration: 400.ms,
                        curve: Curves.elasticOut,
                      ),

                const Spacer(),

                // Timer arc
                Stack(
                  alignment: Alignment.center,
                  children: [
                    TimerArc(
                      progress: progress.clamp(0.0, 1.0),
                      size: context.isTablet ? 300.w : 240.w,
                      strokeWidth: 16.w,
                      isUrgent: isUrgent,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          formattedTime,
                          style: AppTypography.timer.copyWith(
                            color: isUrgent ? AppColors.error : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms)
                    .scale(begin: const Offset(0.9, 0.9)),

                const Spacer(),

                // Player list
                playersAsync.when(
                  data: (players) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Players',
                        style: AppTypography.caption,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        players.map((p) => p.displayName).join('  •  '),
                        style: AppTypography.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ).animate().fadeIn(delay: 700.ms, duration: 400.ms),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

                SizedBox(height: 24.h),

                // Skip to vote button with counter
                Builder(
                  builder: (context) {
                    final playerCount = players.length;

                    // Watch skip votes for this round
                    int skipCount = 0;
                    if (room?.currentRoundId != null) {
                      final skipVotesAsync = ref.watch(skipVotesStreamProvider(room!.currentRoundId!));
                      skipCount = skipVotesAsync.valueOrNull?.length ?? 0;

                      // Check if all players voted to skip
                      _checkAllSkipped(skipCount, playerCount, room.currentRoundId!);
                    }

                    final buttonLabel = 'Skip to Vote ($skipCount/$playerCount)';

                    return PrimaryButton(
                      label: buttonLabel,
                      icon: _hasVotedToSkip ? Icons.check_rounded : Icons.how_to_vote_rounded,
                      onPressed: () => _toggleSkipVote(myPlayerId),
                    );
                  },
                ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
