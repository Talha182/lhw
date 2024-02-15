import 'package:flutter/material.dart';
import 'package:lhw/courses_test/test_model.dart';
import 'courses_card.dart';
import 'total_courses.dart';
import '../models/course_model.dart';
import 'package:provider/provider.dart';

import 'course_provider.dart';
class OnGoingCourses extends StatelessWidget {
  const OnGoingCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TestCourseModel> ongoingCourses = Provider.of<CoursesProvider>(context).ongoingCourses;

    return Scaffold(
      body: ListView.builder(
        itemCount: ongoingCourses.length,
        itemBuilder: (context, index) {
          final course = ongoingCourses[index];
          return CourseCard(course: course); // Assuming CourseCard is designed to work with TestCourseModel
        },
      ),
    );
  }
}