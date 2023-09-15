import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TrueFalse3 extends StatefulWidget {
  const TrueFalse3({super.key});

  @override
  State<TrueFalse3> createState() => _TrueFalse3State();
}

class _TrueFalse3State extends State<TrueFalse3> {
  bool isSelected = false;
  bool isAnswered = false;
  int _current = 0;
  int _totalSteps = 100;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;

  final List<Question> questions = [
    Question(
      question: "The capital of England is London",
      correctAnswer: 'True',
    ),
    Question(
      question: "The capital of Pakistan is Paris",
      correctAnswer: 'False',
    ),
    Question(
      // Adding a third question for demonstration
      question: "Flutter is a programming language",
      correctAnswer: 'False',
    ),
  ];

  List<Color> optionColors = [];
  @override
  void initState() {
    super.initState();
    optionColors = List.generate(questions.length * 2, (index) => Colors.white);
  }

// Update the 'updateQuestion' method
  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered) return;
    setState(() {
      this.selectedAnswer = selectedAnswer;
      isAnswered = true;
      isSelected = true;
      selectedOptionIndex =
          index % 2; // This will be either 0 (True) or 1 (False)

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
          padding: const EdgeInsets.all(20),
          child: ListView(
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
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
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
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/team.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "صحیح یا غلط",
                style: TextStyle(fontFamily: "UrduType", fontSize: 22),
              ),
              Text(
                "بچے کی پیدائش کے بعد بھاری مادہ عام ہے. یہ دھیرے دھیرے کم ہو جائے گا، گلابی اور پھر سفید ہو جائے گا، بالکل آپ کے ماہواری کی طرح۔",
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontFamily: "UrduType",
                    fontSize: 16,
                    color: Color(0xff7A7D84)),
              ),
              const SizedBox(height: 30),
              Text(
                "جواب کا انتخاب کریں۔",
                style: TextStyle(
                    fontFamily: "UrduType",
                    fontSize: 16,
                    letterSpacing: 0.2,
                    color: Color(0xff7A7D84)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'سچ ہے۔',
                      style: TextStyle(fontFamily: "UrduType", fontSize: 16),
                    ),
                    SizedBox(width: 28), // Adjust width accordingly
                    Text('جھوٹا۔',
                        style: TextStyle(fontFamily: "UrduType", fontSize: 16)),
                  ],
                ),
              ),
              Column(
                children: List<Widget>.generate(
                  questions.length,
                  (questionIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: QuizCard(
                        questionText: questions[questionIndex].question,
                        correctAnswer: questions[questionIndex].correctAnswer,
                        onTap: (selectedOption) {
                          updateQuestion(selectedOption, questionIndex);
                        },
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.black87.withOpacity(0.1),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'آپ کا اسکور: 10 پوائنٹس',
                      style: TextStyle(
                          fontFamily: "UrduType", color: Color(0xff8E79FB)),
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
            ],
          ),
        ),
      ),
    );
  }
}

// ... [rest of the imports]

class QuizCard extends StatefulWidget {
  final String questionText;
  final String correctAnswer;
  final Function(String) onTap;

  const QuizCard({
    required this.questionText,
    required this.correctAnswer,
    required this.onTap,
  });

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: determineCardColor(), // use the determined color here
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.questionText,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff7A7D84),
                  fontFamily: 'UrduType',
                ),
              ),
            ),
            optionCircle("True"),
            SizedBox(width: 30),
            optionCircle("False"),
          ],
        ),
      ),
    );
  }

  Widget optionCircle(String option) {
    return InkWell(
      onTap: () {
        // Check if an option has already been selected
        if (selectedOption != null) return;

        setState(() {
          selectedOption = option;
        });
        widget.onTap(option);
      },
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87.withOpacity(0.2)),
          shape: BoxShape.circle,
          color: determineColor(option),
        ),
      ),
    );
  }

  Color determineColor(String option) {
    if (selectedOption == option) {
      if (widget.correctAnswer == option) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
    return Colors.transparent;
  }

  // New method to determine the color of the card
  Color determineCardColor() {
    if (selectedOption == null) {
      return Colors.white; // Default color if no option is selected
    }
    if (selectedOption == widget.correctAnswer) {
      return Colors.green[100]!;
    } else {
      return Colors.red[100]!;
    }
  }
}

class Question {
  final String question;
  final String correctAnswer;

  Question({
    required this.question,
    required this.correctAnswer,
  });
}
