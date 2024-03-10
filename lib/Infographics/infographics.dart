import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../Presentation/Presentation.dart';

class InfographicScreen extends StatefulWidget {
  final InfographicsModel infographicsModel;
  final VoidCallback? onCompleted; // Optional callback

  const InfographicScreen(
      {super.key, required this.infographicsModel, this.onCompleted});

  @override
  _InfographicScreenState createState() => _InfographicScreenState();
}

class _InfographicScreenState extends State<InfographicScreen>
    with TickerProviderStateMixin {
  int _current = 0;
  double _progress = 0.0;
  late List<Widget> _carouselItems;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  Random random = Random();
  late AnimationController _cloudPumpAnimationController;
  late Animation<double> _cloudPumpAnimation;
  bool showMessage = true;

  @override
  void initState() {
    super.initState();
    _startMessageTimer();

    _carouselItems =
        List.generate(widget.infographicsModel.infographics.length, (index) {
      Color borderColor =
          random.nextBool() ? const Color(0xffAEDDBF) : const Color(0xffF49FC6);
      return _buildSlide(widget.infographicsModel.infographics[index].imagePath,
          borderColor, widget.infographicsModel.infographics[index].text);
    });

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Initialize _progressAnimation here
    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_progressController)
          ..addListener(() {
            setState(() {
              _progress = _progressAnimation.value;
            });
          });

    _cloudPumpAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _cloudPumpAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _cloudPumpAnimationController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    _cloudPumpAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _cloudPumpAnimationController.dispose();
    super.dispose();
  }
  void _startMessageTimer() {
    Timer(const Duration(seconds: 5), () {
      setState(() {
        showMessage = false;
      });
    });
  }

  void _showMessageAgain() {
    setState(() {
      showMessage = true;
    });
    _startMessageTimer();
  }


  Widget _buildSlide(String imagePath, Color borderColor, String text) {
    // Add 'text' parameter
    return Container(
      margin: const EdgeInsets.only(top: 30),
      color: Colors.white,
      child: Stack(
        children: [
          Center(
              child: _buildCircleAndRectangleContainer(
                  imagePath, borderColor, text)),
        ],
      ),
    );
  }

  Widget _buildCircleAndRectangleContainer(
      String imagePath, Color borderColor, String text) {
    return Stack(
      children: [
        _buildCircleContainer(imagePath, borderColor),
        Positioned(
            bottom: 0, child: _buildRectangleContainer(borderColor, text)),
      ],
    );
  }

  Widget _buildCircleContainer(String imagePath, Color borderColor) {
    return Container(
      width: 300, // Circle size
      height: 300, // Circle size
      decoration: BoxDecoration(
        color: Colors.white, // Background color inside the circle
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 4), // Circle border
        image: DecorationImage(
            image: Image.asset(imagePath, fit: BoxFit.contain).image),
      ),
    );
  }

  Widget _buildRectangleContainer(Color borderColor, String text) {
    // Add 'text' parameter
    return Container(
      width: 300, // Match this width with the circle's width for alignment
      height: 70, // Rectangle height
      decoration: BoxDecoration(
        color: Colors.white, // Rectangle background color
        borderRadius:
            BorderRadius.circular(10), // Rounded corners for the rectangle
        border: Border.all(color: borderColor, width: 4), // Rectangle border
      ),
      child: Center(
        child: Text(
          text, // Replace with your desired text
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontFamily: "UrduType"),
        ),
      ),
    );
  }

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 72.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (showMessage)
              GestureDetector(
                onTap: _showMessageAgain,
                child: CustomPaint(
                  painter: MenuBoxBackground(),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    // width: screenWidth * 0.7,

                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'اس چارٹ کو سمجھیئے۔ اس میں معلومات\n کا ایک بڑا ذخیرہ ہے۔',
                          textAlign: TextAlign.center,
                          textStyle: const TextStyle(fontSize: 18, color: Colors.white,fontFamily: "UrduType"),
                          speed: const Duration(milliseconds: 50),
                        ),
                      ],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 5000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 5,),
            GestureDetector(
              onTap: _showMessageAgain,
              child: CircleAvatar(
                backgroundColor: const Color(0xffF6B3D0),
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: SvgPicture.asset(
                    "assets/images/samina_instructor.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0, -0.2),
                colors: [
                  const Color(0xff80B8FB).withOpacity(0.5),
                  Colors.transparent
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Handle close button tap
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: LinearPercentIndicator(
                          animation: false,
                          animationDuration: 400,
                          lineHeight: 10.0,
                          percent: _progress,
                          progressColor: const Color(0xffFE8BD1),
                          backgroundColor: Colors.white,
                          clipLinearGradient: true,
                          barRadius: const Radius.circular(20),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ScaleTransition(
                      scale: _cloudPumpAnimation,
                      child: SvgPicture.asset(
                        'assets/images/cloud.svg',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: _carouselItems.length,
                    itemBuilder: (context, index, realIdx) {
                      return _carouselItems[index];
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: MediaQuery.of(context).size.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                          _progress = (index + 1) / _carouselItems.length;
                          _progressController.animateTo(
                              _progress); // This line assumes you're updating progress based on page change
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      widget.infographicsModel.infographics.length, (index) {
                    return GestureDetector(
                      onTap: () => _carouselController.animateToPage(index),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? const Color(0xff9AC9C2) // Highlighted dot color
                              : const Color.fromRGBO(
                                  0, 0, 0, 0.4), // Non-highlighted dot color
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black87.withOpacity(0.2),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 2),
                    backgroundColor: const Color(0xffFE8BD1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(150, 37),
                  ),
                  onPressed: _current == _carouselItems.length - 1
                      ? () {
                          // This will only execute on the last slide
                          if (widget.onCompleted != null) {
                            widget
                                .onCompleted!(); // Optionally call the completion callback if provided
                          }
                          Get.back(result: true);
                        }
                      : null,
                  child: const Text(
                    'جاری',
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
        ],
      ),
    );
  }
}

class InfographicsModel {
  final List<Infographic> infographics;

  InfographicsModel({required this.infographics});

  factory InfographicsModel.fromJson(Map<String, dynamic> json) {
    var list = json['infographics'] as List;
    List<Infographic> infographicsList =
        list.map((i) => Infographic.fromJson(i)).toList();
    return InfographicsModel(infographics: infographicsList);
  }
}

class Infographic {
  final String imagePath;
  final String text;

  Infographic({required this.imagePath, required this.text});

  factory Infographic.fromJson(Map<String, dynamic> json) {
    return Infographic(
      imagePath: json['imagePath'],
      text: json['text'],
    );
  }
}
