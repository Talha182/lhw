import 'package:flutter/material.dart';

class GradientCircle extends StatelessWidget {
  final double width;
  final double height;
  final LinearGradient gradient;
  final String imagePath;

  GradientCircle({
    required this.width,
    required this.height,
    required this.gradient,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: gradient,
              shape: BoxShape.circle,
            ),
          ),
          Center(
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: 24, // Adjust the image size as needed
                height: 24, // Adjust the image size as needed
                fit: BoxFit.contain, // Use BoxFit.contain to maintain quality
              ),
            ),
          ),
        ],
      ),
    );
  }
}
