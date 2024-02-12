import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../courses_test/test_model.dart';
import 'course_provider.dart';
import 'courses_card.dart';

class CompletedCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetching the list of completed courses using Provider
    List<TestCourseModel> completedCourses =
    Provider.of<CoursesProvider>(context).courses // listen: false removed to ensure widget rebuilds when notifyListeners is called
        .where((course) => course.isCompleted)
        .toList();

    return Scaffold(
      body: ListView.builder(
        itemCount: completedCourses.length,
        itemBuilder: (context, index) {
          final TestCourseModel course = completedCourses[index];
          // Using CourseCard for each completed course
          // Ensure CourseCard is adapted to use TestCourseModel or adjust accordingly
          return CourseCard(course: course);
        },
      ),
    );
  }
}
