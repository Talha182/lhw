import 'dart:async';
import 'package:lhw/Presentation/presentation_model.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

import '../Quiz_Widgets/QuizCard.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Branching/LessonOption24.dart';
import '../FlashCard/flash_cards_screen.dart';
import '../Quiz_Widgets/QuizCard.dart';
import 'package:flutter/services.dart';

import '../controllers/BookmarkController.dart';
import '../controllers/feature_navigation.dart';

class Presentation extends StatefulWidget {
  final PresentationModel presentationModel;
  const Presentation({super.key, required this.presentationModel});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  bool isPlaying = false;
  final BookmarkController bookmarkController = Get.put(BookmarkController());
  int currentPage = 0;

  bool isSelected = false;
  bool isAnswered = false;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;
  bool isDialogShown = false;

  List<Color> optionColors = [
    const Color(0xffF2F2F2),
    const Color(0xffF2F2F2),
    const Color(0xffF2F2F2)
  ];
  Timer? _slideshowTimer;

  List<bool> questionAttempted = []; // New list to track attempted questions
  @override
  void initState() {
    super.initState();
    // Initialize the questionAttempted list with false values for each question
    questionAttempted =
        List<bool>.filled(widget.presentationModel.questions.length, false);
  }

// Update the 'updateQuestion' method
  // Update the 'updateQuestion' method
  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered) return;
    setState(() {
      this.selectedAnswer = selectedAnswer;
      isAnswered = true;
      isSelected = true;
      selectedOptionIndex = index; // Add this line
      if (selectedAnswer ==
          widget.presentationModel.questions[questionIndex].correctAnswer) {
        optionColors[index] = Colors.green[100]!;
      } else {
        optionColors[index] = Colors.red[100]!;
      }
      questionAttempted[questionIndex] = true; // Mark the question as attempted
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (questionIndex < widget.presentationModel.questions.length - 1) {
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

  // Update the 'showQuestionDialogForImage' method
  void showQuestionDialogForImage(int imageIndex) {
    // Adjusted to ensure it uses the correct question index based on the image
    questionIndex =
        imageIndex - 1; // Assuming each image has a corresponding question
    if (questionIndex < 0 ||
        questionIndex >= widget.presentationModel.questions.length ||
        questionAttempted[questionIndex]) {
      return; // No question for this image, question already attempted, or out of bounds, so return early
    }
    showDialogWithQuestionOptions();
  }

  void navigateToNextImage() {
    bool isLastImage =
        currentPage == widget.presentationModel.assetImages.length - 1;

    if (!isLastImage) {
      // Move to the next image
      currentPage++;
      resetQuestionState(); // Reset the options when moving to the next image

      // Check if showQuestionDialog is true for the current image's corresponding question
      if (widget.presentationModel.showQuestionDialog[currentPage - 1]) {
        // Show the dialog for the current image's corresponding question
        showQuestionDialogForImage(currentPage);
      }
    } else {
      // If it's the last image, show the dialog for the last image's corresponding question (if needed)
      if (widget.presentationModel.showQuestionDialog.isNotEmpty &&
          widget.presentationModel.showQuestionDialog.last) {
        showQuestionDialogForImage(currentPage + 1);
      }
    }
  }

  void navigateToPreviousImage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--; // Move to the previous image
        resetQuestionState(); // Optionally reset question state here as well
      });
    }
  }

  void resetQuestionState() {
    setState(() {
      isSelected = false;
      isAnswered = false;
      selectedOptionIndex = null;
      optionColors = [
        const Color(0xffF2F2F2),
        const Color(0xffF2F2F2),
        const Color(0xffF2F2F2)
      ]; // Reset color states if needed
    });
  }

  bool isDialogCurrentlyShown = false;

  void showDialogWithQuestionOptions() {
    if (isDialogCurrentlyShown) {
      return; // Return early if dialog is currently shown
    }

    isDialogCurrentlyShown = true;
    showDialog(
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
                        widget.presentationModel.questions[questionIndex]
                            .question,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "UrduType"),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(
                        widget.presentationModel.questions[questionIndex]
                            .options.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: QuizCard(
                            text: widget.presentationModel
                                .questions[questionIndex].options[index],
                            ontap: () {
                              setState(() {
                                updateQuestion(
                                    widget
                                        .presentationModel
                                        .questions[questionIndex]
                                        .options[index],
                                    index);
                              });
                            },
                            color: optionColors[index],
                            isCorrect: selectedAnswer ==
                                widget.presentationModel
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
      resetQuestionState(); // Ensure state is reset after dialog is dismissed
    });
  }

  void startSlideshow() {
    const duration = Duration(
        seconds: 2); // Change the duration according to your preference
    _slideshowTimer = Timer.periodic(duration, (Timer timer) {
      if (currentPage < widget.presentationModel.assetImages.length - 1) {
        setState(() {
          currentPage++;
        });
      } else {
        timer
            .cancel(); // Stop the slideshow when it reaches the end of the images
        setState(() {
          isPlaying = false; // Update the play/pause state
        });
      }
    });
  }

  void stopSlideshow() {
    _slideshowTimer?.cancel(); // Cancel the timer if it's currently running
  }

  @override
  void dispose() {
    _slideshowTimer?.cancel();
    super.dispose();
  }

  double get progress =>
      (currentPage + 1) / widget.presentationModel.assetImages.length;

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
              const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 5),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
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
              SizedBox(
                height: 230,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(children: [
                    PinchZoomReleaseUnzoomWidget(
                        minScale: 0.8,
                        maxScale: 4,
                        resetDuration: const Duration(milliseconds: 200),
                        boundaryMargin: const EdgeInsets.only(bottom: 0),
                        clipBehavior: Clip.none,
                        useOverlay: true,
                        maxOverlayOpacity: 0.5,
                        overlayColor: Colors.black,
                        fingersRequiredToPinch: 2,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black87.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(widget.presentationModel
                                      .assetImages[currentPage]),
                                  fit: BoxFit.fill)),
                        )),
                    Positioned(
                      left: 10,
                      top: 100,
                      child: GestureDetector(
                        onTap: () {
                          navigateToPreviousImage();
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.4)),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 100,
                      child: GestureDetector(
                        onTap: () {
                          navigateToNextImage();
                          stopSlideshow(); // Add this to stop the slideshow if manually navigating

                          // showDialogWithQuestionOptions(); // Add this line to show the custom dialog.
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.4)),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: SizedBox(
                        child: LinearPercentIndicator(
                          lineHeight: 8.0,
                          percent: progress,
                          backgroundColor: Colors.white,
                          progressColor: const Color(0xffFE8BD1),
                          barRadius: const Radius.circular(10),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              Material(
                elevation: 1,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffEBEBEB)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isPlaying = !isPlaying;
                                    });
                                    if (isPlaying) {
                                      startSlideshow();
                                    } else {
                                      stopSlideshow();
                                    }
                                  },
                                  child: Icon(
                                    isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow_outlined,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffEBEBEB)),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                      () => FullScreenImagePage(
                                          assetImages: widget
                                              .presentationModel.assetImages,
                                          initialPage: currentPage),
                                      transition: Transition.fade,
                                      duration:
                                          const Duration(milliseconds: 300));
                                },
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/images/full_screen.svg",
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
                onPressed: () {},
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

