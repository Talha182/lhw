import 'dart:async';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:lhw/Presentation/presentation_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../FlashCard/flash_cards_screen.dart';
import 'package:flutter/services.dart';

import '../controllers/BookmarkController.dart';

class Presentation extends StatefulWidget {
  final PresentationModel presentationModel;
  const Presentation({super.key, required this.presentationModel});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  final BookmarkController bookmarkController = Get.put(BookmarkController());
  int currentPage = 0;
  late PageController _pageController;
  bool hasVisitedLastImage = false; // Added variable to track last image visit
  bool isSelected = false;
  bool isAnswered = false;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;
  bool isDialogShown = false;
  late AnimationController _cloudPumpAnimationController;
  late Animation<double> _cloudPumpAnimation;

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
    questionAttempted =
        List<bool>.filled(widget.presentationModel.questions.length, false);
    _pageController = PageController();
    _pageController.addListener(() {
      // Update hasVisitedLastImage when the last image is reached
      if (_pageController.page ==
          widget.presentationModel.assetImages.length - 1) {
        setState(() {
          hasVisitedLastImage = true;
        });
      }
    });
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
      // Animate to the next page
      _pageController.animateToPage(
        ++currentPage,
        duration: const Duration(
            milliseconds: 300), // Customize the duration as needed
        curve: Curves.easeInOut, // Customize the animation curve as needed
      );
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
        // Animate to the previous page
        _pageController.animateToPage(
          --currentPage,
          duration: const Duration(
              milliseconds: 300), // Customize the duration as needed
          curve: Curves.easeInOut, // Customize the animation curve as needed
        );
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
    showAnimatedDialog(
      barrierDismissible: false,
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
          _pageController.animateToPage(
            ++currentPage,
            duration: const Duration(
                milliseconds: 300), // Customize the duration as needed
            curve: Curves.easeInOut, // Customize the animation curve as needed
          );
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
    _pageController.dispose();
    _cloudPumpAnimationController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                      tween: Tween<double>(begin: 0, end: 2.2),
                      duration: const Duration(milliseconds: 400),
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return LinearPercentIndicator(
                          lineHeight: 8.0,
                          percent: (currentPage + 1) /
                              widget.presentationModel.assetImages.length,
                          backgroundColor: const Color(0xffF5F5F5),
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
                        Get.snackbar('Bookmark Added',
                            'This page has been added to your bookmarks');
                      },
                      child: const Icon(Icons.bookmark_outline)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
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
              const Spacer(),
              Container(
                height: 320,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20, color: Colors.black.withOpacity(0.2))
                    ]),
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                          // height: 240,
                          child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount:
                                widget.presentationModel.assetImages.length,
                            onPageChanged: (int page) {
                              setState(() {
                                currentPage = page;
                              });
                            },
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: PinchZoom(
                                  resetDuration:
                                      const Duration(milliseconds: 100),
                                  maxScale: 3.0,
                                  child: Image.asset(
                                    widget.presentationModel.assetImages[index],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            right: 10,
                            bottom: 15,
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                        () => FullScreenImagePage(
                                              assetImages: widget
                                                  .presentationModel
                                                  .assetImages,
                                              initialPage: currentPage,
                                              questions: widget
                                                  .presentationModel.questions,
                                              showQuestionDialog: widget
                                                  .presentationModel
                                                  .showQuestionDialog,
                                            ),
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
                                )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: LinearPercentIndicator(
                              lineHeight: 8.0,
                              percent: (currentPage + 1) /
                                  widget.presentationModel.assetImages.length,
                              backgroundColor: const Color(0xffF5F5F5),
                              progressColor: const Color(0xffFE8BD1),
                              barRadius: const Radius.circular(10),
                            ),
                          )
                        ],
                      )),
                    ),
                    Container(
                      width: double.infinity,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => navigateToPreviousImage(),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.4)),
                                child: const Icon(Icons.arrow_back_ios_new,
                                    size: 16, color: Colors.white),
                              ),
                            ),
                            GestureDetector(
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
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffEBEBEB),
                                ),
                                child: Icon(
                                  isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow_outlined,
                                  size: 25,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                navigateToNextImage();
                                stopSlideshow();
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.4)),
                                child: const Icon(Icons.arrow_forward_ios,
                                    size: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Spacer(),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.black87.withOpacity(0.1),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFE8BD1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(150, 37),
                  ),
                  onPressed: hasVisitedLastImage
                      ? () {
                          Get.back();
                        }
                      : null,
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
  }
}

