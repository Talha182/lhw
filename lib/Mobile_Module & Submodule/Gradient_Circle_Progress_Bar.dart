import 'dart:math';

import 'package:flutter/material.dart';

class GradientCircleProgressBar extends StatefulWidget {
  final double value;
  final double strokeWidth;
  final Color backgroundColor;

  GradientCircleProgressBar({
    Key? key,
    required this.value,
    required this.strokeWidth,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  _GradientCircleProgressBarState createState() =>
      _GradientCircleProgressBarState();
}

class _GradientCircleProgressBarState extends State<GradientCircleProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    // Create a Tween animation.
    _animation = Tween<double>(begin: 0, end: widget.value).animate(_controller)
      ..addListener(() {
        setState(() {}); // Causes the widget to rebuild with the new value.
      });

    _controller.forward();
  }

  @override
  void didUpdateWidget(GradientCircleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.value,
      ).animate(_controller)
        ..addListener(() {
          setState(() {}); // Causes the widget to rebuild with the new value.
        });

      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircleProgressBarPainter(
        value: _animation.value,
        strokeWidth: widget.strokeWidth,
        backgroundColor: widget.backgroundColor,
      ),
      child: Center(
        child: Text(
          '${(_animation.value * 100).toStringAsFixed(0)}%',
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
      ..shader = const LinearGradient(
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
