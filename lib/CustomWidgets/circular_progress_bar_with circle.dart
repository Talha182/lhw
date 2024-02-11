import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressWithInnerCircle extends StatefulWidget {
  final double percentage;

  const CircularProgressWithInnerCircle({
    super.key,
    required this.percentage, // The target percentage of the progress bar
  });

  @override
  State<CircularProgressWithInnerCircle> createState() => _CircularProgressWithInnerCircleState();
}

class _CircularProgressWithInnerCircleState extends State<CircularProgressWithInnerCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of the animation
    );
    _animation = Tween<double>(begin: 0, end: widget.percentage).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
      setState(() {});
    });

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200), // Adjust the size as needed
      painter: ProgressPainter(
        progressPercentage: _animation.value, // Use the animated value here
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progressPercentage;

  ProgressPainter({
    required this.progressPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    // Draw the outer circular progress bar with rounded edges
    final outerPaint = Paint()
      ..color = const Color(0xffEEECEC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round; // Set the strokeCap to round
    canvas.drawCircle(center, radius, outerPaint);

    // Calculate the sweep angle based on the progress percentage
    final sweepAngle = 360 * progressPercentage;

    // Create a gradient for the progress arc
    const gradient = LinearGradient(
      colors: [
        Color(0xffF4D6A9),
        Color(0xffEAAF58),
      ],
      stops: [0.0, 1.0],
    );

    // Draw the progress arc with rounded edges and the gradient
    final progressPaint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round; // Set the strokeCap to round
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (pi / 180),
      sweepAngle * (pi / 180),
      false,
      progressPaint,
    );
    // Create a gradient for the inner circle to give it a 3D effect
    const innerCircleGradient = LinearGradient(
      colors: [
        Color(0xffF4D6A9),
        Color(0xffEAAF58),
      ],
    );

    // Draw the inner circle with the gradient
    final innerCirclePaint = Paint()
      ..shader = innerCircleGradient.createShader(
        Rect.fromCircle(center: center, radius: radius - 15),
      )
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - 15, innerCirclePaint);

    // Draw the percentage text in the middle of the circle
    const textStyle = TextStyle(
      color: Colors.black, // You can change the text color as needed
    );

    // Replace the textSpan with a RichText widget
    final textSpan = TextSpan(
      children: [
        TextSpan(
          text: (progressPercentage * 100).toStringAsFixed(0),
          style: const TextStyle(
              fontFamily: 'UrduType',

            fontSize: 35.0,
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
        ),
        const TextSpan(
          text: '/80',
          style: TextStyle(
              fontFamily: 'UrduType',

            color: Colors.black, // You can change the color for the total
            fontSize: 20.0, // You can change the font size for the total
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );


    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    final textX = center.dx - textPainter.width / 2;
    final textY = center.dy - textPainter.height / 2;
    textPainter.paint(canvas, Offset(textX, textY));
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this; // Return true if the progress has changed
  }
}
