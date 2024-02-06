import 'package:flutter/material.dart';
import 'courses_item.dart';
import 'total_courses.dart';
import 'course_model.dart';
import 'package:provider/provider.dart';

import 'course_provider.dart';

class OnGoing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Course> ongoingCourses = Provider.of<CoursesProvider>(context).ongoingCourses;

    return Scaffold(
      body: ListView.builder(
        itemCount: ongoingCourses.length,
        itemBuilder: (context, index) {
          final course = ongoingCourses[index];
          return CourseCard(course: course); // Reuse the CourseItem widget from Total screen
        },
      ),
    );
  }
}