class FullScreenImagePage extends StatefulWidget {
  final List<String> assetImages;
  final List<Question> questions; // Changed from List<String> to List<Question>
  final List<bool> showQuestionDialog;

  final int initialPage;

  const FullScreenImagePage({
    Key? key,
    required this.assetImages,
    required this.initialPage,
    required this.questions,
    required this.showQuestionDialog,
  }) : super(key: key);

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late PageController _pageController;
  late int _currentPage;
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
    _currentPage = widget.initialPage;
    questionAttempted = List<bool>.filled(widget.questions.length, false);

    _pageController = PageController();
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

  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered) return;
    setState(() {
      this.selectedAnswer = selectedAnswer;
      isAnswered = true;
      isSelected = true;
      selectedOptionIndex = index; // Add this line
      if (selectedAnswer == widget.questions[questionIndex].correctAnswer) {
        optionColors[index] = Colors.green[100]!;
      } else {
        optionColors[index] = Colors.red[100]!;
      }
      questionAttempted[questionIndex] = true; // Mark the question as attempted
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (questionIndex < widget.questions.length - 1) {
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
        questionIndex >= widget.questions.length ||
        questionAttempted[questionIndex]) {
      return; // No question for this image, question already attempted, or out of bounds, so return early
    }
    showDialogWithQuestionOptions();
  }

  void navigateToNextImage() {
    bool isLastImage = currentPage == widget.assetImages.length - 1;

    if (!isLastImage) {
      // Animate to the next page
      _pageController.animateToPage(
        ++currentPage,
        duration: const Duration(
            milliseconds: 300), // Customize the duration as needed
        curve: Curves.easeInOut, // Customize the animation curve as needed
      );
      // Check if showQuestionDialog is true for the current image's corresponding question
      if (widget.showQuestionDialog[currentPage - 1]) {
        // Show the dialog for the current image's corresponding question
        showQuestionDialogForImage(currentPage);
      }
    } else {
      // If it's the last image, show the dialog for the last image's corresponding question (if needed)
      if (widget.showQuestionDialog.isNotEmpty &&
          widget.showQuestionDialog.last) {
        showQuestionDialogForImage(currentPage + 1);
      }
    }
  }

  void navigateToPreviousImage() {
    if (currentPage > 0) {
      setState(() {
        // Animate to the previous page
        _pageController.animateToPage(
          --currentPage,
          duration: const Duration(
              milliseconds: 300), // Customize the duration as needed
          curve: Curves.easeInOut, // Customize the animation curve as needed
        );
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
    showAnimatedDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.questions[questionIndex].question,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "UrduType"),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(
                        widget.questions[questionIndex].options.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: HorizontalQuizCard(
                            text:
                                widget.questions[questionIndex].options[index],
                            ontap: () {
                              setState(() {
                                updateQuestion(
                                    widget.questions[questionIndex]
                                        .options[index],
                                    index);
                              });
                            },
                            color: optionColors[index],
                            isCorrect: selectedAnswer ==
                                widget.questions[questionIndex].correctAnswer,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.assetImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(
                            widget.assetImages[index],
                          ),
                          fit: BoxFit.fitWidth)),
                );
              },
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitUp,
                        DeviceOrientation.portraitDown,
                      ]);
                      // Optionally wait for a short duration
                      await Future.delayed(const Duration(milliseconds: 100));
                      // Use Navigator.pop(context) if you're not using GetX
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
                          percent:
                              (_currentPage + 1) / widget.assetImages.length,
                          backgroundColor: const Color(0xffF5F5F5),
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
                        Get.snackbar('Bookmark Added',
                            'This page has been added to your bookmarks');
                      },
                      child: const Icon(Icons.bookmark_outline)),
                ],
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 20,
              right: 20,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: navigateToPreviousImage,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: Colors.white),
                        onPressed: navigateToNextImage,
                      ),
                    ),
                  ],
                ),
              ),
            )
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

class HorizontalQuizCard extends StatelessWidget {
  final String text;
  final Function ontap;
  final Color color;
  final bool isCorrect;
  final bool isSelected;
  final bool isAnswered;
  final bool isOptionSelected; // Define this parameter

  const HorizontalQuizCard({
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
        height: 40,
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
