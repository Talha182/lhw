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
          ? const Center(child: Text("No completed courses"))
          : Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("جاری یونٹ",style: TextStyle(
              fontFamily: 'UrduType',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return CourseCard(course: course);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
