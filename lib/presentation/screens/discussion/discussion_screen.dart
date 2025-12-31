import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';
import '../../providers/room_provider.dart';
import '../../providers/game_provider.dart';
import '../../widgets/cards/glass_card.dart';

class DiscussionScreen extends ConsumerStatefulWidget {
  final String roomId;

  const DiscussionScreen({super.key, required this.roomId});

  @override
  ConsumerState<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends ConsumerState<DiscussionScreen> {
  @override
  void initState() {
    super.initState();
    _watchRoundState();
    _startTimer();
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
              if (round?.state == RoundState.voting) {
                context.go('/game/${widget.roomId}/voting');
              }
            },
          );
        }
      },
    );
  }

  void _startTimer() {
    // Get round and start timer
    final room = ref.read(roomStreamProvider(widget.roomId)).valueOrNull;
    if (room?.currentRoundId != null) {
      ref.read(roundStreamProvider(room!.currentRoundId!)).whenData((round) {
        if (round?.endsAt != null) {
          ref.read(timerProvider.notifier).startTimer(round!.endsAt!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomStreamProvider(widget.roomId));
    final playersAsync = ref.watch(playersStreamProvider(widget.roomId));
    final timerDuration = ref.watch(timerProvider);

    final minutes = timerDuration.inMinutes;
    final seconds = timerDuration.inSeconds % 60;
    final isUrgent = timerDuration.inSeconds < 30;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Timer
              _TimerDisplay(
                minutes: minutes,
                seconds: seconds,
                isUrgent: isUrgent,
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

              const SizedBox(height: 16),

              Text(
                'Discuss!',
                style: AppTypography.h1,
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 8),

              Text(
                'Ask questions to find the imposter',
                style: AppTypography.bodySmall,
              ).animate().fadeIn(delay: 300.ms),

              const SizedBox(height: 32),

              // Player Grid
              Expanded(
                child: playersAsync.when(
                  data: (players) => _PlayersGrid(players: players),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),

              const SizedBox(height: 24),

              // My card reminder
              roomAsync.when(
                data: (room) {
                  if (room?.currentRoundId == null) return const SizedBox.shrink();
                  return _MyCardReminder(roundId: room!.currentRoundId!);
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerDisplay extends StatelessWidget {
  final int minutes;
  final int seconds;
  final bool isUrgent;

  const _TimerDisplay({
    required this.minutes,
    required this.seconds,
    required this.isUrgent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        gradient: isUrgent ? AppColors.urgentGradient : AppColors.timerGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (isUrgent ? AppColors.error : AppColors.cyan).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
        style: AppTypography.timer,
      ),
    )
        .animate(target: isUrgent ? 1 : 0)
        .shake(hz: 4, curve: Curves.easeInOut, duration: 500.ms);
  }
}

class _PlayersGrid extends StatelessWidget {
  final List<Player> players;

  const _PlayersGrid({required this.players});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return _PlayerCard(player: player)
            .animate()
            .fadeIn(delay: (index * 100).ms)
            .scale(begin: const Offset(0.8, 0.8));
      },
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final Player player;

  const _PlayerCard({required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                player.displayName[0].toUpperCase(),
                style: AppTypography.h2.copyWith(
                  color: AppColors.background,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            player.displayName,
            style: AppTypography.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _MyCardReminder extends ConsumerWidget {
  final String roundId;

  const _MyCardReminder({required this.roundId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardAsync = ref.watch(myCardProvider(roundId));

    return cardAsync.when(
      data: (card) {
        if (card == null) return const SizedBox.shrink();
        final isImposter = card.cardType == CardType.imposter;

        return GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          gradient: isImposter
              ? AppColors.imposterGradient
              : AppColors.normalGradient,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isImposter ? Icons.psychology_rounded : Icons.lightbulb_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isImposter
                    ? 'Hint: ${card.payload['hint']}'
                    : 'Word: ${card.payload['word']}',
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2);
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
