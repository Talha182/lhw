import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

import '../Quiz_Widgets/Question.dart';
import '../Quiz_Widgets/QuizCard.dart';

class Presentation extends StatefulWidget {
  const Presentation({super.key});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
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
                    child: SizedBox(
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
                  )
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
                  child: ImageCarousel(),
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
                                child: Center(
                                    child: SvgPicture.asset(
                                  "assets/images/full_screen.svg",
                                  color: Colors.black,
                                )),
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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          width: 350, // Set the width
                          height: 220, // Set the height
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.close),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
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

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int currentPage = 0;
  final List<String> assetImages = [
    'assets/images/presentation1.png',
    'assets/images/1.png',
  ];
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

  double get progress => (currentPage + 1) / assetImages.length;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.5),
          ),
          child: Image.asset(
            assetImages[currentPage],
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          left: 10,
          top: 100,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.black.withOpacity(0.4)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentPage = (currentPage + 1) % assetImages.length;
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
                  shape: BoxShape.circle, color: Colors.black.withOpacity(0.4)),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentPage = (currentPage + 1) % assetImages.length;
                  });
                  showDialogWithQuestionOptions(); // Add this line to show the custom dialog.
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
      ],
    );
  }
}
