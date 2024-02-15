import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/courses_test/test_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CustomWidgets/ArrowContainer.dart';
import 'LessonPageTabBar/LessonPageTabbar.dart';
import '../ModuleScreen/ModuleScreen.dart';
import 'course_provider.dart';

class CourseCard extends StatelessWidget {
  final TestCourseModel course;

  const CourseCard({Key? key, required this.course}) : super(key: key);
  // Function to check first visit and navigate accordingly
  Future<void> navigateBasedOnVisitStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstVisitKey = 'isFirstVisit_${course.courseId}';
    final isFirstVisit = prefs.getBool(isFirstVisitKey) ?? true;

    if (isFirstVisit) {
      await prefs.setBool(isFirstVisitKey, false);
      await Get.to(() => LessonPageTabBar(course: course),transition: Transition.fade,duration: Duration(milliseconds: 300));
    } else {
      await Get.to(() => ModuleScreen(course: course),transition: Transition.fade,duration: Duration(milliseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    Color startColor = Color(int.parse(course.gradient['start']!.replaceAll('#', '0xff')));
    Color endColor = Color(int.parse(course.gradient['end']!.replaceAll('#', '0xff')));

    const progressValue = 0.75;
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.only(bottom: 12, top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            startColor,
            endColor,
          ],
        ),      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              course.imagePath,
              scale: 0.9,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  course.isCompleted
                      ? ArrowContainer(text: course.arrowText)
                      : course.isStart
                          ? Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircleProgressBar(
                                  strokeWidth: 4.0,
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
                            )
                          : const SizedBox(
                              height: 50,
                              width: 50,
                            ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      course.title,
                      style: const TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(
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
                        Image.asset(
                          'assets/images/quiz.png',
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  course.isStart
                      ? Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white.withOpacity(0.5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: const Size(120, 30),
                            ),
                            onPressed: () async {
                              await navigateBasedOnVisitStatus(context);
                              // Update the last visited course using Provider after navigation completes
                              Provider.of<CoursesProvider>(context,
                                      listen: false)
                                  .setLastVisitedCourse(course);
                            },
                            child: const Text(
                              'جاری رہے',
                              style: TextStyle(
                                fontFamily: 'UrduType',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 0,
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
