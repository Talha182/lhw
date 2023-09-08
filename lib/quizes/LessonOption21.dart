import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
      question: 'What is the capital of England?',
      options: ['Moscow', 'London', 'California'],
      correctAnswer: 'London',
      correctExplanation: 'London is the capital city of England and the United Kingdom.',
      incorrectExplanation: 'The correct answer is London, which is the capital city of England and the United Kingdom.',
    ),
    Question(
        question: 'What is the currency of Japan?',
        options: ['Yen', 'Dollar', 'Euro'],
        correctAnswer: 'Yen',
        correctExplanation: 'The yen is the official currency of Japan and is used throughout the country.',
        incorrectExplanation: "The correct answer is Yen, which is the currency of the Japan"
    ),
    // You can add more questions here, in the same format.
  ];

  List<Color> optionColors = [Colors.white, Colors.white, Colors.white];

// Update the 'updateQuestion' method
  void updateQuestion(String selectedAnswer, int index) {
    if (isAnswered) return; // Skip the method if the question is already answered
    setState(() {
      this.selectedAnswer = selectedAnswer;  // Add this line
      isAnswered = true; // Set to true when an option is selected
      isSelected = true;
      if (selectedAnswer == questions[questionIndex].correctAnswer) {
        optionColors[index] = Colors.green[100]!;
      } else {
        optionColors[index] = Colors.red[100]!;
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      if (questionIndex < questions.length - 1) {
        setState(() {
          questionIndex++;
          optionColors = [Colors.white, Colors.white, Colors.white];
          isAnswered = false; // Reset for the next question
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0, -0.2),
            colors: [
              Color(0xff80B8FB).withOpacity(0.3),
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
                  padding: EdgeInsets.only(top: 30, left: 20, right: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.close,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 340,
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: 0,
                              end: ((_current + 1) / 5 * _totalSteps)),
                          duration: Duration(milliseconds: 400),
                          builder: (BuildContext context, double value,
                              Widget? child) {
                            return StepProgressIndicator(
                              totalSteps: _totalSteps,
                              currentStep: value.ceil(),
                              size: 8,
                              padding: 0,
                              selectedColor: Color(0xffFE8BD1),
                              unselectedColor: Colors.white,
                              roundedEdges: Radius.circular(10),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/icons/cloud.png',
                      width: 45,
                      height: 45,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    questions[questionIndex].question,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "UrduType", fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: List.generate(
                    questions[questionIndex].options.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: QuizCard(
                        text: questions[questionIndex].options[index],
                        imagePath: 'assets/icons/quiz${index + 1}.png',
                        color: optionColors[index],
                        ontap: () => updateQuestion(
                            questions[questionIndex].options[index], index),
                        isCorrect: selectedAnswer ==
                            questions[questionIndex].correctAnswer,
                        isSelected: isSelected,
                      ),
                    ),
                  ),
                ),
              ],
            ),
              Column(
                children: [
                  isAnswered // Check if the question is answered
                      ? Container(
                    padding: EdgeInsets.all(20),
                    color: selectedAnswer == questions[questionIndex].correctAnswer
                        ? Colors.green[100] // Light green if correct
                        : Colors.red[100],  // Light red if incorrect
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 16),
                        children: [
                        TextSpan(
                          text: selectedAnswer == questions[questionIndex].correctAnswer
                              ? "Correct. "
                              : "Incorrect. ",
                          style: TextStyle(
                            color: selectedAnswer == questions[questionIndex].correctAnswer
                                ? Colors.green // Green text if correct
                                : Colors.red,  // Red text if incorrect
                          ),
                        ),
                        TextSpan(
                          text: selectedAnswer == questions[questionIndex].correctAnswer
                              ? questions[questionIndex].correctExplanation
                              : questions[questionIndex].incorrectExplanation,
                          style: TextStyle(
                            color: selectedAnswer == questions[questionIndex].correctAnswer
                                ? Colors.black // Black text if correct
                                : Colors.red,  // Red text if incorrect
                          ),
                        ),
                        if (selectedAnswer != questions[questionIndex].correctAnswer)
                          TextSpan(
                            text: "\nCorrect: ",
                            style: TextStyle(
                              color: Colors.black, // Black text for the correct answer prefix
                            ),
                          ),
                        if (selectedAnswer != questions[questionIndex].correctAnswer)
                          TextSpan(
                            text: questions[questionIndex].correctExplanation, // Correct explanation
                            style: TextStyle(
                              color: Colors.black, // Black text for the correct explanation
                            ),
                          ),
                      ],
                    ),
                  ),
                )
                    : Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(color: Colors.black87.withOpacity(0.1)),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Colors.white, width: 2),
                      backgroundColor: Color(0xffFE8BD1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(150, 37),
                    ),
                    onPressed: () {},
                    child: Text(
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
          ],
        ),
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
  final bool isSelected; // Add this
  final bool isAnswered; // Add this

  const QuizCard({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.ontap,
    this.color = Colors.white,
    this.isCorrect = false,
    this.isSelected = false,
    this.isAnswered = false, // Add this
// Add this
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isAnswered
          ? null
          : () => ontap(), // Disable onTap if the question is answered

      child: Container(
        width: 380,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87.withOpacity(0.1)
          ),
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  textAlign: TextAlign.justify,
                  text,
                  style: TextStyle(
                    fontSize: 18,
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
  final String correctExplanation;  // Correct explanation
  final String incorrectExplanation;  // Incorrect explanation

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
  });
}
