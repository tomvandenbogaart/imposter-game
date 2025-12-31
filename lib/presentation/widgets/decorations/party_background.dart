import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../core/theme/app_colors.dart';

class PartyBackground extends StatefulWidget {
  final Widget child;
  final bool showConfetti;
  final bool showGlowOrbs;

  const PartyBackground({
    super.key,
    required this.child,
    this.showConfetti = false,
    this.showGlowOrbs = true,
  });

  @override
  State<PartyBackground> createState() => _PartyBackgroundState();
}

class _PartyBackgroundState extends State<PartyBackground>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    if (widget.showConfetti) {
      _confettiController.play();
    }
  }

  @override
  void didUpdateWidget(PartyBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showConfetti && !oldWidget.showConfetti) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base gradient background
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.0, -0.5),
                radius: 1.5,
                colors: [
                  const Color(0xFF2D1B4E), // surface purple
                  AppColors.background,
                  const Color(0xFF0D0518), // darker purple
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),

        // Animated glow orbs
        if (widget.showGlowOrbs) ...[
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: _GlowOrbsPainter(
                  animation: _animationController.value,
                ),
                size: Size.infinite,
              );
            },
          ),
        ],

        // Main content
        widget.child,

        // Confetti overlay
        if (widget.showConfetti)
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.03,
              numberOfParticles: 10,
              gravity: 0.1,
              shouldLoop: true,
              colors: AppColors.confettiColors,
            ),
          ),
      ],
    );
  }
}

class _GlowOrbsPainter extends CustomPainter {
  final double animation;

  _GlowOrbsPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Top-left orange/gold glow - larger and more prominent
    final orangeCenter = Offset(
      size.width * 0.2 + sin(animation * 2 * pi) * 30,
      size.height * 0.1 + cos(animation * 2 * pi) * 20,
    );
    paint.shader = RadialGradient(
      colors: [
        AppColors.orange.withValues(alpha: 0.25),
        AppColors.gold.withValues(alpha: 0.1),
        AppColors.orange.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: orangeCenter, radius: 200));
    canvas.drawCircle(orangeCenter, 200, paint);

    // Top-right magenta glow
    final magentaTopCenter = Offset(
      size.width * 0.9 + cos(animation * 2 * pi) * 25,
      size.height * 0.15 + sin(animation * 2 * pi) * 15,
    );
    paint.shader = RadialGradient(
      colors: [
        AppColors.magenta.withValues(alpha: 0.2),
        AppColors.purple.withValues(alpha: 0.08),
        AppColors.magenta.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: magentaTopCenter, radius: 180));
    canvas.drawCircle(magentaTopCenter, 180, paint);

    // Bottom-left purple glow
    final purpleCenter = Offset(
      size.width * 0.1 + cos((animation + 0.3) * 2 * pi) * 20,
      size.height * 0.75 + sin((animation + 0.3) * 2 * pi) * 25,
    );
    paint.shader = RadialGradient(
      colors: [
        AppColors.purple.withValues(alpha: 0.15),
        AppColors.magenta.withValues(alpha: 0.05),
        AppColors.purple.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: purpleCenter, radius: 150));
    canvas.drawCircle(purpleCenter, 150, paint);

    // Bottom-right subtle orange glow
    final bottomOrangeCenter = Offset(
      size.width * 0.85 + sin((animation + 0.6) * 2 * pi) * 15,
      size.height * 0.9 + cos((animation + 0.6) * 2 * pi) * 10,
    );
    paint.shader = RadialGradient(
      colors: [
        AppColors.orange.withValues(alpha: 0.12),
        AppColors.gold.withValues(alpha: 0.04),
        AppColors.orange.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: bottomOrangeCenter, radius: 140));
    canvas.drawCircle(bottomOrangeCenter, 140, paint);

    // Center subtle gold accent
    final goldCenter = Offset(
      size.width * 0.5 + sin((animation + 0.5) * 2 * pi) * 10,
      size.height * 0.35 + cos((animation + 0.5) * 2 * pi) * 10,
    );
    paint.shader = RadialGradient(
      colors: [
        AppColors.gold.withValues(alpha: 0.08),
        AppColors.orange.withValues(alpha: 0.02),
        AppColors.gold.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(center: goldCenter, radius: 120));
    canvas.drawCircle(goldCenter, 120, paint);
  }

  @override
  bool shouldRepaint(_GlowOrbsPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

/// A confetti burst widget for celebration moments
class ConfettiBurst extends StatefulWidget {
  final Widget child;
  final bool trigger;

  const ConfettiBurst({
    super.key,
    required this.child,
    this.trigger = false,
  });

  @override
  State<ConfettiBurst> createState() => _ConfettiBurstState();
}

class _ConfettiBurstState extends State<ConfettiBurst> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    if (widget.trigger) {
      _confettiController.play();
    }
  }

  @override
  void didUpdateWidget(ConfettiBurst oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger && !oldWidget.trigger) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            maxBlastForce: 20,
            minBlastForce: 8,
            emissionFrequency: 0.05,
            numberOfParticles: 30,
            gravity: 0.2,
            shouldLoop: false,
            colors: AppColors.confettiColors,
          ),
        ),
      ],
    );
  }
}
