import 'package:flutter/material.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientCardWithImage extends StatelessWidget {
  final String imagePath;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final String midText;
  final String arrowText;
  final double imageWidth; // New parameter
  final double imageHeight; // New parameter
  final Alignment imagePosition; // New parameter

  GradientCardWithImage({
    required this.imagePath,
    required this.gradientStartColor,
    required this.gradientEndColor,
    required this.midText,
    required this.arrowText,
    required this.imageWidth, // Initialize new parameter
    required this.imageHeight, // Initialize new parameter
    required this.imagePosition, // Initialize new parameter
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [gradientStartColor, gradientEndColor],
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ArrowContainer(
                  text: arrowText,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    midText,
                    style: const TextStyle(
                      fontFamily: 'UrduType',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/module.svg',
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        '24 ماڈیولز',
                        style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      SvgPicture.asset(
                        'assets/images/module.svg',
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        '12 کوئز',
                        style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: imagePosition.y, // Modified
            left: imagePosition.x, // Modified
            child: Image.asset(
              imagePath,
              width: imageWidth, // Modified
              height: imageHeight, // Modified
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

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
