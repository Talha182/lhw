import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'course_provider.dart';
import 'courses_card.dart';

class CompletedCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CoursesProvider>(context);
    final courses = provider.completedCourses; // Using the completedCourses getter

    return Scaffold(
      body: courses.isEmpty
          ? Center(child: Text("No completed courses"))
          : ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseCard(course: course);
        },
      ),
    );
  }
}
