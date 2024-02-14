import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Result/ResultScreen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lhw/models/question_model.dart';

import '../controllers/BookmarkController.dart';
import '../FlashCard/flash_cards_screen.dart';
import '../controllers/QuizController.dart';

class TextBranchingScenario extends StatefulWidget {
  final TextBranchingScenarioModel textBranchingScenarioModel;
  const TextBranchingScenario({super.key, required this.textBranchingScenarioModel});

  @override
  _TextBranchingScenarioState createState() => _TextBranchingScenarioState();
}

class _TextBranchingScenarioState extends State<TextBranchingScenario> {
  bool isSelected = false;
  bool isAnswered = false;
  final ResultsController resultsController = Get.put(ResultsController());
  final BookmarkController bookmarkController = Get.put(BookmarkController());
  // final navigationController = Get.find<FeatureNavigationController>();

  int _current = 0;
  int _totalSteps = 100;
  int questionIndex = 0;
  String selectedAnswer = '';

  List<Color> optionColors = [Colors.white, Colors.white, Colors.white];
  List<bool> isSelectedList = [
    false,
    false,
    false
  ]; // assuming 3 options per question

// Update the 'updateQuestion' method
  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered) {
      return;
    }

    setState(() {
      this.selectedAnswer = selectedAnswer;
      isAnswered = true;
      isSelectedList[index] = true;
      String explanation;

      if (selectedAnswer == widget.textBranchingScenarioModel.questions[questionIndex].correctAnswer) {
        optionColors[index] = Colors.green[100]!;
        explanation = widget.textBranchingScenarioModel.questions[questionIndex].correctExplanation;
      } else {
        optionColors[index] = Colors.red[100]!;
        explanation = widget.textBranchingScenarioModel.questions[questionIndex].incorrectExplanation;
      }

      _showAnswerDialog(
          context,
          selectedAnswer == widget.textBranchingScenarioModel.questions[questionIndex].correctAnswer,
          explanation);
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (questionIndex < widget.textBranchingScenarioModel.questions.length - 1) {
        setState(() {
          questionIndex++;
          _current = questionIndex + 1; // Update current question number
          optionColors = [Colors.white, Colors.white, Colors.white];
          isAnswered = false;
          isSelectedList = [false, false, false]; // Reset for the next question
        });
      } else {
        // Show result screen
        Get.to(() => ResultsScreen(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 300));
      }
    });
    Question currentQuestion = widget.textBranchingScenarioModel.questions[questionIndex];
    currentQuestion.userAnswer =
        selectedAnswer; // Add a userAnswer field to your Question class
    resultsController.addQuestionAnswer(currentQuestion);
  }

  void _showAnswerDialog(
      BuildContext context, bool isCorrect, String explanation) {
    showAnimatedDialog(
      curve: Curves.fastOutSlowIn,
      animationType: DialogTransitionType.sizeFade,
      duration: const Duration(seconds: 1),
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: double.infinity, // Ensure the container takes full width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isCorrect
                      ? const Color(0xff9AC9C2)
                      : const Color(0xffFB6262),
                ),
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isCorrect
                                ? const Color(0xff9AC9C2).withOpacity(0.3)
                                : const Color(0xffFB6262).withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCorrect ? Icons.check : Icons.close,
                            size: 30,
                            color: isCorrect
                                ? const Color(0xff9AC9C2)
                                : const Color(0xffFB6262),
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Add spacing before the text
                        Text(
                          isCorrect ? "درست" : "غلط",
                          style: TextStyle(
                            fontFamily: "UrduType",
                            color: isCorrect
                                ? const Color(0xff47857C)
                                : const Color(0xffFB6262),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                            height: 10), // Add spacing before the explanation
                        Text(
                          explanation,
                          style: const TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _totalSteps = widget.textBranchingScenarioModel.questions.length; // Add this line

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 60, left: 20, right: 10),
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
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TweenAnimationBuilder(
                            tween: Tween<double>(
                              begin: 0,
                              end: _current /
                                  widget.textBranchingScenarioModel.questions
                                      .length, // Correct end value for the tween
                            ),
                            duration: const Duration(milliseconds: 400),
                            builder: (BuildContext context, double value,
                                Widget? child) {
                              return LinearPercentIndicator(
                                lineHeight: 8.0,
                                percent:
                                value, // Use the animated value for the percent
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.textBranchingScenarioModel.questions[questionIndex].question,
                      textAlign: TextAlign.center,
                      style:
                      const TextStyle(fontFamily: "UrduType", fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: List.generate(
                      widget.textBranchingScenarioModel.questions[questionIndex].options.length,
                          (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: QuizCard(
                          text: widget.textBranchingScenarioModel.questions[questionIndex].options[index],
                          imagePath: 'assets/images/quiz${index + 1}.png',
                          color: optionColors[index],
                          ontap: () => updateQuestion(
                              widget.textBranchingScenarioModel.questions[questionIndex].options[index], index),
                          isCorrect: selectedAnswer ==
                              widget.textBranchingScenarioModel.questions[questionIndex].correctAnswer,
                          isSelected:
                          isSelectedList[index], // use the list here
                        ),
                      ),
                    ).animate(interval: 200.ms).fade(duration: 200.ms),
                  ),
                ]),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
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
                      // navigationController.navigateToNextFeatureOrBack();
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
                  )),
            ),
          ),
          Positioned(
              bottom: 70, // Adjust as needed
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
    );
  }
}

class QuizCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final Function ontap;
  final Color color;
  final bool isCorrect;
  final bool isSelected;
  final bool isAnswered;

  const QuizCard({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.ontap,
    this.color = Colors.white,
    this.isCorrect = false,
    this.isSelected = false,
    this.isAnswered = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAnswered ? null : () => ontap(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: 360,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? (isCorrect
                ? const Color(0xff9AC9C2)
                : const Color(0xffFB6262))
                : const Color(0xffB1B2B4),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Container(
              width: 360,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            text,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff7A7D84),
                              fontFamily: 'UrduType',
                            ),
                          ),
                        ),
                      ],
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


class TextBranchingScenarioModel {
  final List<Question> questions;

  TextBranchingScenarioModel({required this.questions});

  factory TextBranchingScenarioModel.fromJson(Map<String, dynamic> json) {
    var questionsFromJson = json['questions'] as List;
    List<Question> questionList = questionsFromJson.map((questionJson) => Question.fromJson(questionJson)).toList();
    return TextBranchingScenarioModel(questions: questionList);
  }
}
