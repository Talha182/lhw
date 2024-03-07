import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'courses_card.dart';
import 'course_provider.dart';

class TotalCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CoursesProvider>(context);
    final courses = provider.courses;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              " تمام یونٹ",
              style: TextStyle(
                fontFamily: 'UrduType',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return CourseCard(course: provider.courses[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
