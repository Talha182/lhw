import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Score extends StatefulWidget {
  const Score({super.key});

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  bool isSelected = false;
  bool isAnswered = false;
  int _current = 0;
  int _totalSteps = 100;
  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;

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
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
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
                                begin: 0,
                                end: ((_current + 1) / 5 * _totalSteps)),
                            duration: const Duration(milliseconds: 400),
                            builder: (BuildContext context, double value,
                                Widget? child) {
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/cloud.png',
                        width: 45,
                        height: 45,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "اپنے سکور گارڈ کو چیک کریں۔",
                      style: TextStyle(fontFamily: "UrduType", fontSize: 22),
                    ),
                    Text(
                      "حل کو ظاہر کرنے کے لیے نیچے ٹائلز پر کلک کریں۔",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 16,
                          color: Color(0xff7A7D84)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff9AC9C2).withOpacity(0.5)),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Color(0xff9AC9C2),
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Lorem Ipsum Sit Dolor؟",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff9AC9C2).withOpacity(0.5)),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Color(0xff9AC9C2),
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Lorem Ipsum Sit Dolor؟",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff9AC9C2).withOpacity(0.5)),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Color(0xff9AC9C2),
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Lorem Ipsum Sit Dolor؟",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff9AC9C2).withOpacity(0.5)),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Color(0xff9AC9C2),
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Lorem Ipsum Sit Dolor؟",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff9AC9C2).withOpacity(0.5)),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          color: Color(0xff9AC9C2),
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Lorem Ipsum Sit Dolor؟",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffFB6262).withOpacity(0.5)),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(
                                        child: Icon(
                                          Icons.close,
                                          color: Color(0xffFB6262),
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Lorem Ipsum Sit Dolor؟",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black87.withOpacity(0.1),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                        child: const Expanded(
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
                        child: const Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}
class BottomBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // adjust this for the thickness

    final path = Path();

    // Define starting, control and ending points
    final startPoint = Offset(0, size.height);
    final endPoint = Offset(size.width, size.height);
    final controlPoint = Offset(size.width / 2, size.height - 10); // adjust the -10 to control the depth of the curve

    path.moveTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
