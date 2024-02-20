    import 'dart:math';

    import 'package:flutter/material.dart';

    class GradientCircleProgressBar extends StatelessWidget {
      final double value;
      final double strokeWidth;
      final Color backgroundColor;

      GradientCircleProgressBar({
        required this.value,
        required this.strokeWidth,
        required this.backgroundColor,
      });

      @override
      Widget build(BuildContext context) {
        return CustomPaint(
          foregroundPainter: CircleProgressBarPainter(
            value: value,
            strokeWidth: strokeWidth,
            backgroundColor: backgroundColor,
          ),
          child: Center(
            child: Text(
              '${(value * 100).toStringAsFixed(0)}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        );
      }
    }

    class CircleProgressBarPainter extends CustomPainter {
      final double value;
      final double strokeWidth;
      final Color backgroundColor;

      CircleProgressBarPainter({
        required this.value,
        required this.strokeWidth,
        required this.backgroundColor,
      });

      @override
      void paint(Canvas canvas, Size size) {
        final Offset center = Offset(size.width / 2, size.height / 2);
        final double radius = min(size.width, size.height) / 2;

        final Paint backgroundPaint = Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

        final Paint foregroundPaint = Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ).createShader(Rect.fromCircle(center: center, radius: radius))
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = strokeWidth;

        canvas.drawCircle(center, radius, backgroundPaint);
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -pi / 2,
          2 * pi * value,
          false,
          foregroundPaint,
        );
      }

      @override
      bool shouldRepaint(covariant CustomPainter oldDelegate) {
        return true;
      }
    }
