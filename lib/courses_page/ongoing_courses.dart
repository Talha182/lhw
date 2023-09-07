import 'package:flutter/material.dart';

import '../custom_widgets/gradient_card_with_progress.dart';

class OnGoingCourses extends StatefulWidget {
  const OnGoingCourses({Key? key});

  @override
  State<OnGoingCourses> createState() => _OnGoingCoursesState();
}

class _OnGoingCoursesState extends State<OnGoingCourses> {
  double progressValue = 0.5; // Modify this value as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 8, right: 8),
        child: ListView(
          children: <Widget>[
            Text(
              "جاری ہے۔",
              style: TextStyle(                          fontFamily: 'UrduType',
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            GradientCardWithProgress(
              progressValue: progressValue,
              imagePath: 'assets/icons/two_women.png',
              gradientStartColor: Color(0xffEAAF58),
              gradientEndColor: Color(0xffF4D6A9),
            ),
          ],
        ),
      ),
    );
  }
}
