import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LessonOption20 extends StatefulWidget {
  const LessonOption20({super.key});

  @override
  _LessonOption20State createState() => _LessonOption20State();
}

class _LessonOption20State extends State<LessonOption20> {
  int _current = 0;
  final int _totalSteps = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          0,
        ),
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
            const Color(0xff80B8FB).withOpacity(0.5),
            Colors.transparent,
          ],
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
              child: Row(
                children: [
                  const InkWell(
                    child: Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 310,
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
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/cloud.png',
                  width: 45,
                  height: 45,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "UrduType", fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Transform.translate(
              offset: const Offset(-35, 0),
              child: CarouselSlider(
                  items: const [
                    LessonOptionCard(
                      imagePath: 'assets/images/drugs.png',
                      text: 'ضمنی اثرات کی وضاحت',
                      borderColor: Color(0xffFE8BD1),
                    ),
                    LessonOptionCard(
                      imagePath: 'assets/images/drugs.png',
                      text: 'ضمنی اثرات کی وضاحت',
                      borderColor: Color(0xff9AC9C2),
                    ),
                    LessonOptionCard(
                      imagePath: 'assets/images/drugs.png',
                      text: 'ضمنی اثرات کی وضاحت',
                      borderColor: Color(0xffFE8BD1),
                    ),
                    LessonOptionCard(
                      imagePath: 'assets/images/drugs.png',
                      text: 'ضمنی اثرات کی وضاحت',
                      borderColor: Color(0xffFE8BD1),
                    ),
                    LessonOptionCard(
                      imagePath: 'assets/images/drugs.png',
                      text: 'ضمنی اثرات کی وضاحت',
                      borderColor: Color(0xffFE8BD1),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 400.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    aspectRatio: 16 / 9,
                    autoPlay: false,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction:
                        0.8, // Change this to make the adjacent pages visible
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? const Color(0xff9AC9C2)
                          : const Color(0xffeaedee),
                    ),
                  );
                },
              ),
            ),
          const Spacer(),
            Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(color: Colors.black87.withOpacity(0.1)),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.white, width: 2),
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
            )
          ],
        ),
      ),
    );
  }
}

class LessonOptionCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final Color borderColor;

  const LessonOptionCard({super.key,
    required this.imagePath,
    required this.text,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: CustomPaint(
        painter: BorderPainter(borderColor: borderColor),
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: 160,
                height: 160,
              ),
              Text(
                text,
                style: const TextStyle(
                    fontFamily: "UrduType",
                    fontSize: 30,
                    color: Color(0xff7A7D84)),
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
    final double startOffset = 4.0;
    final double endOffset = size.width - 4.0;
    final double bottomOffset = size.height - 4.0;

    final double curveRadius = 6.0;

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
