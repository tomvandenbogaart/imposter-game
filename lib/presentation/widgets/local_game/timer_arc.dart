import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TimerArc extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final bool isUrgent;

  const TimerArc({
    super.key,
    required this.progress,
    this.size = 200,
    this.strokeWidth = 12,
    this.isUrgent = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _TimerArcPainter(
          progress: progress,
          strokeWidth: strokeWidth,
          isUrgent: isUrgent,
        ),
      ),
    );
  }
}

class _TimerArcPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final bool isUrgent;

  _TimerArcPainter({
    required this.progress,
    required this.strokeWidth,
    required this.isUrgent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background arc
    final backgroundPaint = Paint()
      ..color = AppColors.surfaceLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = isUrgent
        ? AppColors.urgentGradient
        : AppColors.timerGradient;

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      rect,
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    // Glow effect
    if (progress > 0) {
      final glowPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 8
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawArc(
        rect,
        -pi / 2,
        sweepAngle,
        false,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_TimerArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isUrgent != isUrgent;
  }
}
