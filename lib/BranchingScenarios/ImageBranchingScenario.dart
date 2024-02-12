import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/BookmarkController.dart';
import '../FlashCard/flash_cards_screen.dart';

class ImageBranchingScenario extends StatefulWidget {
  final ImageBranchingScenarioModel imageBranchingScenarioModel;
  const ImageBranchingScenario(
      {super.key, required this.imageBranchingScenarioModel});

  @override
  State<ImageBranchingScenario> createState() => _ImageBranchingScenarioState();
}

class _ImageBranchingScenarioState extends State<ImageBranchingScenario> {
  bool isSelected = false;
  bool isAnswered = false;

  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;
  final BookmarkController bookmarkController = Get.put(BookmarkController());

  final CarouselController _carouselController = CarouselController();

  List<Color> optionColors = [Colors.white, Colors.white, Colors.white];

// Update the 'updateQuestion' method
  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered) return;
    setState(() {
      this.selectedAnswer = selectedAnswer;
      isAnswered = true;
      isSelected = true;
      selectedOptionIndex = index; // Add this line
      if (selectedAnswer ==
          widget.imageBranchingScenarioModel.questions[questionIndex]
              .correctAnswer) {
        optionColors[index] = Colors.green[100]!;
      } else {
        optionColors[index] = Colors.red[100]!;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (questionIndex <
          widget.imageBranchingScenarioModel.questions.length - 1) {
        setState(() {
          questionIndex++;
          optionColors = [Colors.white, Colors.white, Colors.white];
          isAnswered = false; // Reset for the next question
          isSelected = false; // Reset isSelected
          selectedOptionIndex = null; // Reset selectedOptionIndex
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0, -0.2),
            colors: [
              const Color(0xff80B8FB).withOpacity(0.3),
              Colors.transparent,
            ],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              child: ListView(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 2.2),
                          duration: const Duration(milliseconds: 400),
                          builder: (BuildContext context, double value,
                              Widget? child) {
                            return LinearPercentIndicator(
                              lineHeight: 8.0,
                              percent: 1,
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
                            final bookmarkController =
                                Get.find<BookmarkController>();
                            bookmarkController.addBookmark(
                              Bookmark(
                                  title: 'LessonOption20',
                                  routeName: '/lessonOption20'),
                            );
                            // Optionally, show a snackbar or some feedback to the user
                            Get.snackbar('Bookmark Added',
                                'This page has been added to your bookmarks');
                          },
                          child: const Icon(Icons.bookmark_outline)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 10),
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
                  Material(
                    elevation: 2.0, // Adjust the elevation level as desired
                    borderRadius: BorderRadius.circular(
                        10), // To match the Container's border radius
                    child: Container(
                      width: double.infinity,
                      height: 340,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.black87.withOpacity(0.1))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    aspectRatio: 16 / 9,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: false,
                                    viewportFraction:
                                        1.0, // Ensure each page takes up the full carousel width
                                  ),
                                  carouselController:
                                      _carouselController, // Ensure you've connected the CarouselController
                                  items: widget.imageBranchingScenarioModel
                                      .questions[questionIndex].imagePaths
                                      .map((imagePath) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: const BoxDecoration(
                                            color: Colors.amber,
                                          ),
                                          child: Image.asset(imagePath,
                                              fit: BoxFit.cover),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              widget.imageBranchingScenarioModel
                                  .questions[questionIndex].question,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: "UrduType", fontSize: 22),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
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
                                _carouselController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              },
                              child: const Text(
                                'اگلے',
                                style: TextStyle(
                                  fontFamily: 'UrduType',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Center(
                    child: Text(
                      "بہترین آپشن کا انتخاب کریں۔",
                      style: TextStyle(fontFamily: "UrduType", fontSize: 23),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: List.generate(
                      widget.imageBranchingScenarioModel
                          .questions[questionIndex].options.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: QuizCard(
                          text: widget.imageBranchingScenarioModel
                              .questions[questionIndex].options[index],
                          ontap: () => updateQuestion(
                              widget.imageBranchingScenarioModel
                                  .questions[questionIndex].options[index],
                              index),
                          color: optionColors[index],
                          isCorrect: selectedAnswer ==
                              widget.imageBranchingScenarioModel
                                  .questions[questionIndex].correctAnswer,
                          isSelected: isSelected,
                          isOptionSelected: index == selectedOptionIndex,
                        ),
                      ),
                    ).animate(interval: 200.ms).fade(duration: 200.ms),
                  ),
                  const Spacer(),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        child: Column(
                          children: [
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.black87.withOpacity(0.1),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 150,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFE8BD1),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                child: Text(
                                  'جاری رہے',
                                  style: TextStyle(
                                    fontFamily: 'UrduType',
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Positioned(
                bottom: 90, // Adjust as needed
                right: 15, // Adjust as needed
                child: CircleAvatar(
                  backgroundColor: const Color(0xffF6B3D0),
                  radius: 30,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: SvgPicture.asset(
                        "assets/images/samina_instructor.svg",
                        fit: BoxFit.fill,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  final String text;
  final Function ontap;
  final Color color;
  final bool isCorrect;
  final bool isSelected;
  final bool isAnswered;
  final bool isOptionSelected; // Define this parameter

  const QuizCard({
    Key? key,
    required this.text,
    required this.ontap,
    this.color = const Color(0xffF2F2F2),
    this.isCorrect = false,
    this.isSelected = false,
    this.isAnswered = false,
    this.isOptionSelected = false, // Initialize this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isAnswered ? null : () => ontap(),
      child: Expanded(
        child: Container(
          width: 360,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black87.withOpacity(0.2)),
                      shape: BoxShape.circle,
                      color: isOptionSelected // Use the parameter here
                          ? (isCorrect ? Colors.green : Colors.red)
                          : Colors.transparent,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff7A7D84),
                        fontFamily: 'UrduType',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String correctExplanation;
  final String incorrectExplanation;
  final List<String> imagePaths; // New property to hold image paths

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
    required this.imagePaths, // Initialize in the constructor
  });
}

class ImageBranchingScenarioModel {
  final List<Question> questions;
  ImageBranchingScenarioModel({required this.questions});
}