class FullScreenImagePage extends StatefulWidget {
  final List<String> assetImages;
  final int initialPage;

  const FullScreenImagePage({
    Key? key,
    required this.assetImages,
    required this.initialPage,
  }) : super(key: key);

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: _currentPage);

    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    _pageController.dispose();

    // Reset to default orientation (portrait) when leaving the page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  void _nextImage() {
    if (_currentPage < widget.assetImages.length - 1) {
      _pageController.animateToPage(
        ++_currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousImage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        --_currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.assetImages.length,
              itemBuilder: (context, index) {
                return PinchZoomReleaseUnzoomWidget(
                    minScale: 0.8,
                    maxScale: 4,
                    resetDuration: const Duration(milliseconds: 200),
                    boundaryMargin: const EdgeInsets.only(bottom: 0),
                    clipBehavior: Clip.none,
                    useOverlay: true,
                    maxOverlayOpacity: 0.5,
                    overlayColor: Colors.black,
                    fingersRequiredToPinch: 2,
                  child: Image.asset(widget.assetImages[index],
                      fit: BoxFit.contain),
                );
              },
            ),
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height / 2 -
                  20, // Adjust for centering
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: _previousImage,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height / 2 -
                  20, // Adjust for centering
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.5)),
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.black),
                  onPressed: _nextImage,
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 30, // Adjust for centering

              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () async {
                  // Change orientation before popping the screen
                  await SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                  // Optionally wait for a short duration
                  await Future.delayed(const Duration(milliseconds: 100));
                  // Use Navigator.pop(context) if you're not using GetX
                  Get.back();
                },
              ),
            ),
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
