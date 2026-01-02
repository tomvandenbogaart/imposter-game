import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../widgets/cards/flip_card.dart';
import '../../widgets/buttons/primary_button.dart';

class LocalCardRevealScreen extends ConsumerStatefulWidget {
  const LocalCardRevealScreen({super.key});

  @override
  ConsumerState<LocalCardRevealScreen> createState() =>
      _LocalCardRevealScreenState();
}

class _LocalCardRevealScreenState extends ConsumerState<LocalCardRevealScreen> {
  bool _isRevealed = false;

  // Cache player data to prevent flash when advancing
  String? _playerId;
  String? _playerName;
  bool? _isImposter;
  String? _word;
  String? _hint;

  @override
  void initState() {
    super.initState();
    // Cache the current player's data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cachePlayerData();
    });
  }

  void _cachePlayerData() {
    final gameState = ref.read(localGameProvider);
    final currentPlayer = gameState.currentPlayer;
    if (currentPlayer != null && _playerId == null) {
      setState(() {
        _playerId = currentPlayer.id;
        _playerName = currentPlayer.name;
        _isImposter = ref.read(localGameProvider.notifier).isImposter(currentPlayer.id);
        _word = ref.read(localGameProvider.notifier).getWordForPlayer(currentPlayer.id);
        _hint = ref.read(localGameProvider.notifier).getHintForPlayer(currentPlayer.id);
      });
    }
  }

  void _revealCard() {
    final gameState = ref.read(localGameProvider);
    if (gameState.settings.hapticFeedback) {
      HapticFeedback.heavyImpact();
    }
    setState(() => _isRevealed = true);
    ref.read(localGameProvider.notifier).markCurrentPlayerRevealed();
  }

  void _hideCard() {
    final gameState = ref.read(localGameProvider);
    if (gameState.settings.hapticFeedback) {
      HapticFeedback.mediumImpact();
    }

    // Advance player then navigate
    ref.read(localGameProvider.notifier).advanceToNextPlayer();
    context.go('/local/privacy');
  }

  @override
  Widget build(BuildContext context) {
    // Only watch for initial load, use cached data after
    final gameState = ref.watch(localGameProvider);

    // Use cached data if available, otherwise fall back to current state
    final playerName = _playerName ?? gameState.currentPlayer?.name;
    final isImposter = _isImposter ?? false;
    final word = _word;
    final hint = _hint;

    if (playerName == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(context.screenPadding),
            child: Column(
              children: [
                // Header
                Text(
                  playerName,
                  style: AppTypography.h2,
                ).animate().fadeIn(duration: 400.ms),

                SizedBox(height: 8.h),

                Text(
                  _isRevealed
                      ? context.l10n.cardReveal_yourRole
                      : context.l10n.cardReveal_tapToReveal,
                  style: AppTypography.bodySmall,
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                const Spacer(),

                // Flip card
                SizedBox(
                  width: context.cardWidth,
                  height: context.cardHeight,
                  child: FlipCard(
                    isFlipped: _isRevealed,
                    onFlip: _isRevealed ? null : _revealCard,
                    front: _RevealedCard(
                      isImposter: isImposter,
                      word: word,
                      hint: hint,
                    ),
                    back: _HiddenCard(),
                  ),
                ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

                const Spacer(),

                // Hide button (only visible when revealed)
                AnimatedOpacity(
                  opacity: _isRevealed ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: PrimaryButton(
                    label: context.l10n.cardReveal_hideCard_button,
                    icon: Icons.visibility_off_rounded,
                    onPressed: _isRevealed ? _hideCard : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HiddenCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.surfaceGradient,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.surfaceLight,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withValues(alpha: 0.2),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.touch_app_rounded,
            size: 64.sp,
            color: AppColors.cyan,
          ),
          SizedBox(height: 24.h),
          Text(
            context.l10n.cardReveal_tapToReveal_card,
            style: AppTypography.h3.copyWith(
              color: AppColors.cyan,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.cardReveal_roleAwaits,
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(duration: 2.seconds, color: AppColors.orange.withValues(alpha: 0.3));
  }
}

class _RevealedCard extends StatelessWidget {
  final bool isImposter;
  final String? word;
  final String? hint;

  const _RevealedCard({
    required this.isImposter,
    this.word,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return isImposter ? _buildImposterCard(context) : _buildWordCard(context);
  }

  /// Innocent card - Beige parchment style with golden border
  Widget _buildWordCard(BuildContext context) {
    const parchmentLight = Color(0xFFF5E6C8);
    const parchmentDark = Color(0xFFE8D4A8);
    const borderGold = Color(0xFFD4A030);
    const borderOrange = Color(0xFFE85A20);

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
              Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Word display
                      Text(
                        word ?? context.l10n.cardReveal_unknown,
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
              Center(
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
                        hint ?? context.l10n.cardReveal_noHint,
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
            ],
          ),
        ),
      ),
    );
  }
}
