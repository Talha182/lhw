import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';

class LessonOption33 extends StatefulWidget {
  const LessonOption33({super.key});

  @override
  State<LessonOption33> createState() => _LessonOption33State();
}

class _LessonOption33State extends State<LessonOption33> {
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
                            minimumSize: const Size(150, 37),
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

  late VideoPlayerController _videoController;

  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset("assets/videos/demo.mp4");
    flickManager = FlickManager(videoPlayerController: _videoController);

    _videoController.addListener(_videoListener);
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
    if (position >= const Duration(seconds: 3) && !isDialogShown) {
      _videoController.pause(); // Pause the video here
      isDialogShown = true;
      showDialogWithQuestionOptions();
      _videoController.removeListener(_videoListener);
    }
  }

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
                  ),
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
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.close),
                                    )),
                                const Text(
                                  'غذائیت کی صورتحال',
                                  style: TextStyle(
                                      fontFamily: "UrduType", fontSize: 20),
                                ),
                                const Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      'Lorem ipsum dolor یہ ایک انٹرایکٹو بٹن ہے۔ آپ اسے ایڈیٹر کے اوپری ٹول بار میں اپنی مرضی کے مطابق بنا سکتے ہیں اور ٹول ٹپس یا ونڈوز میں اضافی مواد شامل کر سکتے ہیں۔ تصاویر، ویڈیوز، آڈیوز، ٹائم لائنز، پی ڈی ایف، انٹرایکٹو سوالات شامل کریں... جو بھی آپ کی ضرورت ہے!',
                                      style: TextStyle(
                                          fontFamily: "UrduType",
                                          fontSize: 14,
                                          color: Color(0xff7A7D84)),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                    ),
                                  ),
                                )
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

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String correctExplanation; // Correct explanation
  final String incorrectExplanation; // Incorrect explanation

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
  });
}
