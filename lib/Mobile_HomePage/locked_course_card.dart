import 'package:flutter/material.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter_svg/svg.dart';

class LockedCourse extends StatelessWidget {
  final String imagePath;
  final String midText;
  final String arrowText;
  final double imageWidth; // New parameter
  final double imageHeight; // New parameter
  final Alignment imagePosition; // New parameter

  const LockedCourse({
    super.key,
    required this.imagePath,
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
        gradient: const LinearGradient(
          colors: [Color(0xffC3C3C3), Color(0xffCECECE)],
        ),
      ),
      child: Stack(
        children: [
          // Removed the left padding to move ArrowContainer to the very left
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Container(
                      width: 50,
                      height: 50,
                      child: Stack(children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                        const Center(
                          child: ClipOval(
                            child: Icon(
                              Icons.lock_outline,
                            ),
                          ),
                        ),
                      ])),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    midText,
                    style: const TextStyle(
                      fontFamily: 'UrduType',
                      letterSpacing: 0.01,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
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
            right: imagePosition.x, // Modified
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
