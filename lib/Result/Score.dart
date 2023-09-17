import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                          borderColor: const Color(
                              0xff9AC9C2)), // Change color as desired
                      child: GestureDetector(
                        onTap: (){
                          _dialogBuilder(context);
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
                          borderColor: const Color(
                              0xff9AC9C2)), // Change color as desired
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
                          borderColor: const Color(
                              0xff9AC9C2)), // Change color as desired
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
                    const SizedBox(width: 10),
                    CustomPaint(
                      painter: BorderPainter(
                          borderColor: const Color(
                              0xff9AC9C2)), // Change color as desired
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
                          borderColor: const Color(
                              0xff9AC9C2)), // Change color as desired
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
                    const SizedBox(width: 10),
                    CustomPaint(
                      painter: BorderPainter(
                          borderColor: const Color(
                              0xffFB6262)), // Change color as desired
                      child: Container(
                        width: 170,
                        height: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffFB6262).withOpacity(0.4)),
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

//
// Divider(
// height: 1,
// thickness: 1,
// color: Colors.black87.withOpacity(0.1),
// ),
// const SizedBox(height: 10),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// side: BorderSide(
// color: const Color(0xffFE8BD1).withOpacity(0.5)
// ),
// backgroundColor: Colors.transparent,
// elevation: 0,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(30),
// ),
// minimumSize: const Size(160, 37),
// ),
// onPressed: () {},
// child: const Expanded(
// child: Text(
// 'اسکورز کا جائزہ لیں۔',
// style: TextStyle(
// fontFamily: 'UrduType',
// fontSize: 15,
// color: Color(0xffFE8BD1),
// ),
// ),
// ),
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: const Color(0xffFE8BD1),
// elevation: 0,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(30),
// ),
// minimumSize: const Size(150, 37),
// ),
// onPressed: () {},
// child: const Expanded(
// child: Text(
// 'جاری رہے',
// style: TextStyle(
// fontFamily: 'UrduType',
// fontSize: 15,
// color: Colors.white,
// ),
// ),
// ),
// ),
// ],
// ),
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
Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,  // Allows tapping outside to dismiss
    builder: (BuildContext context) {
      return Stack(
        children: <Widget>[
          // Darkened background
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Close the dialog when tapped outside
            },
            child: Container(
              color: Colors.black54,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Dialog content
          Center(
            child: Container(
              width: 300, // or any custom width
              height: 250, // or any custom height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Custom Dialog Title',
                      style: TextStyle( decoration: TextDecoration.none,fontSize: 15,color: Colors.black),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0,right: 16.0),
                      child: Text(
                        'A dialog is a type of modal window that\n'
                            'appears in front of app content to\n'
                            'provide critical information, or prompt\n'
                            'for a decision to be made.',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Disable'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Enable'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
