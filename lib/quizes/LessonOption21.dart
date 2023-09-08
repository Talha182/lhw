import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lhw/custom_widgets/Row_Column_Padding.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LessonOption21 extends StatefulWidget {
  @override
  _LessonOption21State createState() => _LessonOption21State();
}

class _LessonOption21State extends State<LessonOption21> {
  int _current = 0;
  int _totalSteps = 100;
  int questionIndex = 0; // New line
  String selectedAnswer = ''; // Existing line

  final List<String> questions = [
    'What is the capital of England?',
    'What is the currency of Japan?',
    'What is the national animal of Australia?'
  ];

  final List<List<String>> options = [
    ['Moscow', 'London', 'California'],
    ['Yen', 'Dollar', 'Euro'],
    ['Kangaroo', 'Elephant', 'Eagle']
  ];

  void updateQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      // Logic to end the quiz or reset it
    }
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
                    'What is the capital of England',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "UrduType", fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ...columnPadded([
                      QuizCard(
                        text: options[questionIndex][0],
                        imagePath: 'assets/icons/quiz1.png',
                        ontap: () {
                          if (options[questionIndex][0] == 'London') { // Replace with the correct answer logic
                            updateQuestion();
                          }
                        },
                      ),
                      QuizCard(
                        text: options[questionIndex][1],
                        imagePath: 'assets/icons/quiz2.png',
                        ontap: () {
                          if (options[questionIndex][1] == 'London') { // Replace with the correct answer logic
                            updateQuestion();
                          }
                        },
                      ),
                      QuizCard(
                        text: options[questionIndex][2],
                        imagePath: 'assets/icons/quiz3.png',
                        ontap: () {
                          if (options[questionIndex][2] == 'London') { // Replace with the correct answer logic
                            updateQuestion();
                          }
                        },
                      ),
                    ], 10),
                  ],
                ),              ],
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration:
                      BoxDecoration(color: Colors.black87.withOpacity(0.1)),
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
                )
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
  const QuizCard(
      {Key? key,
      required this.text,
      required this.imagePath,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap;
      },
      child: CustomPaint(
        painter: ThickBottomBorderPainter(),
        child: Container(
          width: 380,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
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
      ),
    );
  }
}

class ThickBottomBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // For the thick bottom border
    final bottomBorderPaint = Paint()
      ..color = Colors.black87.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final bottomPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height);

    canvas.drawPath(bottomPath, bottomBorderPaint);

    // For the simple grey borders on the other sides
    final sideBorderPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3;

    final sidePath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..moveTo(0, 0)
      ..lineTo(0, size.height);

    canvas.drawPath(sidePath, sideBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
