import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class CircularProgressWithInnerCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200), // Adjust the size as needed
      painter: ProgressPainter(
        progressPercentage: 0.7, // Change this to set the progress percentage
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
      ..color = Color(0xffEEECEC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round; // Set the strokeCap to round
    canvas.drawCircle(center, radius, outerPaint);

    // Calculate the sweep angle based on the progress percentage
    final sweepAngle = 360 * progressPercentage;

    // Create a gradient for the progress arc
    final gradient = LinearGradient(
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
    final innerCircleGradient = LinearGradient(
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
    final textStyle = GoogleFonts.raleway(
      color: Colors.black, // You can change the text color as needed
    );

    // Replace the textSpan with a RichText widget
    final textSpan = TextSpan(
      children: [
        TextSpan(
          text: '${(progressPercentage * 100).toStringAsFixed(0)}',
          style: TextStyle(
              fontFamily: 'UrduType',

            fontSize: 35.0,
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
        ),
        TextSpan(
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
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
