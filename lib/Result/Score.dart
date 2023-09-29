import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Image_Hotspot/LessonOption26.dart';

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

  void showCustomDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // This is the critical line
        ),
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 10), // Add this line
        child: ConstrainedBox(
            // Add this widget
            constraints: BoxConstraints(
              maxHeight: 430,
              maxWidth: MediaQuery.of(Get.context!).size.width - 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: const Text(
                            "بہترین آپشن کا انتخاب کریں۔",
                            style:
                                TextStyle(fontFamily: "UrduType", fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Color(0xffFFF0F0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8, right: 8,top: 10,bottom: 10),
                            child: Text(
                                'بچے کی پیدائش کے بعد بھاری مادہ عام ہے. یہ دھیرے دھیرے کم ہو جائے گا، گلابی اور پھر سفید ہو جائے گا، بالکل آپ کے ماہواری کی طرح۔',
                            style: TextStyle(fontFamily: "UrduType",color: Color(0xffFB6262)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Color(0xffFFF0F0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8, right: 8,top: 10,bottom: 10),
                            child: Text(
                              "آپ کو مزید آرام کرنا چاہئے۔ یہ بچے کی پیدائش کے بعد آپ کی ضرورت سے زیادہ سرگرمی کی وجہ سے ہو سکتا ہے۔",
                            style: TextStyle(fontFamily: "UrduType",color: Color(0xffFB6262)),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Color(0xffF5FAF9),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8, right: 8,top: 10,bottom: 10),
                            child: Text(
                              "یہ انفیکشن کی نشاندہی کرسکتا ہے۔ میں مزید معائنے کے لیے آپ کو ہیلتھ سنٹر ریفر کروں گا۔",
                            style: TextStyle(fontFamily: "UrduType",color: Color(0xff9AC9C2)),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
                Spacer(),
                const Divider(
                  thickness: 1,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Background color
                        side: const BorderSide(
                          color: Colors.black, // Border color
                          width: 1,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30), // Circular radius
                        ),
                        minimumSize: const Size(150, 40),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ٹھیک ہے',
                        style: TextStyle(
                            fontFamily: "UrduType",
                            color: Colors.black,
                            fontSize: 15),
                      )),
                ),
               
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
      barrierDismissible: true, // allows dismissing by touching outside
    );
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
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  'assets/images/cloud.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
              const Center(
                child: Text(
                  "اپنے سکور گارڈ کو چیک کریں۔",
                  style: TextStyle(fontFamily: "UrduType", fontSize: 22),
                ),
              ),
              const Center(
                child: Text(
                  "حل کو ظاہر کرنے کے لیے نیچے ٹائلز پر کلک کریں۔",
                  style: TextStyle(
                      fontFamily: "UrduType",
                      fontSize: 16,
                      color: Color(0xff7A7D84)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomPaint(
                    painter: BorderPainter(
                        borderColor:
                            const Color(0xff9AC9C2)), // Change color as desired
                    child: GestureDetector(
                      onTap: () {
                        showCustomDialog();
                      },
                      child: Container(
                        width: 170,
                        height: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff9AC9C2).withOpacity(0.4)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Color(0xff9AC9C2),
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Lorem Ipsum Sit Dolor؟",
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.justify,
                              ),
                              const Text(
                                "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomPaint(
                    painter: BorderPainter(
                        borderColor:
                            const Color(0xff9AC9C2)), // Change color as desired
                    child: GestureDetector(
                      onTap: (){
                        showCustomDialog();
                      },
                      child: Container(
                        width: 170,
                        height: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff9AC9C2).withOpacity(0.4)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Color(0xff9AC9C2),
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Lorem Ipsum Sit Dolor؟",
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.justify,
                              ),
                              const Text(
                                "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomPaint(
                    painter: BorderPainter(
                        borderColor:
                            const Color(0xff9AC9C2)), // Change color as desired
                    child: GestureDetector(
                      onTap: (){
                        showCustomDialog();
                      },
                      child: Container(
                        width: 170,
                        height: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff9AC9C2).withOpacity(0.4)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Color(0xff9AC9C2),
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Lorem Ipsum Sit Dolor؟",
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.justify,
                              ),
                              const Text(
                                "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomPaint(
                    painter: BorderPainter(
                        borderColor:
                            const Color(0xff9AC9C2)), // Change color as desired
                    child: GestureDetector(
                      onTap: (){
                        showCustomDialog();
                      },
                      child: Container(
                        width: 170,
                        height: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff9AC9C2).withOpacity(0.4)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Color(0xff9AC9C2),
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Lorem Ipsum Sit Dolor؟",
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.justify,
                              ),
                              const Text(
                                "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomPaint(
                    painter: BorderPainter(
                        borderColor:
                            const Color(0xff9AC9C2)), // Change color as desired
                    child: GestureDetector(
                      onTap: (){
                        showCustomDialog();
                      },
                      child: Container(
                        width: 170,
                        height: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff9AC9C2).withOpacity(0.4)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Color(0xff9AC9C2),
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Lorem Ipsum Sit Dolor؟",
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.justify,
                              ),
                              const Text(
                                "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomPaint(
                    painter: BorderPainter(
                        borderColor:
                            const Color(0xffFB6262)), // Change color as desired
                    child: GestureDetector(
                      onTap: (){
                        showCustomDialog();
                      },
                      child: Container(
                        width: 170,
                        height: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFB6262).withOpacity(0.4)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: const Center(
                                    child: Icon(
                                      Icons.close,
                                      color: Color(0xffFB6262),
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Lorem Ipsum Sit Dolor؟",
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.justify,
                              ),
                              const Text(
                                "Lorem ipsum dolor sit amet consectetur. Facilisis amet leo ut eleifend odio sollicitudin leo",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final Color borderColor;

  BorderPainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    const double startOffset = 4.0;
    final double endOffset = size.width - 4.0;
    final double bottomOffset = size.height - 4.0;

    const double curveRadius = 5.0;

    final Path path = Path()
      ..moveTo(startOffset + curveRadius, bottomOffset)
      ..lineTo(endOffset - curveRadius, bottomOffset);

    // Draw the straight part
    final Paint paintForStraight = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    canvas.drawPath(path, paintForStraight);

    // Draw the curves with "gradient" effect
    for (double i = 0; i <= 1; i += 0.1) {
      final Paint paintForCurve = Paint()
        ..color = borderColor.withOpacity(i)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5.0 - (2.0 * i); // Varying the width

      final Path pathForCurveRight = Path()
        ..moveTo(endOffset - curveRadius, bottomOffset)
        ..quadraticBezierTo(endOffset, bottomOffset, endOffset,
            bottomOffset - (curveRadius * i));

      final Path pathForCurveLeft = Path()
        ..moveTo(startOffset, bottomOffset - (curveRadius * i))
        ..quadraticBezierTo(
            startOffset, bottomOffset, startOffset + curveRadius, bottomOffset);

      canvas.drawPath(pathForCurveRight, paintForCurve);
      canvas.drawPath(pathForCurveLeft, paintForCurve);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
