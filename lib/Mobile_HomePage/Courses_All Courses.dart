import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Mobile_HomePage/locked_course_card.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/lesson_page_tabbar.dart';
import 'package:lhw/custom_widgets/Row_Column_Padding.dart';
import 'package:lhw/custom_widgets/gradient_card_with_image.dart';

import '../custom_widgets/gradient_card_with_progress.dart';

class TotalCourses extends StatelessWidget {
  const TotalCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2, right: 2, top: 20),
            child: ListView(
              children: <Widget>[
                const Text(
                  "تمام کورسز",
                  style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    ...columnPadded([
                       GradientCardWithProgress(
                        progressValue: 0.2,
                        imagePath: 'assets/images/two_women.png',
                        gradientStartColor: Color(0xffEAAF58),
                        gradientEndColor: Color(0xffF4D6A9), onTap: () {
                          Get.to(() => LessonPageTabBar(),transition: Transition.fade,duration: Duration(milliseconds: 300));
                      },
                      ),
                      GradientCardWithImage(
                        imagePath: 'assets/images/1.png',
                        gradientStartColor: const Color(0xffED8DCE),
                        gradientEndColor: const Color(0xffF4B9E1),
                        midText: 'تعارف',
                        arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                        imageWidth: 180,
                        imageHeight: 180,
                        imagePosition: const Alignment(0, 0),
                      ),
                      GradientCardWithImage(
                        imagePath: 'assets/images/community.png',
                        gradientStartColor: const Color(0xff8E79FB),
                        gradientEndColor: const Color(0xffB09FFD),
                        midText: 'باہمی رابطے اور صحت کی تعلیم',
                        arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                        imageWidth: 180,
                        imageHeight: 190,
                        imagePosition: const Alignment(-10, 0),
                      ),
                      GradientCardWithImage(
                        imagePath: 'assets/images/3.png',
                        gradientStartColor: const Color(0xff18A3C8),
                        gradientEndColor: const Color(0xff89E4FE),
                        midText: 'باہمی رابطے اور صحت کی تعلیم',
                        arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                        imageWidth: 200,
                        imageHeight: 180,
                        imagePosition: const Alignment(0, -30),
                      ),
                      GradientCardWithImage(
                        imagePath: 'assets/images/4.png',
                        gradientStartColor: const Color(0xffF45483),
                        gradientEndColor: const Color(0xffFE8FB6),
                        midText: 'قبل از پیدائش کی دیکھ بھال',
                        arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                        imageWidth: 180,
                        imageHeight: 180,
                        imagePosition: const Alignment(0, -20),
                      ),
                      GradientCardWithImage(
                        imagePath: 'assets/images/5.png',
                        gradientStartColor: const Color(0xff4AA153),
                        gradientEndColor: const Color(0xffDCEFDE),
                        midText: 'حمل کے دوران دیکھ بھال',
                        arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                        imageWidth: 180,
                        imageHeight: 180,
                        imagePosition: const Alignment(10, 0),
                      ),
                      LockedCourse(
                        imagePath: 'assets/images/locked_course.png',
                        midText: 'حمل کے دوران دیکھ بھال',
                        arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                        imageWidth: 180,
                        imageHeight: 180,
                        imagePosition: Alignment(-10, 0),
                      ),
                    ], 8),
                    SizedBox(height: 20,),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 60, // Adjust as needed
              right: 15, // Adjust as needed
              child: CircleAvatar(
                backgroundColor: Color(0xffF6B3D0),
                radius: 30,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: SvgPicture.asset(
                      "assets/images/samina_instructor.svg",
                      fit: BoxFit.fill,
                    )),
              )),
        ],
      ),
    );
  }
}
