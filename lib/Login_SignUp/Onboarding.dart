import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lhw/Login_SignUp/Login.dart';
import 'package:lhw/navy.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
                      ? const Color(
                          0xffFDF6E2) // Replace with the desired color for the second item
                      : const Color(
                          0xffE5F1EF), // Replace with the desired color for the third item
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
                        height: 100, // Set the height of the carousel to 100
                        enableInfiniteScroll: true, // Enable infinite scrolling
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3, // Replace with the total number of carousel items
                    (index) => Container(
                      width: _current == index ? 8.0 : 5.0,
                      height: _current == index ? 8.0 : 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal:
                              4.0), // Increase the horizontal value for more space
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? const Color.fromRGBO(0, 0, 0, 0.9)
                              : const Color.fromRGBO(0, 0, 0, 0.4)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                        _current == 0
                            ? Get.to(() => const Custom_NavBar())
                            : _current == 1
                                ? Get.to(() => ())
                                : Get.to(() => LoginScreen());
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
                                  'Next',
                                  style: TextStyle(
                                    fontFamily: 'UrduType',
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _current == 0
                    ? GestureDetector(
                        onTap: () {
                          Get.to(() => LoginScreen());
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'UrduType',
                            fontSize: 15,
                          ),
                        ),
                      )
                    : _current == 1
                        ? const Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: 'UrduType',
                              fontSize: 15,
                            ),
                          )
                        : const Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: 'UrduType',
                              fontSize: 15,
                            ),
                          ),
              ],
            ),
          )),
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
