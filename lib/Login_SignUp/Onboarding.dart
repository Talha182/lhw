import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lhw/Login_SignUp/Login.dart';
import 'package:lhw/navy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Navigate to Home and set the flag to false
  Future<void> _navigateToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_time', false);
    Get.offAll(() => Custom_NavBar(), transition: Transition.fade, duration: Duration(milliseconds: 400));
  }
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: _current == 0
                  ? const Color(0xffFEE2F3)
                  : _current == 1
                  ? const Color(0xffFDF6E2)
                  : const Color(0xffE5F1EF),
              child: _current == 0
                  ? SvgPicture.asset("assets/images/onBoarding1.svg")
                  : _current == 1
                  ? SvgPicture.asset("assets/images/onBoarding2.svg")
                  : SvgPicture.asset("assets/images/onBoarding3.svg"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    color: Colors.white,
                    child: CarouselSlider(
                      items: const [
                        OnBoarding1(),
                        OnBoarding2(),
                        OnBoarding3(),
                      ],
                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                        enlargeFactor: 0.5,
                        disableCenter: true,
                        height: 100,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                          (index) => Container(
                        width: _current == index ? 8.0 : 5.0,
                        height: _current == index ? 8.0 : 8.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? const Color.fromRGBO(0, 0, 0, 0.9)
                              : const Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                      width: Get.width,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFE8BD1),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(150, 37),
                        ),
                        onPressed: () {
                          if (_current == 2) {
                            _navigateToHome();
                          } else {
                            setState(() {
                              _current = _current + 1;
                            });
                          }
                        },
                        child: _current == 0
                            ? const Text(
                          'I’m new to the app',
                          style: TextStyle(
                            fontFamily: 'UrduType',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                            : _current == 1
                            ? const Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: 'UrduType',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          'Finish Onboarding',
                          style: TextStyle(
                            fontFamily: 'UrduType',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _navigateToHome,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 15,
                      ),
                    ),
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

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Welcome, Lady Health Workers!",
          style: TextStyle(fontFamily: "UrduType", fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Step by step, these courses will guide you, focusing on your unique learning journey",
            textAlign: TextAlign.right, // Align the text to the right
            style: TextStyle(
              fontFamily: "UrduType",
              fontSize: 16,
              color: Color(0xff685F78),
              height: 1.2,
            ),
          ),
        )
      ],
    );
  }
}

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "New to technology?",
          style: TextStyle(fontFamily: "UrduType", fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Don't worry; we've designed this app with you in mind.",
            textAlign: TextAlign.right, // Align the text to the right
            style: TextStyle(
              fontFamily: "UrduType",
              fontSize: 17,
              color: Color(0xff685F78),
              height: 1.2,
            ),
          ),
        )
      ],
    );
  }
}

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Meet Your Virtual LHW Guide!",
          style: TextStyle(fontFamily: "UrduType", fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Lost or unsure? Watch for helpful directions from our LHW, simplifying every step for you.",
            textAlign: TextAlign.right, // Align the text to the right
            style: TextStyle(
              fontFamily: "UrduType",
              fontSize: 17,
              color: Color(0xff685F78),
              height: 1.2,
            ),
          ),
        )
      ],
    );
  }
}
