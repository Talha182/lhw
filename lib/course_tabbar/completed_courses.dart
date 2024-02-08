import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'courses_item.dart';
import '../models/course_model.dart';
import 'course_provider.dart';

class CompletedCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetching the list of completed courses using Provider
    List<Course> completedCourses =
    Provider.of<CoursesProvider>(context, listen: false)
        .courses
        .where((course) => course.isCompleted)
        .toList();

    return Scaffold(

      body: ListView.builder(
        itemCount: completedCourses.length,
        itemBuilder: (context, index) {
          final Course course = completedCourses[index];
          // Using CourseItem for each completed course
          return CourseCard(course: course);
        },
      ),
    );
  }
}
