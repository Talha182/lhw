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

  List<Map<String, dynamic>> cardData = [
    {
      'image': 'assets/images/flip1.png',
      'text': 'Back Side Text 1',
    },
    {
      'image': 'assets/images/flip1.png',
      'text': 'Back Side Text 2',
    },
    {
      'image': 'assets/images/flip1.png',
      'text': 'Back Side Text 3',
    },
    // Add more cards as needed
  ];



  final CarouselController _carouselController = CarouselController();


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
                          begin: 0, end: ((_current + 1) / cardData.length) * _totalSteps),
                      duration: const Duration(milliseconds: 400),
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return LinearPercentIndicator(
                          lineHeight: 8.0,
                          percent: min(value / _totalSteps, 1.0), // Ensure the percent doesn't exceed 1
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
                itemCount: cardData.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return FlipCard(
                    onFlip: () {
                      setState(() {
                        _isLastCardFlipped = index == cardData.length - 1;
                      });
                    },
                    direction: FlipDirection.HORIZONTAL,
                    front: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(cardData[index]['image']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    back: Container(
                      width: 280,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          cardData[index]['text'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "UrduType",
                          ),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 420.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                  aspectRatio: 16 / 9,
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.78,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                cardData.length, // Use the length of cardData for dynamic indicator count
                    (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
