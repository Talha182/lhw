import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LessonOption26 extends StatefulWidget {
  const LessonOption26({super.key});

  @override
  State<LessonOption26> createState() => _LessonOption26State();
}

class _LessonOption26State extends State<LessonOption26> {
  bool isSelected = false;
  bool isAnswered = false;

  int _current = 0;
  int _totalSteps = 100;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;

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
    // Question(
    //     question: 'What is the currency of Japan?',
    //     options: ['Yen', 'Dollar', 'Euro'],
    //     correctAnswer: 'Yen',
    //     correctExplanation:
    //         'The yen is the official currency of Japan and is used throughout the country.',
    //     incorrectExplanation:
    //         "The correct answer is Yen, which is the currency of the Japan"),
    // You can add more questions here, in the same format.
  ];

  List<Color> optionColors = [Colors.white, Colors.white, Colors.white];

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
          padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 5),
          child: Column(
            children: [
                 Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context); // This will navigate back when tapped
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
                      child: Container(
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: 0, end: ((_current + 1) / 5 * _totalSteps)),
                          duration: const Duration(milliseconds: 400),
                          builder:
                              (BuildContext context, double value, Widget? child) {
                            return StepProgressIndicator(
                              totalSteps: _totalSteps,
                              currentStep: value.ceil(),
                              size: 8,
                              padding: 0,
                              selectedColor: const Color(0xffFE8BD1),
                              unselectedColor: Colors.white,
                              roundedEdges: const Radius.circular(10),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
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
                  style: const TextStyle(fontFamily: "UrduType", fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 350,
                height: 420,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/LessonOption26.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                        top: 10, // Adjust as needed
                        left: 15, // Adjust as needed
                        child: GestureDetector(
                          onTap: () {
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Icon(Icons.close),
                                              )),
                                          const Text(
                                            'غذائیت کی صورتحال',
                                            style: TextStyle(
                                                fontFamily: "UrduType",
                                                fontSize: 20),
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
                          child: Container(
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/touch.svg',
                                width: 30,
                                fit: BoxFit.contain,
                              ),
                            ),
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.4),
                            ),
                            // child: Image.asset("assets/images/team.png"),
                          ),
                        )),
                    Positioned(
                        top: 35, // Adjust as needed
                        right: 40, // Adjust as needed
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity, // Set the width
                                      height: 220, // Set the height
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Icon(Icons.close),
                                                )),
                                            const Text(
                                              'غذائیت کی صورتحال',
                                              style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize: 20),
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
                            child: Image.asset("assets/images/lesson_26.png"))),
                    Positioned(
                        top: 180, // Adjust as needed
                        right: 150, // Adjust as needed
                        child: GestureDetector(
                            onTap: () {
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
                                      child: Stack(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                flex:
                                                    2, // This will occupy 2/3 of the row
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          10.0), // Adjust the padding as needed
                                                      child: Text(
                                                        'غذائیت کی صورتحال',
                                                        style: TextStyle(
                                                          fontFamily: "UrduType",
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Padding(
                                                          padding: EdgeInsets.all(
                                                              16.0), // Adjust the padding as needed
                                                          child: Text(
                                                            'Lorem ipsum dolor یہ ایک انٹرایکٹو بٹن ہے۔ آپ اسے ایڈیٹر کے اوپری ٹول بار میں اپنی مرضی کے مطابق بنا سکتے ہیں اور ٹول ٹپس یا ونڈوز میں اضافی مواد شامل کر سکتے ہیں۔ تصاویر، ویڈیوز، آڈیوز، ٹائم لائنز، پی ڈی ایف، انٹرایکٹو سوالات شامل کریں... جو بھی آپ کی ضرورت ہے!',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "UrduType",
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xff7A7D84),
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            maxLines: 5,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1.5
                                                    .toInt(), // This will occupy 1/3 of the row
                                                child: Image.asset(
                                                  'assets/images/LessonOption26.png',
                                                  height: double.infinity,
                                                  fit: BoxFit
                                                      .cover, // Stretch the image to cover the entire container
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            top:
                                                10, // Adjust the top position as needed
                                            right:
                                                10, // Adjust the right position as needed
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset("assets/images/lesson_26.png"))),
                    Positioned(
                        top: 310, // Adjust as needed
                        right: 70, // Adjust as needed
                        child: GestureDetector(
                            onTap: () {
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Icon(Icons.close),
                                                )),
                                            const Text(
                                              'غذائیت کی صورتحال',
                                              style: TextStyle(
                                                  fontFamily: "UrduType",
                                                  fontSize: 20),
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
                            child: Image.asset(
                              "assets/images/lesson_26.png",
                            ))),
                    Positioned(
                        bottom: 5, // Adjust as needed
                        right: 10, // Adjust as needed
                        child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              "assets/images/full_screen.svg",
                            ))),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Spacer(),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.black87.withOpacity(0.1),
              ),
              const SizedBox(
                height: 10,
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
              const SizedBox(
                height: 10,
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
    return GestureDetector(
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
          padding: const EdgeInsets.only(left: 20, right: 20),
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
