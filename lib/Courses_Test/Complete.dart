import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/gradient_card_with_image.dart';
import 'course_model.dart';
import 'course_provider.dart';

class CompleteCoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetching the list of completed courses using Provider
    List<Course> completedCourses =
        Provider.of<CoursesProvider>(context, listen: false)
            .courses
            .where((course) => course.isCompleted)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Courses'),
      ),
      body: ListView.builder(
        itemCount: completedCourses.length,
        itemBuilder: (context, index) {
          final Course course = completedCourses[index];
          // Directly using the course's gradient for the card
          return CompletedCard(
            imagePath: course.imagePath,
            gradient:
                course.gradient, // Directly passing the LinearGradient object
            midText: course.title,
            arrowText: 'Completed', // Example text, adjust as necessary
            imageWidth: 100, // Example size, adjust as necessary
            imageHeight: 100, // Example size, adjust as necessary
            imagePosition: Alignment.bottomLeft,
            quizCount: course.quizCount,
            moduleCount:
                course.moduleCount, // Example position, adjust as necessary
          );
         },
      ),
    );
  }
}

class CompletedCard extends StatelessWidget {
  final String imagePath;
  final LinearGradient gradient;
  final String midText;
  final String arrowText;
  final double imageWidth; // Customization for image size
  final double imageHeight; // Customization for image size
  final Alignment imagePosition; // Customization for image alignment
  final int quizCount;
  final int moduleCount;

  CompletedCard({
    required this.imagePath,
    required this.gradient,
    required this.midText,
    required this.arrowText,
    this.imageWidth = 190, // Default values
    this.imageHeight = 190, // Default values
    this.imagePosition = Alignment.bottomLeft,
    required this.quizCount,
    required this.moduleCount, // Default values
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: gradient,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: imagePosition == Alignment.bottomLeft ? 0 : null,
            left: imagePosition == Alignment.bottomLeft ? 0 : null,
            right: imagePosition == Alignment.bottomRight ? 0 : null,
            top: imagePosition == Alignment.topLeft ||
                    imagePosition == Alignment.topRight
                ? 0
                : null,
            child: Image.asset(
              imagePath,
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 10),
                ArrowContainer(text: arrowText),
                const SizedBox(height: 10),
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
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/module.svg',
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${moduleCount} ماڈیولز', // Example text, replace with dynamic data if necessary
                        style: const TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        'assets/images/quiz.svg',
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${quizCount} کوئز', // Example text, replace with dynamic data if necessary
                        style: const TextStyle(
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
        ],
      ),
    );
  }
}
