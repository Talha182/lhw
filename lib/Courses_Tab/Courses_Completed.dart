import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lhw/custom_widgets/Row_Column_Padding.dart';
import 'package:lhw/custom_widgets/gradient_card_with_image.dart';

class Courses_Completed extends StatelessWidget {
  const Courses_Completed({super.key});

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
                  "جاری ہے۔",
                  style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    ...columnPadded([
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
                        imagePath: 'assets/images/2.png',
                        gradientStartColor: const Color(0xffF48401),
                        gradientEndColor: const Color(0xffFDD19D),
                        midText: 'کمیونٹی کے ساتھ کام کرنا',
                        arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                        imageWidth: 180,
                        imageHeight: 160,
                        imagePosition: const Alignment(-10, 0),
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
                      Builder(builder: (context) {
                        return Center(
                          child: GradientCardWithImage(
                            imagePath: 'assets/images/4.png',
                            gradientStartColor: const Color(0xffF45483),
                            gradientEndColor: const Color(0xffFE8FB6),
                            midText: 'قبل از پیدائش کی دیکھ بھال',
                            arrowText: 'مکمل ہوا • گریڈ حاصل کیا گیا: 93.75%',
                            imageWidth: 180,
                            imageHeight: 180,
                            imagePosition: const Alignment(0, -20),
                          ),
                        );
                      }),
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
                    ], 8)
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
