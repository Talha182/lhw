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
  final VoidCallback? onCompleted; // Optional callback

  const ImageBranchingScenario(
      {super.key, required this.imageBranchingScenarioModel,this.onCompleted});

  @override
  State<ImageBranchingScenario> createState() => _ImageBranchingScenarioState();
}

class _ImageBranchingScenarioState extends State<ImageBranchingScenario>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;
  bool isAnswered = false;

  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;
  final BookmarkController bookmarkController = Get.put(BookmarkController());

  final CarouselController _carouselController = CarouselController();

  List<Color> optionColors = [Colors.white, Colors.white, Colors.white];
  late AnimationController _cloudPumpAnimationController;
  late Animation<double> _cloudPumpAnimation;

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
  void initState() {
    super.initState();

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
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
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
                    padding: const EdgeInsets.only(right: 10),
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
                    child: ListView(
                      children: [
                        Material(
                          elevation:
                              2.0, // Adjust the elevation level as desired
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
                                        items: widget
                                            .imageBranchingScenarioModel
                                            .questions[questionIndex]
                                            .imagePaths
                                            .map((imagePath) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin:
                                                    const EdgeInsets.symmetric(
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
                                          duration:
                                              const Duration(milliseconds: 300),
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
                            style:
                                TextStyle(fontFamily: "UrduType", fontSize: 23),
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
                                    widget
                                        .imageBranchingScenarioModel
                                        .questions[questionIndex]
                                        .options[index],
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 5),
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
                                    color: isAnswered && questionIndex == widget.imageBranchingScenarioModel.questions.length - 1
                                        ? const Color(0xffFE8BD1) // Button enabled color
                                        : Colors.grey, // Button disabled color
                                    borderRadius: BorderRadius.circular(30)),
                                child: TextButton(
                                  onPressed: isAnswered && questionIndex == widget.imageBranchingScenarioModel.questions.length - 1
                                      ? () {
                                    if(widget.onCompleted != null) {
                                      widget.onCompleted!(); // Optionally call the completion callback if provided
                                    }
                                    Get.back();                                  }
                                      : null, // Disable button if not the last question or not answered
                                  child: const Center(
                                    child: Text(
                                      'جاری',
                                      style: TextStyle(
                                        fontFamily: 'UrduType',
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
  final VoidCallback ontap;
  final Color color;
  final bool isCorrect;
  final bool isSelected;
  final bool isAnswered;
  final bool isOptionSelected;

  const QuizCard({
    Key? key,
    required this.text,
    required this.ontap,
    this.color = const Color(0xffF2F2F2),
    this.isCorrect = false,
    this.isSelected = false,
    this.isAnswered = false,
    this.isOptionSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isAnswered ? null : ontap,
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
                    border: Border.all(color: Colors.black87.withOpacity(0.2)),
                    shape: BoxShape.circle,
                    color: isOptionSelected ? (isCorrect ? Colors.green : Colors.red) : Colors.transparent,
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
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String correctExplanation;
  final String incorrectExplanation;
  final List<String> imagePaths;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
    required this.imagePaths,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      correctExplanation: json['correctExplanation'],
      incorrectExplanation: json['incorrectExplanation'],
      imagePaths: List<String>.from(json['imagePaths']),
    );
  }
}

class ImageBranchingScenarioModel {
  final List<Question> questions;

  ImageBranchingScenarioModel({required this.questions});

  factory ImageBranchingScenarioModel.fromJson(Map<String, dynamic> json) {
    var questionsFromJson = json['questions'] as List;
    List<Question> questionList = questionsFromJson
        .map((questionJson) => Question.fromJson(questionJson))
        .toList();
    return ImageBranchingScenarioModel(questions: questionList);
  }
}
