import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SamajiScreen extends StatefulWidget {
  const SamajiScreen({super.key});

  @override
  State<SamajiScreen> createState() => _SamajiScreenState();
}

class _SamajiScreenState extends State<SamajiScreen> {
  bool firstState = false;
  bool secondState = false;
  bool thirdState = false;
  bool fourthState = false;
  bool fifthState = false;
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(
          children: [
            const Text(
              "کنیکٹیویٹی اور ڈیٹا",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const Text(
              "پش اور ای میل اطلاعات کو منتخب کریں جو آپ وصول کرنا چاہتے ہیں۔",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 13,
                  color: Color(0xff8B9DA0)),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "ڈیٹا کے استعمال کی ترجیح",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const Text(
              "اپنے موبائل اور ڈیسک ٹاپ اطلاعات کا نظم کریں۔  ",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 13,
                  color: Color(0xff8B9DA0)),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection:
              TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "وائی فائی صرف ڈاؤن لوڈز",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                      ),
                      Text(
                        "کورس کا مواد صرف وائی فائی سے منسلک ہونے پر ڈاؤن لوڈ ہوتا ہے۔",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 13,
                            color: Color(0xff8B9DA0)),
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: const Color(0xff72C391),
                    value: firstState,
                    onChanged: (value) {
                      setState(() {
                        firstState = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Directionality(
              textDirection:
              TextDirection.rtl, // Set the text direction to right-to-left
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "ڈیٹا سیور موڈ",
                        style: TextStyle(fontFamily: "UrduType", fontSize: 17),
                      ),
                      Text(
                        "موبائل نیٹ ورک استعمال کرتے وقت ڈیٹا کو بچانے کے لیے تصویر/ویڈیو کے معیار کو کم کریں۔",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 13,
                            color: Color(0xff8B9DA0)),
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    activeColor: const Color(0xff72C391),
                    value: secondState,
                    onChanged: (value) {
                      setState(() {
                        secondState = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "متن کا سائز اور انداز",
              style: TextStyle(fontFamily: "UrduType", fontSize: 17),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const Text(
              "پش اور ای میل اطلاعات کو منتخب کریں جو آپ وصول کرنا چاہتے ہیں۔",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 13,
                  color: Color(0xff8B9DA0)),
              textAlign: TextAlign.right, // Align text to the right
            ),
            const SizedBox(
              height: 35,
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(-1.08, 1.0, 1.0),
                    child: SizedBox(
                      width: 340,
                      height: 80,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight:
                          7.0, // Adjust this value to make it thicker or thinner
                          thumbShape: BorderThumbShape(thumbRadius: 12.0, borderWidth: 4.0),
                        ),
                        child: Slider(
                          inactiveColor: Color(0xffEAEAEF),
                          activeColor: Color(0xffFE8BD1),
                          value: 1.0 - _sliderValue, // Inverted value
                          onChanged: (newValue) {
                            setState(() {
                              _sliderValue =
                                  1.0 - newValue; // Update the original value
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 55, // Adjust as needed
                  child: Text(
                    "اے",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 15,
                        color: Color(0xff7A7D84)), // Small A
                  ),
                ),
                Positioned(
                  left: 40,
                  bottom: 55, // Adjust as needed
                  child: Text(
                    "اے",
                    style: TextStyle(
                        fontSize: 24, fontFamily: "UrduType"), // Large A
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
class BorderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double borderWidth;

  BorderThumbShape({this.thumbRadius = 6.0, this.borderWidth = 2.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool? isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        TextDirection? textDirection,
        double? value,
        double? textScaleFactor,
        Size? sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final Paint thumbPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawCircle(center, thumbRadius, thumbPaint);
    canvas.drawCircle(center, thumbRadius - borderWidth / 2, borderPaint);
  }
}
