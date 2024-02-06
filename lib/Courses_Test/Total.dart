import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lhw/Courses_Test/Complete.dart';
import 'package:provider/provider.dart';

import 'course_model.dart';
import 'course_provider.dart';

class Total extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Course> courses = Provider.of<CoursesProvider>(context).courses;

    return Scaffold(
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          // Conditional rendering based on course completion status
          if (course.isCompleted) {
            // If the course is completed, show the GradientCardWithImage
            return CompletedCard(
              imagePath: course.imagePath,
              gradient: course.gradient,
              midText: course.title,
              arrowText: 'Completed',
              quizCount: course.quizCount,
              moduleCount:
                  course.moduleCount, // Customize this text as necessary
              // Add any other necessary parameters for GradientCardWithImage here
            );
          } else {
            // If the course is not completed, show the CourseItem
            return CourseItem(course: course);
          }
        },
      ),
    );
  }
}

class CourseItem extends StatelessWidget {
  final Course course;

  const CourseItem({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressValue = 0.75;
    return Container(
      width: double.infinity,
      height: 190,
      margin: const EdgeInsets.only(bottom: 12, top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: course.gradient,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: -26,
            left: 0,
            child: Image.asset(
              course.imagePath,
              width: 190,
              height: 190,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (course.isStart) // Conditional rendering based on isStart
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: CircleProgressBar(
                        backgroundColor: const Color(0xffE6D0B0),
                        foregroundColor: Colors.white,
                        value: progressValue,
                        child: Center(
                          child: Text(
                            '${(progressValue * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontFamily: 'UrduType',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/module.svg',
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${course.moduleCount} ماڈیولز', // Example text, replace with dynamic data if necessary
                        style: const TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      SvgPicture.asset(
                        'assets/images/quiz.svg',
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${course.quizCount} کوئز', // Example text, replace with dynamic data if necessary
                        style: const TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
