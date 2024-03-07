import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lhw/navy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>  {
  // Navigate to Home and set the flag to false
  Future<void> _navigateToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_time', false);
    Get.offAll(() => const Custom_NavBar(), transition: Transition.fade, duration: const Duration(milliseconds: 400));
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
                          'میں ایپ میں نیا ہوں',
                          style: TextStyle(
                            fontFamily: 'UrduType',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                            : _current == 1
                            ? const Text(
                          'اگلا',
                          style: TextStyle(
                            fontFamily: 'UrduType',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                            : const Text(
                          'اگلا',
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
                  InkWell(

                    onTap: () {
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
                      'لاگ ان',
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    )
                        : _current == 1
                        ? const Text(
                      'اچٹیں',
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    )
                        : const Text(
                      'اچٹیں',
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 15,
                        color: Colors.black,
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
          "لیڈی ہیلتھ ورکرز کو خوش آمدید!",
          style: TextStyle(fontFamily: "UrduType", fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
    'یہ مضامین قدم قدم پر آپ کی رہنمائی کریں گے تا کہ آپ اپنے وقت پرعلم کی نئی منزلوں تک پہنچیں۔ ', textAlign: TextAlign.right, // Align the text to the right
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
          "موبائل زیادہ استعمال نہیں کرتیں؟ ",
          style: TextStyle(fontFamily: "UrduType", fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "فکر نہ کریں، ہم نے یہ ایپ آپ کے مطابق بنائی ہے۔",
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
          "اپنی آن لائن سہیلی سمینہ سے ملیں!",
          style: TextStyle(fontFamily: "UrduType", fontSize: 25),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "سمجھنے میں مشکل ہو رہی ہے ؟ ہماری لیڈی ہیلتھ ورکر سمینہ آپ کی قدم قدم پر رہنمائی کرے گی۔",
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
