import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'courses_card.dart';
import '../models/course_model.dart';
import 'course_provider.dart';

class TotalCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Course> courses = Provider.of<CoursesProvider>(context).courses;

    return Scaffold(
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          // Use CourseItem for all courses, it handles conditional rendering internally
          return CourseCard(course: course);
        },
      ),
    );
  }
}
