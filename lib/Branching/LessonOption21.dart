import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LessonOption21 extends StatefulWidget {
  @override
  _LessonOption21State createState() => _LessonOption21State();
}

class _LessonOption21State extends State<LessonOption21> {
  bool isSelected = false;
  bool isAnswered = false;

  int _current = 0;
  int _totalSteps = 100;
  int questionIndex = 0;
  String selectedAnswer = '';
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

      if (selectedAnswer == questions[questionIndex].correctAnswer) {
        optionColors[index] = Colors.green[100]!;
        explanation = questions[questionIndex].correctExplanation;
      } else {
        optionColors[index] = Colors.red[100]!;
        explanation = questions[questionIndex].incorrectExplanation;
      }

      _showAnswerDialog(
          context,
          selectedAnswer == questions[questionIndex].correctAnswer,
          explanation);
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (questionIndex < questions.length - 1) {
        setState(() {
          questionIndex++;
          _current = ((questionIndex / questions.length) * 1).toInt();
          optionColors = [Colors.white, Colors.white, Colors.white];
          isAnswered = false;
          isSelectedList = [false, false, false]; // Reset for the next question
        });
      }
    });
  }

  void _showAnswerDialog(
      BuildContext context, bool isCorrect, String explanation) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isCorrect? const Color(0xff9AC9C2) : const Color(0xffFB6262), // Outer container's color
                ),
                padding: const EdgeInsets.only(
                    bottom: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white, // Inner container's color
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
                        Text(
                          isCorrect
                              ? "درست۔"
                              : "غلط۔ $explanation",  // Added a space after "غلط۔" and then added the explanation for wrong answers.
                          style: TextStyle(
                            fontFamily: "UrduType",
                            color: isCorrect
                                ? const Color(0xff47857C)
                                : const Color(0xffFB6262),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          explanation,
                          style:
                              const TextStyle(fontFamily: "UrduType", fontSize: 16),
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
    _totalSteps = questions.length; // Add this line

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
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
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 10),
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
                          SizedBox(
                            width: 320,
                            child: TweenAnimationBuilder(
                              tween: Tween<double>(
                                  begin: 0,
                                  end: ((_current + 1) / 5 * _totalSteps)),
                              duration: const Duration(milliseconds: 400),
                              builder: (BuildContext context, double value,
                                  Widget? child) {
                                return LinearPercentIndicator(
                                  lineHeight: 8.0,
                                  percent: value / _totalSteps,
                                  backgroundColor: Colors.white,
                                  progressColor: const Color(0xffFE8BD1),
                                  barRadius: const Radius.circular(10),
                                );
                              },
                            ),
                          )
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
                        questions[questionIndex].question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: "UrduType", fontSize: 20),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        questions[questionIndex].options.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: QuizCard(
                            text: questions[questionIndex].options[index],
                            imagePath: 'assets/images/quiz${index + 1}.png',
                            color: optionColors[index],
                            ontap: () => updateQuestion(
                                questions[questionIndex].options[index], index),
                            isCorrect: selectedAnswer ==
                                questions[questionIndex].correctAnswer,
                            isSelected:
                                isSelectedList[index], // use the list here
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     isAnswered // Check if the question is answered
                //         ? Container(
                //             height: 140,
                //             width: double.infinity,
                //             color: selectedAnswer ==
                //                     questions[questionIndex].correctAnswer
                //                 ? Colors.green[100] // Light green if correct
                //                 : Colors.red[100], // Light red if incorrect
                //             child: Padding(
                //               padding: const EdgeInsets.only(top: 0,left: 15,right: 15),
                //               child: RichText(
                //                 textAlign: TextAlign.center,
                //                 text: TextSpan(
                //                   style: const TextStyle(
                //                       fontFamily: "UrduType", fontSize: 18),
                //                   children: [
                //                     TextSpan(
                //                       text: selectedAnswer ==
                //                               questions[questionIndex]
                //                                   .correctAnswer
                //                           ? "درست۔ "
                //                           : "غلط۔ ",
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontFamily: "UrduType",
                //                         color: selectedAnswer ==
                //                                 questions[questionIndex]
                //                                     .correctAnswer
                //                             ? Colors
                //                                 .green // Green text if correct
                //                             : Colors
                //                                 .red, // Red text if incorrect
                //                       ),
                //                     ),
                //                     TextSpan(
                //                       text: selectedAnswer ==
                //                               questions[questionIndex]
                //                                   .correctAnswer
                //                           ? questions[questionIndex]
                //                               .correctExplanation
                //                           : questions[questionIndex]
                //                               .incorrectExplanation,
                //                       style: TextStyle(
                //                         fontSize: 16,
                //                         fontFamily: "UrduType",
                //                         color: selectedAnswer ==
                //                                 questions[questionIndex]
                //                                     .correctAnswer
                //                             ? Colors
                //                                 .black // Black text if correct
                //                             : Colors
                //                                 .red, // Red text if incorrect
                //                       ),
                //                     ),
                //                     if (selectedAnswer !=
                //                         questions[questionIndex].correctAnswer)
                //                       const TextSpan(
                //                         text: "\nدرست۔",
                //                         style: TextStyle(
                //                           fontFamily: "UrduType",
                //                           fontSize: 16,
                //                           color: Colors
                //                               .black, // Black text for the correct answer prefix
                //                         ),
                //                       ),
                //                     if (selectedAnswer !=
                //                         questions[questionIndex].correctAnswer)
                //                       TextSpan(
                //                         text: questions[questionIndex]
                //                             .correctExplanation, // Correct explanation
                //                         style: const TextStyle(
                //                           fontFamily: "UrduType",
                //                           fontSize: 16,
                //                           color: Colors
                //                               .black, // Black text for the correct explanation
                //                         ),
                //                       ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           )
                //         : Column(
                //             children: [
                //               Container(
                //                 width: double.infinity,
                //                 height: 1,
                //                 decoration: BoxDecoration(
                //                     color: Colors.black87.withOpacity(0.1)),
                //               ),
                //             ],
                //           ),
                //   ],
                // ),
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
                    onPressed: () {},
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
      child: Container(
        width: 360,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? (isCorrect ? const Color(0xff9AC9C2) : const Color(0xffFB6262))
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
