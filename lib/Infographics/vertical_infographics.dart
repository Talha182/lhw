import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class VerticalInfographics extends StatefulWidget {
  final List<String> imagePaths;
  final List<String> imageTexts;

  const VerticalInfographics({
    Key? key,
    required this.imagePaths,
    required this.imageTexts,
  })  : assert(imagePaths.length == imageTexts.length,
            'Image paths and texts must have the same length.'),
        super(key: key);

  @override
  _VerticalInfographicsState createState() => _VerticalInfographicsState();
}

class _VerticalInfographicsState extends State<VerticalInfographics> {
  Random random = Random();

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
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
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
                  padding:
                      const EdgeInsets.only(right: 30, top: 20, bottom: 30),
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
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const ScrollPhysics(), // Add this to enable scrolling within GridView

                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            0.75, // Adjust based on your content size
                      ),
                      itemCount: widget.imagePaths.length,
                      itemBuilder: (context, index) {
                        Color borderColor = random.nextBool()
                            ? const Color(0xffAEDDBF)
                            : const Color(0xffF49FC6);
                        return Expanded(
                          flex: 2,
                          child: _buildCircleAndRectangleContainer(
                              widget.imagePaths[index],
                              borderColor,
                              widget.imageTexts[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0, // Adjust the position as needed
              child: Container(
                height: 65,
                width: Get.width,
                color: Colors.white,
                child: Column(
                  children: [
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
                    ),
                  ],
                ),
              )),
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
      width: 170, // Match this width with the circle's width for alignment
      height: 50, // Rectangle height
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
}
