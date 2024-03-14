import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Presentation/Presentation.dart';
import '../controllers/BookmarkController.dart';
import '../FlashCard/flash_cards_screen.dart';

class ImageBranchingScenario extends StatefulWidget {
  final ImageBranchingScenarioModel imageBranchingScenarioModel;
  final VoidCallback? onCompleted; // Optional callback

  const ImageBranchingScenario(
      {super.key, required this.imageBranchingScenarioModel, this.onCompleted});

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
  bool showMessage = true;
  double _fabYPosition = 600.0;

  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered)
      return; // Early return if an answer has already been selected

    // Determine if the selected answer is correct
    bool isCorrect = selectedAnswer ==
        widget
            .imageBranchingScenarioModel.questions[questionIndex].correctAnswer;

    // Update UI state to reflect selection and prevent further selections
    setState(() {
      this.selectedAnswer = selectedAnswer;
      isSelected = true; // Indicates an option has been selected
      selectedOptionIndex = index; // Tracks the selected option
      optionColors[index] = isCorrect ? Colors.green[100]! : Colors.red[100]!;
      isAnswered = true; // Prevents selecting another option
    });

    showAnimatedDialog(
      context: context,
      barrierDismissible: false, // Prevents dialog dismissal by tapping outside it
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: Stack(clipBehavior: Clip.none, children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 20, right: 60, bottom: 60, left: 60),
              child: Wrap(
                children: [
                  Text(
                    isCorrect
                        ? widget.imageBranchingScenarioModel.questions[questionIndex].correctExplanation
                        : widget.imageBranchingScenarioModel.questions[questionIndex].incorrectExplanation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -15,
              left: -55,
              child: Image.asset('assets/scripts/script11/2.png', width: 180, height: 180),
            ),
            Positioned(
              top: -40,
              right: -50,
              child: Image.asset('assets/scripts/script11/1.png', width: 180, height: 180),
            ),
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green, width: 2),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 110,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xffFE8BD1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "اگلے",
                      style: TextStyle(color: Colors.white, fontFamily: "UrduType"),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    ).then((_) {
      // Executes after the dialog is dismissed
      proceedToNextQuestionOrState(); // Proceed regardless of answer correctness
    });}

  void proceedToNextQuestionOrState() {
    if (questionIndex <
        widget.imageBranchingScenarioModel.questions.length - 1) {
      setState(() {
        questionIndex++;
        optionColors = [Colors.white, Colors.white, Colors.white];
        isAnswered = false;
        isSelected = false;
        selectedOptionIndex = null;
      });
      _carouselController.jumpToPage(0);
    } else {
      // This is where you handle what happens when all questions have been answered
      // For example, navigate to a results page or show a completion message
      // if (widget.onCompleted != null) {
      //   widget.onCompleted!();
      // }
      // Optionally, navigate back or to another screen
    }
  }

  @override
  void initState() {
    super.initState();
    _startMessageTimer();
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

  double get _currentProgress {
    int totalQuestions = widget.imageBranchingScenarioModel.questions.length;
    // Ensure the division is not by zero
    if (totalQuestions == 0) return 0.0;
    return (questionIndex + 1) / totalQuestions;
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

  // Method to show full-screen image on tap
  void _showFullScreenImage(String imagePath) {
    // Temporarily switch to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FullScreenImageViewer(imagePath: imagePath),
    )).then((_) {
      // Restore orientation preferences after the full-screen view is popped
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    });
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
                              tween: Tween<double>(begin: 0, end: _currentProgress),
                              duration: const Duration(milliseconds: 400),
                              builder: (BuildContext context, double value,
                                  Widget? child) {
                                return Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()..scale(-1.0, 1.0), // Flipping horizontally
                                  child: LinearPercentIndicator(
                                    lineHeight: 8.0,
                                    percent: value,
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
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black87.withOpacity(0.1))),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                          left: 15, right: 15, top: 15),
                                      height: 260,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          aspectRatio: 12 / 10,
                                          enlargeCenterPage: true,
                                          scrollDirection: Axis.horizontal,
                                          autoPlay: false,
                                          viewportFraction: 1,
                                        ),
                                        carouselController:
                                            _carouselController, // Ensure you've connected the CarouselController
                                        items: widget.imageBranchingScenarioModel
                                            .questions[questionIndex].imagePaths
                                            .map((imagePath) {
                                          return GestureDetector(
                                              onTap: () => _showFullScreenImage(imagePath),
                                            child: Builder(
                                              builder: (BuildContext context) {
                                                return ClipRRect(
                                                  borderRadius: BorderRadius.circular(
                                                      10), // Apply rounded corners to the ClipRRect
                                                  child: Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      image: DecorationImage(
                                                        image: AssetImage(imagePath),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }).toList(),
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
                                        color: isAnswered &&
                                                questionIndex ==
                                                    widget.imageBranchingScenarioModel
                                                            .questions.length -
                                                        1
                                            ? const Color(
                                                0xffFE8BD1) // Button enabled color
                                            : Colors.grey, // Button disabled color
                                        borderRadius: BorderRadius.circular(30)),
                                    child: TextButton(
                                      onPressed: isAnswered &&
                                              questionIndex ==
                                                  widget.imageBranchingScenarioModel
                                                          .questions.length -
                                                      1
                                          ? () {
                                              if (widget.onCompleted != null) {
                                                widget
                                                    .onCompleted!(); // Optionally call the completion callback if provided
                                              }
                                              Get.back(result: true);
                                            }
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

                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'اس مخصوص سبق میں ایک سوال کے\n آپ کو 3 جواب ملیں گے جن میں\n سے آپ کو سب سے درست جواب چننا ہوگا۔',
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
                    color: isOptionSelected
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


class FullScreenImageViewer extends StatelessWidget {
  final String imagePath;

  const FullScreenImageViewer({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 40,
          child: InteractiveViewer(
            panEnabled: true, // Set it to false to prevent panning.
            boundaryMargin: EdgeInsets.all(80),
            minScale: 0.5,
            maxScale: 4,
            child: Image.asset(imagePath),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

