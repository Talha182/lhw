import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonOption20 extends StatefulWidget {
  const LessonOption20({super.key});

  @override
  _LessonOption20State createState() => _LessonOption20State();
}

class _LessonOption20State extends State<LessonOption20> {
  int _current = 0;
  final int _totalSteps = 100;
  int _maxNavigableIndex = 0;
  bool _isLastCardFlipped = false;


  final CarouselController _carouselController = CarouselController();

  List<Widget> frontCardWidgets = [
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
  ];

  List<Widget> backCardWidgets = [
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
    Container(
      width: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(
        "assets/images/flip1.png",
        fit: BoxFit.fill,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          0,
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0, -0.2),
          colors: [
            const Color(0xff80B8FB).withOpacity(0.5),
            Colors.transparent,
          ],
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
              child: Row(
                children: [
                  const InkWell(
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 320,
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: 0, end: ((_current + 1) / 5 * _totalSteps)),
                      duration: const Duration(milliseconds: 400),
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return LinearPercentIndicator(
                          lineHeight: 8.0,
                          percent: value / _totalSteps,
                          backgroundColor: Colors.white,
                          progressColor: const Color(0xffFE8BD1),
                          barRadius: const Radius.circular(10),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  'assets/images/cloud.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "UrduType", fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Transform.translate(
                offset: const Offset(-40, 0),
                child: CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: frontCardWidgets.length, // assuming front and back lists are of the same length
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return FlipCard(
                      onFlip: () {
                        if (_current == index) {
                          setState(() {
                            _maxNavigableIndex = max(_maxNavigableIndex, index + 1);
                            if(index == frontCardWidgets.length - 1) {
                              _isLastCardFlipped = true;
                            }
                          });
                        }
                      },

                      fill: Fill.fillBack,
                      direction: FlipDirection.HORIZONTAL,
                      front: frontCardWidgets[index],
                      back: backCardWidgets[index],
                    );
                  },
                  options: CarouselOptions(
                    height: 440.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      if (index <= _maxNavigableIndex) {
                        setState(() {
                          _current = index;
                        });
                      } else {
                        _carouselController.animateToPage(
                          _current,
                          duration: Duration(milliseconds: 600),  // Adjust duration as needed
                          curve: Curves.easeOut,  // Adjust curve as needed
                        );
                      }
                    },

                    aspectRatio: 16 / 9,
                    autoPlay: false,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: false,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.78,
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? const Color(0xff9AC9C2)
                          : const Color(0xffeaedee),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(color: Colors.black87.withOpacity(0.1)),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 2),
                backgroundColor: _isLastCardFlipped ? const Color(0xffFE8BD1) : Colors.grey,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(150, 37),
              ),
              onPressed: _isLastCardFlipped ? () {
                // handle the button press logic here
              } : null,  // null disables the button
              child: const Text(
                'جاری رہے',
                style: TextStyle(
                  fontFamily: 'UrduType',
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
