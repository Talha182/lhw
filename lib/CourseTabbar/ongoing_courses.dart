import 'package:flutter/material.dart';
import 'courses_card.dart';
import 'total_courses.dart';
import '../models/course_model.dart';
import 'package:provider/provider.dart';

import 'course_provider.dart';
class OnGoingCourses extends StatelessWidget {
  const OnGoingCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CoursesProvider>(context);
    final courses = provider.ongoingCourses; // Using the ongoingCourses getter

    return Scaffold(

      body: courses.isEmpty
          ? const Center(child: Text("No ongoing courses"))
          : Padding(
        padding: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("جاری یونٹ",style: TextStyle(
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
