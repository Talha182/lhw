import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../BookmarkController.dart';
import '../Mobile_Lesson & Flashcards/flash_cards_screen.dart';
import '../Quiz_Widgets/Question.dart';
import '../Quiz_Widgets/QuizCard.dart';
import 'package:flutter/services.dart';

import '../controllers/feature_navigation.dart';

class Presentation extends StatefulWidget {
  final List<String> assetImages; // Add this line

  const Presentation({super.key, required this.assetImages});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  bool isPlaying = false;
  final BookmarkController bookmarkController = Get.put(BookmarkController());
  int currentPage = 0;
  // final List<String> assetImages = [
  //   'assets/presentations/presentation1.png',
  //   'assets/presentations/presentation2.png',
  //   'assets/presentations/presentation3.png',
  //   'assets/presentations/presentation4.png',
  //   'assets/presentations/presentation5.png',
  //   'assets/presentations/presentation6.png',
  // ];
  bool isSelected = false;
  bool isAnswered = false;
  int _current = 0;
  int _totalSteps = 100;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;
  bool isDialogShown = false;
  final List<Question> questions = [
    Question(
      question:
          'آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔',
      options: [
        'بچے کی پیدائش کے بعد بھاری مادہ عام ہے. یہ دھیرے دھیرے کم ہو جائے گا، گلابی اور پھر سفید ہو جائے گا، بالکل آپ کے ماہواری کی طرح۔',
        'آپ کو مزید آرام کرنا چاہئے۔ یہ بچے کی پیدائش کے بعد آپ کی ضرورت سے زیادہ سرگرمی کی وجہ سے ہو سکتا ہے۔',
        'یہ انفیکشن کی نشاندہی کرسکتا ہے۔ میں مزید معائنے کے لیے آپ کو ہیلتھ سنٹر ریفر کروں گا۔'
      ],
      correctAnswer:
          'آپ کو مزید آرام کرنا چاہئے۔ یہ بچے کی پیدائش کے بعد آپ کی ضرورت سے زیادہ سرگرمی کی وجہ سے ہو سکتا ہے۔',
      correctExplanation:
          ' حیض کے خون سے مشابہ بھاری مادہ بچے کی پیدائش کے بعد ایک عام واقعہ ہے۔',
      incorrectExplanation:
          ' اگرچہ آرام ضروری ہے، یہ بھاری خارج ہونے والے مادہ کو براہ راست متاثر نہیں کرتا ہے جو کہ بعد از پیدائش صحت یابی کا ایک عام حصہ ہے۔',
    ),
    Question(
      question:
          'آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔',
      options: [
        'بچے کی پیدائش کے بعد بھاری مادہ عام ہے. یہ دھیرے دھیرے کم ہو جائے گا، گلابی اور پھر سفید ہو جائے گا، بالکل آپ کے ماہواری کی طرح۔',
        'آپ کو مزید آرام کرنا چاہئے۔ یہ بچے کی پیدائش کے بعد آپ کی ضرورت سے زیادہ سرگرمی کی وجہ سے ہو سکتا ہے۔',
        'یہ انفیکشن کی نشاندہی کرسکتا ہے۔ میں مزید معائنے کے لیے آپ کو ہیلتھ سنٹر ریفر کروں گا۔'
      ],
      correctAnswer:
          'آپ کو مزید آرام کرنا چاہئے۔ یہ بچے کی پیدائش کے بعد آپ کی ضرورت سے زیادہ سرگرمی کی وجہ سے ہو سکتا ہے۔',
      correctExplanation:
          ' حیض کے خون سے مشابہ بھاری مادہ بچے کی پیدائش کے بعد ایک عام واقعہ ہے۔',
      incorrectExplanation:
          ' اگرچہ آرام ضروری ہے، یہ بھاری خارج ہونے والے مادہ کو براہ راست متاثر نہیں کرتا ہے جو کہ بعد از پیدائش صحت یابی کا ایک عام حصہ ہے۔',
    ),
  ];
  final navigationController = Get.find<FeatureNavigationController>();

  List<Color> optionColors = [
    const Color(0xffF2F2F2),
    const Color(0xffF2F2F2),
    const Color(0xffF2F2F2)
  ];
  Timer? _slideshowTimer;

// Update the 'updateQuestion' method
  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered) return;
    setState(() {
      this.selectedAnswer = selectedAnswer;
      isAnswered = true;
      isSelected = true;
      selectedOptionIndex = index; // Add this line
      if (selectedAnswer == questions[questionIndex].correctAnswer) {
        optionColors[index] = Colors.green[100]!;
      } else {
        optionColors[index] = Colors.red[100]!;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (questionIndex < questions.length - 1) {
        setState(() {
          questionIndex++;
          _current = ((questionIndex / questions.length) * 1).toInt();
          optionColors = [Colors.white, Colors.white, Colors.white];
          isAnswered = false; // Reset for the next question
          isSelected = false; // Reset isSelected
          selectedOptionIndex = null; // Reset selectedOptionIndex
        });
      }
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
                        questions[questionIndex].question,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "UrduType"),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(
                        questions[questionIndex].options.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: QuizCard(
                            text: questions[questionIndex].options[index],
                            ontap: () {
                              setState(() {
                                updateQuestion(
                                    questions[questionIndex].options[index],
                                    index);
                              });
                            },
                            color: optionColors[index],
                            isCorrect: selectedAnswer ==
                                questions[questionIndex].correctAnswer,
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
    });
  }

  void startSlideshow() {
    const duration = Duration(
        seconds: 2); // Change the duration according to your preference
    _slideshowTimer = Timer.periodic(duration, (Timer timer) {
      if (currentPage < widget.assetImages.length - 1) {
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

  double get progress => (currentPage + 1) / widget.assetImages.length;

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
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black87.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          image: DecorationImage(
                              image:
                                  AssetImage(widget.assetImages[currentPage]),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      left: 10,
                      top: 100,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.4)),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentPage =
                                  (currentPage - 1) % widget.assetImages.length;
                            });
                          },
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
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.4)),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentPage = (currentPage + 1) %
                                    widget.assetImages.length;
                              });
                              stopSlideshow(); // Add this to stop the slideshow if manually navigating

                              // showDialogWithQuestionOptions(); // Add this line to show the custom dialog.
                            },
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          )),
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
                                          assetImages: widget.assetImages,
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
                onPressed: () {
                  navigationController.navigateToNextFeatureOrBack();
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
                return Image.asset(widget.assetImages[index],
                    fit: BoxFit.contain);
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
