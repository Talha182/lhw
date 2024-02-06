import 'package:flutter/material.dart';

import 'course_model.dart';

// course provider
class CoursesProvider with ChangeNotifier {
  final List<Course> _courses = [
    Course(
      title: 'تعارف ٹریننگ کا طریقہ کار',
      gradient:
          const LinearGradient(colors: [Color(0xffEAAF58), Color(0xffF4D6A9)]),
      quizCount: 5,
      moduleCount: 10,
      imagePath: 'assets/images/two_women.png',
      isStart: true,
    ),
    Course(
        title: 'کمیونٹی کے ساتھ مل کر کام کرنا',
        gradient: const LinearGradient(
            colors: [Color(0xffED8DCE), Color(0xffF4B9E1)]),
        quizCount: 1,
        moduleCount: 1,
        imagePath: 'assets/images/1.png',
        isStart: false,
        isCompleted: true),
    Course(
        title: 'متعدی بیماریاں',
        gradient: const LinearGradient(colors: [Color(0xff89E4FE),Color(0xff18A3C8)]),
        quizCount: 1,
        moduleCount: 1,
        imagePath: 'assets/images/1.png',
        isStart: false,
        isCompleted: true
    ),
    Course(
        title: 'خاندانی منصوبہ بندی',
        gradient: const LinearGradient(
            colors: [Color(0xffF48401), Color(0xffFDD19D)]),
        quizCount: 1,
        moduleCount: 1,
        imagePath: 'assets/images/1.png',
        isStart: false,
        isCompleted: true),
    Course(
        title: 'رابطه / شخصی رابطہ اور تعلیم صحت',
        gradient: const LinearGradient(
            colors: [Color(0xffDCEFDE), Color(0xff4AA153)]),
        quizCount: 1,
        moduleCount: 1,
        imagePath: 'assets/images/1.png',
        isStart: false,
        isCompleted: true),
    Course(
        title: 'زیچگی کے دوران کی دیکھ بھال',
        gradient: const LinearGradient(
            colors: [Color(0xff8E79FB), Color(0xffB09FFD)]),
        quizCount: 1,
        moduleCount: 1,
        imagePath: 'assets/images/1.png',
        isStart: false,
        isCompleted: true),
    Course(
        title: 'دورانِ حمل نگہداشت',
        gradient: const LinearGradient(
            colors: [Color(0xffFE8FB6), Color(0xffF45483)]),
        quizCount: 1,
        moduleCount: 1,
        imagePath: 'assets/images/1.png',
        isStart: false,
        isCompleted: true),


  ];

  List<Course> get courses => _courses;

  List<Course> get ongoingCourses =>
      _courses.where((course) => course.isStart).toList();
}
