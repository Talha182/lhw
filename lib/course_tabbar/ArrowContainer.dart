import 'package:flutter/material.dart';

class ArrowContainer extends StatelessWidget {
  final String text; // Added this line for text

  ArrowContainer({required this.text}); // Added this line for constructor

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: const Size(220, 40),
          painter: ArrowPainter(),
        ),
        Positioned(
          right: 10,
          top: 5,
          child: Text(
            text, // Modified this line to display the text
            style: const TextStyle(
                fontFamily: 'UrduType',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black87.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final double cornerRadius = 3.0;
    final double arrowHeadSmoothness = 1.0; // Smoothness factor for arrow head

    final path = Path()
      ..moveTo(size.width - cornerRadius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, cornerRadius)
      ..lineTo(size.width, size.height - cornerRadius)
      ..quadraticBezierTo(size.width, size.height,
          size.width - cornerRadius, size.height)
      ..lineTo(20, size.height)
      ..lineTo(arrowHeadSmoothness, size.height / 2 + arrowHeadSmoothness)
      ..quadraticBezierTo(
          0,
          size.height / 2,
          arrowHeadSmoothness,
          size.height / 2 - arrowHeadSmoothness)
      ..lineTo(20, 0)
      ..lineTo(size.width - cornerRadius, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
