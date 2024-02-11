import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lhw/controllers/BookmarkController.dart';

import '../controllers/feature_navigation.dart'; // Adjust the import path based on your project structure

class FlashCardsScreen extends StatefulWidget {
  final FlashCardScreenModel flashCardScreenModel;

  const FlashCardsScreen({Key? key, required this.flashCardScreenModel}) : super(key: key);

  @override
  _FlashCardsScreenState createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen> {
  int _current = 0;
  final int _totalSteps = 100;
  bool _isLastCardFlipped = false;
  final BookmarkController bookmarkController = Get.put(BookmarkController());
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  const Icon(
                    Icons.close,
                    size: 30,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: 0,
                          end: ((_current + 1) / widget.flashCardScreenModel.cards.length) * _totalSteps),
                      duration: const Duration(milliseconds: 400),
                      builder: (BuildContext context, double value, Widget? child) {
                        return LinearPercentIndicator(
                          lineHeight: 8.0,
                          percent: min(value / _totalSteps, 1.0),
                          backgroundColor: Colors.white,
                          progressColor: const Color(0xffFE8BD1),
                          barRadius: const Radius.circular(10),
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
                      Get.snackbar('Bookmark Added', 'This page has been added to your bookmarks');
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
                child: SvgPicture.asset(
                  'assets/images/cloud.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'ٹی بی  اور اس کی علامات۔',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "UrduType", fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Transform.translate(
              offset: const Offset(-40, 0),
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: widget.flashCardScreenModel.cards.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  final card = widget.flashCardScreenModel.cards[index]; // Use card from the model

                  return FlipCard(
                    onFlip: () {
                      setState(() {
                        _isLastCardFlipped = index == widget.flashCardScreenModel.cards.length - 1;
                      });
                    },
                    direction: FlipDirection.HORIZONTAL,
                    front: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xffF07DB2), width: 2),
                      ),
                      child: Center(
                        child: Image.asset(
                          card.frontImage,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    back: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xffF07DB2), width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                card.heading,
                                textAlign: TextAlign.center,
                                style:  TextStyle(
                                  fontSize: 25,
                                  fontFamily: "UrduType",
                                  color: card.titleColor
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                card.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "UrduType",
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 380.0,
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.flashCardScreenModel.cards.length,
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
                      color: _current == index ? const Color(0xff9AC9C2) : const Color(0xffeaedee),
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
              onPressed: () {
                // Do something when the button is pressed
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
    );
  }
}

class FlashCardScreenModel {
  final String title; // Main heading for the screen
  final List<FlashCard> cards; // List of flashcard objects

  FlashCardScreenModel({
    required this.title,
    required this.cards,
  });
}

class FlashCard {
  final String frontImage; // Path to the image on the front side
  final String heading; // Title displayed on the back side
  final String description; // Optional description on the back side
  final Color? titleColor; // Optional color for the title

  FlashCard({
    required this.frontImage,
    required this.heading,
    required this.description,
    this.titleColor,
  });
}

class Bookmark {
  final String title;
  final String routeName;

  Bookmark({required this.title, required this.routeName});
}
