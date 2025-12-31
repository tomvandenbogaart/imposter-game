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

class RoundRevealScreen extends ConsumerStatefulWidget {
  final String roomId;

  const RoundRevealScreen({super.key, required this.roomId});

  @override
  ConsumerState<RoundRevealScreen> createState() => _RoundRevealScreenState();
}

class _RoundRevealScreenState extends ConsumerState<RoundRevealScreen> {
  bool _isRevealed = false;

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
              if (round?.state == RoundState.discussion) {
                context.go('/game/${widget.roomId}/discussion');
              }
            },
          );
        }
      },
    );
  }

  void _revealCard() {
    setState(() => _isRevealed = true);
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomStreamProvider(widget.roomId));
    final room = roomAsync.valueOrNull;
    final roundId = room?.currentRoundId;

    if (roundId == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final cardAsync = ref.watch(myCardProvider(roundId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Role',
                style: AppTypography.h1,
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: 8),

              Text(
                _isRevealed ? 'Remember your card!' : 'Tap to reveal',
                style: AppTypography.bodySmall,
              ).animate().fadeIn(delay: 200.ms),

              const SizedBox(height: 48),

              // Card
              cardAsync.when(
                data: (card) => GestureDetector(
                  onTap: !_isRevealed ? _revealCard : null,
                  child: AnimatedSwitcher(
                    duration: 600.ms,
                    child: _isRevealed && card != null
                        ? _RevealedCard(card: card)
                        : _HiddenCard(),
                  ),
                ),
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Error: $e'),
              ),

              const SizedBox(height: 48),

              if (_isRevealed)
                Text(
                  'Discuss with other players to find the imposter!',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _HiddenCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: 280,
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.touch_app_rounded,
            size: 64,
            color: AppColors.cyan,
          ),
          const SizedBox(height: 24),
          Text(
            'TAP TO REVEAL',
            style: AppTypography.h3.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(duration: 2.seconds, color: AppColors.cyan.withValues(alpha: 0.3));
  }
}

class _RevealedCard extends StatelessWidget {
  final PlayerCard card;

  const _RevealedCard({required this.card});

  @override
  Widget build(BuildContext context) {
    final isImposter = card.cardType == CardType.imposter;

    return GlassCard(
      width: 280,
      height: 400,
      gradient: isImposter ? AppColors.imposterGradient : AppColors.normalGradient,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isImposter ? Icons.psychology_rounded : Icons.lightbulb_rounded,
            size: 64,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 24),
          Text(
            isImposter ? 'IMPOSTER' : 'WORD',
            style: AppTypography.cardTitle,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isImposter
                  ? card.payload['hint'] as String? ?? 'Unknown'
                  : card.payload['word'] as String? ?? 'Unknown',
              style: AppTypography.cardWord,
              textAlign: TextAlign.center,
            ),
          ),
          if (isImposter) ...[
            const SizedBox(height: 16),
            Text(
              'Blend in and guess the word!',
              style: AppTypography.hint,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOut);
  }
}
