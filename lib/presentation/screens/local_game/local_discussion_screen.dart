import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../providers/local_timer_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/local_game/timer_arc.dart';

class LocalDiscussionScreen extends ConsumerStatefulWidget {
  const LocalDiscussionScreen({super.key});

  @override
  ConsumerState<LocalDiscussionScreen> createState() =>
      _LocalDiscussionScreenState();
}

class _LocalDiscussionScreenState extends ConsumerState<LocalDiscussionScreen> {
  String? _starterPlayerId;

  @override
  void initState() {
    super.initState();
    // Select random player to start the discussion
    final gameState = ref.read(localGameProvider);
    if (gameState.players.isNotEmpty) {
      final random = Random();
      _starterPlayerId = gameState.players[random.nextInt(gameState.players.length)].id;
    }
    // Listen for timer expiration
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkTimerState();
    });
  }

  void _checkTimerState() {
    final timerState = ref.read(localTimerProvider);
    if (timerState.isExpired) {
      _goToVoting();
    }
  }

  void _goToVoting() {
    ref.read(localTimerProvider.notifier).stopTimer();
    ref.read(localGameProvider.notifier).startVoting();
    context.go('/local/privacy');
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(localGameProvider);
    final timerState = ref.watch(localTimerProvider);

    // Check if timer expired
    if (timerState.isExpired && timerState.isRunning) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _goToVoting());
    }

    final isUrgent = timerState.remaining.inSeconds <= 30;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Title
                Text(
                  'Discussion',
                  style: AppTypography.h2,
                ).animate().fadeIn(duration: 400.ms),

                const SizedBox(height: 8),

                Text(
                  'Find the imposter!',
                  style: AppTypography.bodySmall,
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                const SizedBox(height: 16),

                // Show who starts the discussion
                if (_starterPlayerId != null)
                  Builder(
                    builder: (context) {
                      final starter = gameState.players.firstWhere(
                        (p) => p.id == _starterPlayerId,
                        orElse: () => gameState.players.first,
                      );
                      return ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.primaryGradient.createShader(bounds),
                        child: Text(
                          '${starter.name} starts!',
                          style: AppTypography.h1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
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
                          );
                    },
                  ),

                const Spacer(),

                // Timer arc
                Stack(
                  alignment: Alignment.center,
                  children: [
                    TimerArc(
                      progress: timerState.progress,
                      size: 240,
                      strokeWidth: 16,
                      isUrgent: isUrgent,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timerState.formattedTime,
                          style: AppTypography.timer.copyWith(
                            color: isUrgent ? AppColors.error : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Always reserve space to prevent layout shift
                        Opacity(
                          opacity: timerState.isPaused ? 1.0 : 0.0,
                          child: Text(
                            'PAUSED',
                            style: AppTypography.buttonSmall.copyWith(
                              color: AppColors.warning,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms)
                    .scale(begin: const Offset(0.9, 0.9)),

                const SizedBox(height: 32),

                // Pause/Resume button (if enabled)
                if (gameState.settings.allowPause)
                  SecondaryButton(
                    label: timerState.isPaused ? 'Resume' : 'Pause',
                    icon: timerState.isPaused
                        ? Icons.play_arrow_rounded
                        : Icons.pause_rounded,
                    onPressed: () {
                      if (timerState.isPaused) {
                        ref.read(localTimerProvider.notifier).resumeTimer();
                      } else {
                        ref.read(localTimerProvider.notifier).pauseTimer();
                      }
                    },
                  ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

                const Spacer(),

                // Player list
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Players',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      gameState.players.map((p) => p.name).join('  •  '),
                      style: AppTypography.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ).animate().fadeIn(delay: 700.ms, duration: 400.ms),

                const SizedBox(height: 24),

                // Skip to vote button
                PrimaryButton(
                  label: 'Skip to Vote',
                  icon: Icons.how_to_vote_rounded,
                  onPressed: _goToVoting,
                ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
