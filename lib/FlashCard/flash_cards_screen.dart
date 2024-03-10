import 'dart:async';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lhw/controllers/BookmarkController.dart';

import '../Presentation/Presentation.dart';
import '../models/flash_cards_screen_model.dart'; // Adjust the import path based on your project structure

class FlashCardsScreen extends StatefulWidget {
  final FlashCardScreenModel flashCardModel;
  final VoidCallback? onCompleted;

  const FlashCardsScreen(
      {Key? key, required this.flashCardModel, this.onCompleted})
      : super(key: key);

  @override
  _FlashCardsScreenState createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  final int _totalSteps = 100;
  bool _isLastCardFlipped = false;
  final BookmarkController bookmarkController = Get.put(BookmarkController());
  final CarouselController _carouselController = CarouselController();
  late List<bool> _flippedStates;
  bool isCurrentFlipped = false; // Add this line
  late AnimationController _cloudPumpAnimationController;
  late Animation<double> _cloudPumpAnimation;
  bool showMessage = true;
  double _fabYPosition = 600.0; // Default position



  @override
  void initState() {
    super.initState();
    _startMessageTimer();

    _flippedStates =
        List<bool>.filled(widget.flashCardModel.cards.length, false);
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


  @override
  Widget build(BuildContext context) {
    final fabHeight = 65.0; // Standard height of a FAB
    final topSafeArea = MediaQuery.of(context).padding.top;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    double screenWidth = MediaQuery.of(context).size.width;
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
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: 0,
                            end: ((_current + 1) / widget.flashCardModel.cards.length) * _totalSteps,
                          ),
                          duration: const Duration(milliseconds: 400),
                          builder: (BuildContext context, double value, Widget? child) {
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..scale(-1.0, 1.0), // Flipping horizontally
                              child: LinearPercentIndicator(
                                lineHeight: 8.0,
                                percent: min(value / _totalSteps, 1.0),
                                backgroundColor: Colors.white,
                                barRadius: const Radius.circular(10),
                                linearGradient: const LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [Color(0xffFE8BD1), Color(0xffFE8BD1)],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          final bookmarkController = Get.find<BookmarkController>();
                          bookmarkController.addBookmark(
                            Bookmark(
                              title: 'LessonOption20',
                              routeName: '/lessonOption20',
                            ),
                          );
                          Get.snackbar('Bookmark Added',
                              'This page has been added to your bookmarks');
                        },
                        child: const Icon(Icons.bookmark_outline),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 15),
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
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.flashCardModel.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: "UrduType", fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Transform.translate(

                    offset: const Offset(0, 0),
                    child: CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: widget.flashCardModel.cards.length,
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        final card = widget
                            .flashCardModel.cards[index]; // Use card from the model

                        return FlipCard(
                          onFlip: () {
                            setState(() {
                              _flippedStates[index] =
                                  true; // Mark the card as flipped
                              _isLastCardFlipped =
                                  index == widget.flashCardModel.cards.length - 1 &&
                                      _flippedStates.every((state) => state);
                              isCurrentFlipped =
                                  true; // Update isCurrentFlipped to true here
                            });
                          },
                          direction: FlipDirection.HORIZONTAL,
                          front: Container(
                            width: 280,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(card.frontImage),
                                    fit: BoxFit.fill)
                                // border: Border.all(
                                //     color: const Color(0xffF07DB2), width: 2),
                                ),
                          ),
                          back: Container(
                            width: 280,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(card.backImage),
                                    fit: BoxFit.fill)
                                // border: Border.all(
                                //     color: const Color(0xffF07DB2), width: 2),
                                ),
                          ),
                          // back: Container(
                          //   width: 280,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(15),
                          //     border: Border.all(
                          //         color: const Color(0xffF07DB2), width: 2),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: 30),
                          //     child: Center(
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Text(
                          //             card.heading,
                          //             textAlign: TextAlign.center,
                          //             style: TextStyle(
                          //                 fontSize: 25,
                          //                 fontFamily: "UrduType",
                          //                 color: card.titleColor),
                          //           ),
                          //           const SizedBox(height: 10),
                          //           Text(
                          //             card.description,
                          //             textAlign: TextAlign.center,
                          //             style: const TextStyle(
                          //               fontSize: 18,
                          //               fontFamily: "UrduType",
                          //               color: Colors.black,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        );
                      },
                      options: CarouselOptions(
                          height: 450.0,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            if (isCurrentFlipped || _flippedStates[index]) {
                              // This check ensures the next card is accessible only if the current is flipped
                              setState(() {
                                _current = index;
                                isCurrentFlipped = _flippedStates[
                                    index]; // Update based on the new current card's flipped state
                              });
                            }
                          },
                          aspectRatio: 16 / 9,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          viewportFraction: 0.78,
                          scrollPhysics: isCurrentFlipped
                              ? const PageScrollPhysics()
                              : const NeverScrollableScrollPhysics()),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.flashCardModel.cards.length,
                      // Use the length of cardData for dynamic indicator count
                      (index) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 2.0,
                          ),
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
                    backgroundColor: const Color(0xffFE8BD1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(150, 37),
                  ),
                  onPressed: _isLastCardFlipped
                      ? () {
                          if (widget.onCompleted != null) {
                            widget.onCompleted!();
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
              child:Container(
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
                                  'یہ فلیش کارڈ ہیں۔ ہر ایک کارڈ پر\n ضروری معلومات سے متعلق تصاویر ہیں۔\n ان پر ٹیپ کریں اور مزید سیکھیے۔',
                                  textAlign: TextAlign.center,
                                  textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontFamily: "UrduType"),
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
            ),
          ),

        ],
      ),
    );
  }
}

class Bookmark {
  final String title;
  final String routeName;

  Bookmark({required this.title, required this.routeName});
}
