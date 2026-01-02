import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class RoundRevealScreen extends ConsumerStatefulWidget {
  final String roomId;

  const RoundRevealScreen({super.key, required this.roomId});

  @override
  ConsumerState<RoundRevealScreen> createState() => _RoundRevealScreenState();
}

class _RoundRevealScreenState extends ConsumerState<RoundRevealScreen> {
  Timer? _countdownTimer;
  int _secondsRemaining = 10;
  bool _transitionTriggered = false;
  DateTime? _revealEndsAt;
  String? _activeRoundId;

  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown(String roundId, DateTime revealEndsAt) {
    // Only start once per round
    if (_activeRoundId == roundId) return;
    _activeRoundId = roundId;
    _revealEndsAt = revealEndsAt;

    // Cancel any existing timer
    _countdownTimer?.cancel();

    // Update immediately
    _updateCountdown();

    // Then update every second
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        _updateCountdown();
      }
    });
  }

  void _updateCountdown() {
    if (_revealEndsAt == null || _activeRoundId == null) return;

    final remaining = _revealEndsAt!.difference(DateTime.now());
    final seconds = remaining.inSeconds.clamp(0, 60);

    if (mounted) {
      setState(() {
        _secondsRemaining = seconds;
      });
    }

    if (seconds <= 0 && !_transitionTriggered) {
      print('🟢 Countdown reached 0, transitioning to discussion');
      _transitionToDiscussion(_activeRoundId!);
    }
  }

  Future<void> _transitionToDiscussion(String roundId) async {
    if (_transitionTriggered) return;
    _transitionTriggered = true;
    _countdownTimer?.cancel();

    print('🟢 _transitionToDiscussion called for round $roundId');

    // Update round state to discussion (any player can do this, first one wins)
    try {
      final repository = ref.read(roundRepositoryProvider);
      await repository.updateRoundState(roundId, RoundState.discussion);
      print('🟢 Round state updated to discussion');
    } catch (e) {
      print('🔴 Error updating round state: $e');
      // Ignore errors - another player may have already updated it
    }

    // Navigate immediately after updating state
    if (mounted) {
      print('🟢 Navigating to discussion screen');
      context.go('/game/${widget.roomId}/discussion');
    }
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

    // Watch round for state changes and revealEndsAt
    final roundAsync = ref.watch(roundStreamProvider(roundId));
    final round = roundAsync.valueOrNull;

    // Start countdown when we get revealEndsAt
    if (round?.revealEndsAt != null && _activeRoundId != roundId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startCountdown(roundId, round!.revealEndsAt!);
      });
    }

    // Navigate to discussion when state changes
    if (round?.state == RoundState.discussion && !_transitionTriggered) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.go('/game/${widget.roomId}/discussion');
        }
      });
    }

    final cardAsync = ref.watch(myCardProvider(roundId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.screenPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Card display (auto-revealed)
                cardAsync.when(
                  data: (card) {
                    final isImposter = card?.cardType == CardType.imposter;
                    final headerText = isImposter
                        ? context.l10n.cardReveal_imposter_title
                        : 'Your Word';
                    final subtitleText = isImposter
                        ? context.l10n.cardReveal_blendIn
                        : context.l10n.cardReveal_findImposter;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          headerText,
                          style: AppTypography.h2,
                        ).animate().fadeIn(duration: 400.ms),

                        SizedBox(height: 8.h),

                        Text(
                          subtitleText,
                          style: AppTypography.bodySmall,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                        SizedBox(height: 32.h),

                        // Card is always revealed (no flip card needed)
                        SizedBox(
                          width: context.cardWidth,
                          height: context.cardHeight,
                          child: card != null
                              ? _RevealedCard(card: card)
                              : const SizedBox(),
                        ).animate().fadeIn(delay: 300.ms, duration: 600.ms)
                            .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOut),
                      ],
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text('Error: $e'),
                ),

                SizedBox(height: 32.h),

                // Countdown timer
                Text(
                  'Discussion starts in $_secondsRemaining...',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RevealedCard extends StatelessWidget {
  final PlayerCard card;

  const _RevealedCard({required this.card});

  @override
  Widget build(BuildContext context) {
    final isImposter = card.cardType == CardType.imposter;
    return isImposter
        ? _buildImposterCard(context)
        : _buildWordCard(context);
  }

  /// Innocent card - Beige parchment style with golden border
  Widget _buildWordCard(BuildContext context) {
    const parchmentLight = Color(0xFFF5E6C8);
    const parchmentDark = Color(0xFFE8D4A8);
    const borderGold = Color(0xFFD4A030);
    const borderOrange = Color(0xFFE85A20);

    final word = card.payload['word'] as String? ?? context.l10n.cardReveal_unknown;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: borderGold.withValues(alpha: 0.4),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [borderOrange, borderGold, borderOrange],
          ),
        ),
        padding: EdgeInsets.all(6.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [parchmentLight, parchmentDark],
            ),
          ),
          child: Stack(
            children: [
              // Corner decorations
              Positioned(
                top: 8.h,
                left: 8.w,
                child: _buildCornerDecoration(),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Transform.flip(
                  flipX: true,
                  child: _buildCornerDecoration(),
                ),
              ),
              Positioned(
                bottom: 8.h,
                left: 8.w,
                child: Transform.flip(
                  flipY: true,
                  child: _buildCornerDecoration(),
                ),
              ),
              Positioned(
                bottom: 8.h,
                right: 8.w,
                child: Transform.flip(
                  flipX: true,
                  flipY: true,
                  child: _buildCornerDecoration(),
                ),
              ),
              // Main content
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Word display
                        Text(
                          word,
                          style: AppTypography.h1.copyWith(
                            color: const Color(0xFF2D1B0E),
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        // Instructions
                        Text(
                          context.l10n.cardReveal_findImposter,
                          style: AppTypography.caption.copyWith(
                            color: const Color(0xFF5D4830),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCornerDecoration() {
    return Container(
      width: 24.w,
      height: 24.h,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: const Color(0xFFD4A030).withValues(alpha: 0.6), width: 2),
          left: BorderSide(color: const Color(0xFFD4A030).withValues(alpha: 0.6), width: 2),
        ),
      ),
    );
  }

  /// Imposter card - Dark fiery style with glowing red border
  Widget _buildImposterCard(BuildContext context) {
    const darkCore = Color(0xFF1A0A0A);
    const darkEdge = Color(0xFF2D0A0A);
    const glowRed = Color(0xFFE83030);
    const glowOrange = Color(0xFFFF6B20);

    final hint = card.payload['hint'] as String? ?? context.l10n.cardReveal_noHint;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          // Outer red glow
          BoxShadow(
            color: glowRed.withValues(alpha: 0.6),
            blurRadius: 30.r,
            spreadRadius: 2,
          ),
          // Inner orange glow
          BoxShadow(
            color: glowOrange.withValues(alpha: 0.3),
            blurRadius: 20.r,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              glowOrange.withValues(alpha: 0.8),
              glowRed,
              glowOrange.withValues(alpha: 0.8),
            ],
          ),
        ),
        padding: EdgeInsets.all(4.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            gradient: const RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [darkEdge, darkCore],
            ),
          ),
          child: Stack(
            children: [
              // Glow effect overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    gradient: RadialGradient(
                      center: Alignment.topCenter,
                      radius: 1.5,
                      colors: [
                        glowRed.withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Main content
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Imposter title
                        Text(
                          context.l10n.cardReveal_imposter_title,
                          style: AppTypography.h2.copyWith(
                            color: glowRed,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            shadows: [
                              Shadow(
                                color: glowRed.withValues(alpha: 0.8),
                                blurRadius: 12.r,
                              ),
                              Shadow(
                                color: glowOrange.withValues(alpha: 0.5),
                                blurRadius: 20.r,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        // Hint label
                        Text(
                          context.l10n.cardReveal_yourHint,
                          style: AppTypography.caption.copyWith(
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Hint display
                        Text(
                          hint,
                          style: AppTypography.h2.copyWith(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.h),
                        // Instructions
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: glowRed.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: glowRed.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            context.l10n.cardReveal_blendIn,
                            style: AppTypography.caption.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
