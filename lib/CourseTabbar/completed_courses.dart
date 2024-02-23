import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart'; // Import Lottie

import '../courses_test/test_model.dart';
import 'course_provider.dart';
import 'courses_card.dart';

class CompletedCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetching the list of completed courses using Provider
    List<Course> completedCourses = Provider.of<CoursesProvider>(
            context)
        .courses // listen: false removed to ensure widget rebuilds when notifyListeners is called
        .where((course) => course.isCompleted)
        .toList();

    if (completedCourses.isEmpty) {
      return Scaffold(
        body: Center(
          // Display a Lottie animation when the list is empty
          child: Lottie.asset(
              'assets/lottie/empty.json'), // Update the path to your Lottie file
        ),
      );
    } else {
      return Scaffold(
        body: ListView.builder(
          itemCount: completedCourses.length,
          itemBuilder: (context, index) {
            final Course course = completedCourses[index];
            // Using CourseCard for each completed course
            // Ensure CourseCard is adapted to use TestCourseModel or adjust accordingly
            return CourseCard(course: course);
          },
        ),
      );
    }
  }
}
