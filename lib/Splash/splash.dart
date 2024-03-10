import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../LoginSignUp/Onboarding.dart';

class SplashScreenLHW extends StatefulWidget {
  const SplashScreenLHW({super.key});

  @override
  _SplashScreenLHWState createState() => _SplashScreenLHWState();
}

class _SplashScreenLHWState extends State<SplashScreenLHW> {

  // @override
  // void initState() {
  //   super.initState();
  //
  //   // Add a delay to auto-navigate after a set time
  //   Future.delayed(Duration(seconds: 3), () {
  //     if(Get.currentRoute != "/OnboardingScreen") { // Prevent navigation if user already swiped
  //       Get.off(
  //               () => const OnboardingScreen(),
  //           transition: Transition.fade,
  //           duration: const Duration(milliseconds: 400)
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEF1F9),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0 || details.primaryVelocity! > -180) {
            // Swiped from left to right. Adjust as needed.
            Get.off(
                    () => const OnboardingScreen(),
                transition: Transition.fade,
                duration: const Duration(milliseconds: 400)
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 80,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffFE8BD1)),
                        child: Center(
                          child: SvgPicture.asset("assets/images/cross.svg"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "ایل ایچ ڈبلیو",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 30),
                      )
                    ],
                  )
                ],
              ),
              Positioned(
                  bottom: -30,
                  child: SvgPicture.asset("assets/images/splash_curve.svg")),
              Positioned(
                  bottom: -30,
                  child: SvgPicture.asset("assets/images/splash_bg.svg")),
              Positioned(
                  bottom: -30,
                  child: SvgPicture.asset("assets/images/splash_samina.svg")),
              Positioned(
                  bottom: -30,
                  right: 10,
                  child: SvgPicture.asset("assets/images/splash_lady.svg")),
            ],
          ),
        ),
      ),
    );
  }
}
