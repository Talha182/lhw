import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientCircle extends StatelessWidget {
  final double width;
  final double imageWidth;
  final double height;
  final double imageHeight;
  final LinearGradient gradient;
  final String imagePath;

  const GradientCircle({super.key,
    required this.width,
    required this.height,
    required this.gradient,
    required this.imagePath, required this.imageWidth, required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              child: SvgPicture.asset(
                imagePath,
                width: imageWidth, // Adjust the image size as needed
                height: imageHeight, // Adjust the image size as needed
                fit: BoxFit.cover, // Use BoxFit.contain to maintain quality
              ),
          ),
        ],
      ),
    );
  }
}
