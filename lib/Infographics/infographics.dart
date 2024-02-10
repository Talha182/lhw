import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

class Infographics extends StatefulWidget {
  final List<String> imagePaths;
  final List<String> imageTexts; // Add this line

  const Infographics({
    Key? key,
    required this.imagePaths,
    required this.imageTexts, // Add this line
  })  : assert(imagePaths.length == imageTexts.length,
            'Image paths and texts must have the same length.'),
        super(key: key); // Add assertion to check lengths match

  @override
  _InfographicsState createState() => _InfographicsState();
}

class _InfographicsState extends State<Infographics>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  double _progress = 0.0;
  late List<Widget> _carouselItems;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    _carouselItems = List.generate(widget.imagePaths.length, (index) {
      Color borderColor = random.nextBool()
          ? const Color(0xffAEDDBF)
          : const Color(0xffF49FC6); // Randomly choose the color
      return _buildSlide(widget.imagePaths[index], borderColor,
          widget.imageTexts[index]); // Pass corresponding text here
    });

    _progressController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this)
      ..addListener(() {
        setState(() {
          _progress = _progressAnimation.value;
        });
      });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
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
          // Center(child: _buildCircleContainer(imagePath, borderColor)),
          // Positioned(
          //   bottom:
          //       70, // Adjust this value to position the rectangle as desired above the circle
          //   left: 60,
          //   child:
          //       _buildRectangleContainer(borderColor, text), // Pass 'text' here
          // ),
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
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
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
                  padding: const EdgeInsets.only(right: 30),
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
                // const Padding(
                //   padding: EdgeInsets.all(10),
                //   child: Text(
                //     'آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(fontFamily: "UrduType", fontSize: 22),
                //   ),
                // ),

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
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30, // Adjust as needed
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.imagePaths.length, (index) {
                      return GestureDetector(
                        onTap: () => _carouselController.animateToPage(index),
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? const Color(0xff9AC9C2) // Highlighted dot color
                                : const Color.fromRGBO(0, 0, 0, 0.4), // Non-highlighted dot color
                          ),
                        ),
                      );
                    }),
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
                  onPressed: () {
                    Get.back();
                  },
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
        ],
      ),
    );
  }
}
