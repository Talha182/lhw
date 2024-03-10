import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';
import '../Presentation/Presentation.dart';
import '../controllers/BookmarkController.dart';
import '../FlashCard/flash_cards_screen.dart';

class InteractiveAnimationVideo extends StatefulWidget {
  final InteractiveAnimationVideoModel interactiveAnimationVideoModel;
  final VoidCallback? onCompleted;

  const InteractiveAnimationVideo(
      {super.key,
        required this.interactiveAnimationVideoModel,
        this.onCompleted});

  @override
  State<InteractiveAnimationVideo> createState() =>
      _InteractiveAnimationVideoState();
}

class _InteractiveAnimationVideoState extends State<InteractiveAnimationVideo>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late FlickManager flickManager;
  late Set<int> _shownQuestions; // Track which questions have been shown
  final bool _isDialogCurrentlyShown = false;
  bool isSelected = false;
  bool isAnswered = false;
  int _current = 0;
  final int _totalSteps = 100;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;
  bool isDialogShown = false;
  final BookmarkController bookmarkController = Get.put(BookmarkController());
  late AnimationController _cloudPumpAnimationController;
  late Animation<double> _cloudPumpAnimation;
  bool showMessage = true;

  @override
  void initState() {
    super.initState();
    _startMessageTimer();

    _videoController = VideoPlayerController.network(
        widget.interactiveAnimationVideoModel.videoPath)
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(_videoListener);
    flickManager = FlickManager(videoPlayerController: _videoController);
    _shownQuestions = {};
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

  void _videoListener() {
    Duration position = _videoController.value.position;
    for (int i = 0;
    i < widget.interactiveAnimationVideoModel.questionDurations.length;
    i++) {
      if (position >=
          widget.interactiveAnimationVideoModel.questionDurations[i] &&
          !_shownQuestions.contains(i)) {
        _videoController.pause();
        _shownQuestions.add(i);
        showDialogWithQuestionOptions(i); // Show question at index i
        break; // Exit loop after showing a question
      }
    }
  }

  List<Color> optionColors = [
    const Color(0xffF2F2F2),
    const Color(0xffF2F2F2),
    const Color(0xffF2F2F2)
  ];

  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered) return;
    setState(() {
      this.selectedAnswer = selectedAnswer;
      isAnswered = true;
      isSelected = true;
      selectedOptionIndex = index;
      if (selectedAnswer ==
          widget.interactiveAnimationVideoModel.questions[questionIndex]
              .correctAnswer) {
        optionColors[index] = Colors.green[100]!;
      } else {
        optionColors[index] = Colors.red[100]!;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (questionIndex <
          widget.interactiveAnimationVideoModel.questions.length - 1) {
        setState(() {
          questionIndex++;
          _current = ((questionIndex /
              widget.interactiveAnimationVideoModel.questions.length) *
              1)
              .toInt();
          optionColors = [Colors.white, Colors.white, Colors.white];
          isAnswered = false; // Reset for the next question
          isSelected = false; // Reset isSelected
          selectedOptionIndex = null; // Reset selectedOptionIndex
        });
      }
    });
  }

  bool isDialogCurrentlyShown = false;

  void showDialogWithQuestionOptions(int questionIndex) {
    if (isDialogCurrentlyShown || isAnswered) {
      return;
    }
    isDialogCurrentlyShown = true;
    showAnimatedDialog(
      curve: Curves.fastOutSlowIn,
      animationType: DialogTransitionType.sizeFade,
      duration: const Duration(seconds: 1),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.interactiveAnimationVideoModel
                            .questions[questionIndex].question,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "UrduType"),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(
                        widget.interactiveAnimationVideoModel
                            .questions[questionIndex].options.length,
                            (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: QuizCard(
                            text: widget.interactiveAnimationVideoModel
                                .questions[questionIndex].options[index],
                            ontap: () {
                              setState(() {
                                updateQuestion(
                                    widget
                                        .interactiveAnimationVideoModel
                                        .questions[questionIndex]
                                        .options[index],
                                    index);
                              });
                            },
                            color: optionColors[index],
                            isCorrect: selectedAnswer ==
                                widget.interactiveAnimationVideoModel
                                    .questions[questionIndex].correctAnswer,
                            isSelected: isSelected,
                            isOptionSelected: index == selectedOptionIndex,
                            isAnswered: isAnswered,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade200,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected
                                ? const Color(0xffFE8BD1) // Original color
                                : Colors
                                .grey, // Grey color when option not selected
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(240, 37),
                          ),
                          onPressed: isSelected
                              ? () {
                            Navigator.of(context)
                                .pop(); // Close the dialog when button is pressed
                          }
                              : null, // Set to null when option is not selected, making it non-clickable
                          child: const Text(
                            'جاری رہے',
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
            );
          },
        );
      },
    ).then((_) {
      isDialogCurrentlyShown = false;
      _videoController.play(); // Play the video when the dialog is dismissed
    });
  }

  void _handleAnswer(String selectedAnswer, int questionIndex) {
    _videoController.play();
  }

  @override
  void dispose() {
    _videoController.removeListener(_videoListener);
    _videoController.dispose();
    flickManager.dispose();
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
                          'یہ سبق ہم ایک ویڈیو کے ذریعے سیکھیں گیں۔\n اسے بہتر سمجھنے کے لیے اپنے\n موبائل کی آواز اونچی کریں۔',
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
        child: Padding(
          padding:
          const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 5),
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
                      builder:
                          (BuildContext context, double value, Widget? child) {
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
                padding: const EdgeInsets.only(right: 20, bottom: 5, top: 10),
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
              const SizedBox(
                height: 20,
              ),
              Expanded(
                // Use 'Expanded' here to occupy the remaining space
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FlickVideoPlayer(
                        flickManager: flickManager,
                        flickVideoWithControls: FlickVideoWithControls(
                          controls: FlickPortraitControls(
                            progressBarSettings: FlickProgressBarSettings(
                              handleColor: const Color(0xffFE8BD1),
                              playedColor: const Color(0xffFE8BD1),
                              bufferedColor: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.black87.withOpacity(0.1),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFE8BD1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(150, 37),
                ),
                onPressed: (_videoController.value.position.inSeconds >=
                    _videoController.value.duration.inSeconds - 1)
                    ? () async {
                  // Call the callback to mark completion or navigate back
                  widget.onCompleted?.call();
                  Get.back(result: true);
                }
                    : null, // Button is disabled until the video finishes

                child: const Text(
                  'جاری',
                  style: TextStyle(
                    fontFamily: 'UrduType',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InteractiveAnimationVideoModel {
  final String videoPath;
  final List<Question> questions;
  final List<Duration> questionDurations;

  InteractiveAnimationVideoModel({
    required this.videoPath,
    required this.questions,
    required this.questionDurations,
  });

  factory InteractiveAnimationVideoModel.fromJson(Map<String, dynamic> json) {
    List<Question> questions = (json['questions'] as List)
        .map((questionJson) => Question.fromJson(questionJson))
        .toList();
    List<Duration> questionDurations = (json['questionDurations'] as List)
        .map((durationString) =>
        Duration(seconds: int.parse(durationString.split(":").last)))
        .toList();

    return InteractiveAnimationVideoModel(
      videoPath: json['videoPath'] ?? '',
      questions: questions ?? [],
      questionDurations: questionDurations ?? [],
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String correctExplanation;
  final String incorrectExplanation;
  // final List<String> imagePaths;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
    // required this.imagePaths,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] ?? '',
      options: List<String>.from(json['options']) ?? [],
      correctAnswer: json['correctAnswer'] ?? '',
      correctExplanation: json['correctExplanation'] ?? '',
      incorrectExplanation: json['incorrectExplanation']  ?? '',
      // imagePaths: List<String>.from(json['imagePaths']),
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
      child: Container(
        width: 380,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
                      fontSize: 15,
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