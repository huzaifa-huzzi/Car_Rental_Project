import 'dart:math' as math;
import 'package:flutter/material.dart';

class PerfectGradientArc extends StatelessWidget {
  final double strokeWidth;
  final double progress;
  final SweepGradient gradient;
  final Color bgColor;

  const PerfectGradientArc({
    super.key,
    required this.strokeWidth,
    required this.progress,
    required this.gradient,
    this.bgColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;

        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _PerfectGradientArcPainter(
              progress: progress,
              strokeWidth: strokeWidth,
              gradient: gradient,
              bgColor: bgColor,
            ),
          ),
        );
      },
    );
  }
}


class _PerfectGradientArcPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final SweepGradient gradient;
  final Color bgColor;

  _PerfectGradientArcPainter({
    required this.progress,
    required this.strokeWidth,
    required this.gradient,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background ring
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);


    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
