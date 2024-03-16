import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../Controllers/BookmarkController.dart';
import '../FlashCard/flash_cards_screen.dart';
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
  late AnimationController _cloudPumpAnimationController;
  late Animation<double> _cloudPumpAnimation;
  bool showMessage = true;
  double _fabYPosition = 600.0;
  bool isBookmarked = false;
  bool _hasViewedAllImages = false;
  @override
  void initState() {
    super.initState();
    _startMessageTimer();

    _carouselItems = widget.infographicsModel.infographics.map((infographic) {
      return _buildSlide(infographic); // Pass the whole object
    }).toList();

    _progressController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this)
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

    // Listen for changes to the animation and update the state to refresh the UI
  }

  @override
  void dispose() {
    _cloudPumpAnimationController.dispose();
    _progressController.dispose();

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

  Widget _buildSlide(Infographic infographic) {
    Color borderColor = infographic.borderColorValue; // Use the helper method
    return Container(
      margin: const EdgeInsets.only(top: 30),
      color: Colors.white,
      child: Stack(
        children: [
          Center(
              child: _buildCircleAndRectangleContainer(
            infographic.imagePath,
            borderColor,
            infographic.text,
          )),
        ],
      ),
    );
  }

  Widget _buildRectangleContainer(Color borderColor, String text) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 260, // Minimum width to match your desired fixed width
        maxWidth: 260, // Maximum width to match your desired fixed width
        minHeight: 70, // Minimum height to ensure it's not too small
      ),
      child: Container(
        padding: const EdgeInsets.all(
            8), // Add padding for the text inside the container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 4),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontFamily: "UrduType"),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleAndRectangleContainer(
      String imagePath, Color borderColor, String text) {
    return Stack(
      children: [
        _buildCircleContainer(imagePath, borderColor),
        Positioned(
            left: 40,
            bottom: 20,
            child: _buildRectangleContainer(borderColor, text)),
      ],
    );
  }

  Widget _buildCircleContainer(String imagePath, Color borderColor) {
    return Container(
      width: 350, // Circle size
      height: 350, // Circle size
      decoration: BoxDecoration(
        color: Colors.white, // Background color inside the circle
        shape: BoxShape.circle,
        // border: Border.all(color: borderColor, width: 4), // Circle border
        image: DecorationImage(
            image: Image.asset(imagePath, fit: BoxFit.cover).image, scale: 0.8),
      ),
    );
  }

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final fabHeight = 65.0; // Standard height of a FAB
    final topSafeArea = MediaQuery.of(context).padding.top;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                        child: Transform(
                          alignment:
                              Alignment.center, // Center the transformation
                          transform: Matrix4.identity()
                            ..scale(-1.0, 1.0), // Flip horizontally
                          child: LinearPercentIndicator(
                            animation: false,
                            animationDuration: 400,
                            lineHeight: 10.0,
                            percent: _progress,
                            backgroundColor: Colors.white,
                            clipLinearGradient: true,
                            barRadius: const Radius.circular(20),
                            // Flip the linear gradient to match the flipped indicator direction
                            linearGradient: const LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [Color(0xffFE8BD1), Color(0xffFE8BD1)],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Toggle bookmark state on tap
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                        },
                        child: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked
                              ? const Color(0xffFE8BD1)
                              : Colors
                                  .black, // Change icon based on bookmark state
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
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Text(
                    widget.infographicsModel.title,
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontFamily: "UrduType", fontSize: 22),
                  ),
                ),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: _carouselItems.length,
                      itemBuilder: (context, index, realIdx) {
                        return _carouselItems[index];
                      },
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        height: MediaQuery.of(context).size.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                            if (_carouselItems.length > 1) {
                              double endValue = index /
                                  (_carouselItems.length - 1).toDouble();
                              _progressAnimation =
                                  Tween<double>(begin: _progress, end: endValue)
                                      .animate(_progressController);

                              _progressController.forward(from: 0);
                            } else {
                              // If there's only one item, set progress to full because there's nowhere to slide.
                              _progress = 1.0;
                            }

                            // Check if the last slide has been reached at least once.
                            if (index == _carouselItems.length - 1) {
                              _hasViewedAllImages = true;
                            }
                          });
                        },
                      ),
                    ),
                  ),
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
                  onPressed: _hasViewedAllImages
                      ? () {
                          // This will only execute after all slides have been viewed at least once
                          if (widget.onCompleted != null) {
                            widget
                                .onCompleted!(); // Optionally call the completion callback if provided
                          }
                          Get.back();
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
          Positioned(
            bottom: 55, // Adjust as needed
            left: 0,
            right: 0,

            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    widget.infographicsModel.infographics.length, (index) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(index),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 3.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? const Color(0xffFE8BD1) // Highlighted dot color
                            : const Color.fromRGBO(
                                0, 0, 0, 0.2), // Non-highlighted dot color
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
            right: 20, // Distance from right
            top: _fabYPosition,
            child: GestureDetector(
              onVerticalDragUpdate: (dragUpdateDetails) {
                setState(() {
                  _fabYPosition += dragUpdateDetails.delta.dy;

                  // Clamp the position to prevent the FAB from moving off the screen
                  // Consider top and bottom safe areas (like notches and navigation bars)
                  _fabYPosition = _fabYPosition.clamp(
                      topSafeArea, screenHeight - fabHeight - bottomSafeArea);
                });
              },
              child: Container(
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

                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'کہانیوں سے بہتر استاد کوئی\n نہیں۔ چلیں ہم انہیں  پڑھیں۔',
                                  textAlign: TextAlign.center,
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: "UrduType"),
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
                    const SizedBox(
                      width: 5,
                    ),
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
            ),
          ),
        ],
      ),
    );
  }
}

class InfographicsModel {
  final String title;
  final List<Infographic> infographics;

  InfographicsModel({required this.infographics, required this.title});

  factory InfographicsModel.fromJson(Map<String, dynamic> json) {
    var list = json['infographics'] as List;
    List<Infographic> infographicsList =
        list.map((i) => Infographic.fromJson(i)).toList();
    return InfographicsModel(
        infographics: infographicsList, title: json['title'] ?? '');
  }
}

class Infographic {
  final String imagePath;
  final String text;
  final String borderColor; // New border color property as a hex string

  Infographic({
    required this.imagePath,
    required this.text,
    required this.borderColor, // Include in constructor
  });

  factory Infographic.fromJson(Map<String, dynamic> json) {
    return Infographic(
      imagePath: json['imagePath'],
      text: json['text'],
      borderColor: json['borderColor'] ?? '#FFFFFF', // Provide a default value
    );
  }

  // Helper method to convert borderColor string to Color
  Color get borderColorValue =>
      Color(int.parse(borderColor.replaceFirst('#', '0xff')));
}
