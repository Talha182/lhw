import 'package:flutter/material.dart';

import '../custom_widgets/gradient_card_with_progress.dart';

class OnGoingCourses extends StatefulWidget {
  const OnGoingCourses({super.key});


  @override
  State<OnGoingCourses> createState() => _OnGoingCoursesState();
}

class _OnGoingCoursesState extends State<OnGoingCourses> {
  double progressValue = 0.5; // Modify this value as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
        child: ListView(
          children: <Widget>[
            const Text(
              "جاری ہے۔",
              style: TextStyle(                          fontFamily: 'UrduType',
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            GradientCardWithProgress(
              progressValue: progressValue,
              imagePath: 'assets/images/two_women.png',
              gradientStartColor: const Color(0xffEAAF58),
              gradientEndColor: const Color(0xffF4D6A9),
            ),
          ],
        ),
      ),
    );
  }
}
