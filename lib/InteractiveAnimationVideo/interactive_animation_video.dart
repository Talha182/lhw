// ignore_for_file: unused_field

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

import '../Quiz/MCQ 4.dart';
import '../controllers/BookmarkController.dart';
import '../FlashCard/flash_cards_screen.dart';
import '../controllers/feature_navigation.dart';
import '../models/interactive_animation_model.dart';

class InteractiveAnimationVideo extends StatefulWidget {
  final InteractiveAnimationVideoModel interactiveAnimationVideoModel;
  const InteractiveAnimationVideo({
    super.key,
    required this.interactiveAnimationVideoModel,
  });

  @override
  State<InteractiveAnimationVideo> createState() =>
      _InteractiveAnimationVideoState();
}

class _InteractiveAnimationVideoState extends State<InteractiveAnimationVideo> {
  late VideoPlayerController _videoController;
  late FlickManager flickManager;
  late Set<int> _shownQuestions; // Track which questions have been shown
  bool _isDialogCurrentlyShown = false;
  bool isSelected = false;
  bool isAnswered = false;
  int _current = 0;
  int _totalSteps = 100;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;
  bool isDialogShown = false;
  final BookmarkController bookmarkController = Get.put(BookmarkController());
  // final navigationController = Get.find<FeatureNavigationController>();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
        widget.interactiveAnimationVideoModel.videoPath)
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(_videoListener);
    flickManager = FlickManager(videoPlayerController: _videoController);
    _shownQuestions = {};
  }

  @override
  void dispose() {
    _videoController.removeListener(_videoListener);
    _videoController.dispose();
    flickManager.dispose();
    super.dispose();
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

// Update the 'updateQuestion' method
  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered) return;
    setState(() {
      this.selectedAnswer = selectedAnswer;
      isAnswered = true;
      isSelected = true;
      selectedOptionIndex = index; // Add this line
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
    if (isDialogCurrentlyShown) {
      return; // Return early if dialog is currently shown
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
    // Handle the selected answer here
    // You can use setState to update UI based on user's selection
    // Once answered, resume video playback
    _videoController.play();
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
        child: Padding(
          padding:
              const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 5),
          child: Column(
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
                padding: const EdgeInsets.only(right: 20, bottom: 10),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

