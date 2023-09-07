import 'package:flutter/material.dart';
import 'package:lhw/courses_page/locked_course_card.dart';
import 'package:lhw/custom_widgets/gradient_card_with_image.dart';

import '../custom_widgets/gradient_card_with_progress.dart';

class TotalCourses extends StatelessWidget {
  const TotalCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 2, right: 2, top: 20),
        child: ListView(
          children: <Widget>[
            Text(
              "تمام کورسز",
              style: TextStyle(
                  fontFamily: 'UrduType',
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: GradientCardWithProgress(
                progressValue: 0.2,
                imagePath: 'assets/icons/two_women.png',
                gradientStartColor: Color(0xffEAAF58),
                gradientEndColor: Color(0xffF4D6A9),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: GradientCardWithImage(
                imagePath: 'assets/icons/1.png',
                gradientStartColor: Color(0xffED8DCE),
                gradientEndColor: Color(0xffF4B9E1),
                midText: 'تعارف',
                arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                imageWidth: 180,
                imageHeight: 180,
                imagePosition: Alignment(0, 0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: GradientCardWithImage(
                imagePath: 'assets/icons/community.png',
                gradientStartColor: Color(0xff8E79FB),
                gradientEndColor: Color(0xffB09FFD),
                midText: 'باہمی رابطے اور صحت کی تعلیم',
                arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                imageWidth: 180,
                imageHeight: 190,
                imagePosition: Alignment(-10, 0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: GradientCardWithImage(
                imagePath: 'assets/icons/3.png',
                gradientStartColor: Color(0xff18A3C8),
                gradientEndColor: Color(0xff89E4FE),
                midText: 'باہمی رابطے اور صحت کی تعلیم',
                arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                imageWidth: 200,
                imageHeight: 180,
                imagePosition: Alignment(0, -30),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Builder(builder: (context) {
                return Center(
                  child: GradientCardWithImage(
                    imagePath: 'assets/icons/4.png',
                    gradientStartColor: Color(0xffF45483),
                    gradientEndColor: Color(0xffFE8FB6),
                    midText: 'قبل از پیدائش کی دیکھ بھال',
                    arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                    imageWidth: 180,
                    imageHeight: 180,
                    imagePosition: Alignment(0, -20),
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: GradientCardWithImage(
                imagePath: 'assets/icons/5.png',
                gradientStartColor: Color(0xff4AA153),
                gradientEndColor: Color(0xffDCEFDE),
                midText: 'حمل کے دوران دیکھ بھال',
                arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                imageWidth: 180,
                imageHeight: 180,
                imagePosition: Alignment(10, 0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: LockedCourse(
                imagePath: 'assets/icons/locked_course.png',
                midText: 'حمل کے دوران دیکھ بھال',
                arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                imageWidth: 180,
                imageHeight: 180,
                imagePosition: Alignment(-10, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
