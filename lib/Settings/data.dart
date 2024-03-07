import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  bool firstState = false;
  bool secondState = false;
  double _sliderValue = 0.5; // Adjust initial slider value as needed

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          children: [
            _buildSectionTitle("انٹرنیٹ اور وای فای"),
            _buildSectionSubtitle(
                "فوری اور ای میل کی اطلاعات حاصل کرنے کا طریقہ چنیں۔"),
            const Divider(),
            _buildSectionTitle("انٹرنیٹ کی ترجیحات"),
            _buildSectionSubtitle(
                "موبائل کا انٹرنیٹ استعمال کرتے وقت تصویر اور ویڈیو کا میار کم کریں۔"),
            _buildSwitchTile(
              "وائی فائی پر ڈاؤن لوڈ",
              "یونٹ کا مواد صرف وائی فائی پر ڈاؤن لوڈ کریں۔",
              firstState,
              (bool newValue) {
                setState(() => firstState = newValue);
              },
            ),
            _buildSwitchTile(
              "موبائل ڈیٹا بچاؤ",
              "موبائل کا انٹرنیٹ استعمال کرتے وقت تصویر اور ویڈیو کا میار کم کریں۔",
              secondState,
              (bool newValue) {
                setState(() => secondState = newValue);
              },
            ),
            const Divider(),
            _buildSectionTitle("الفاظ کی باریکی"),
            _buildSectionSubtitle(
                "فوری اور ای میل کی اطلاعات حاصل کرنے کا طریقہ چنیں۔"),
            _buildSlider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontFamily: "UrduType", fontSize: 17),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildSectionSubtitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        subtitle,
        style: const TextStyle(
            fontFamily: "UrduType", fontSize: 13, color: Color(0xff8B9DA0)),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool stateValue,
      Function(bool) onChanged) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontFamily: "UrduType", fontSize: 17),
          textAlign: TextAlign.right,
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
              fontFamily: "UrduType", fontSize: 13, color: Color(0xff8B9DA0)),
          textAlign: TextAlign.right,
        ),
        trailing: Directionality(
          textDirection: TextDirection.ltr,
          child: CupertinoSwitch(
            activeColor: Color(0xff72C391),
            value: stateValue,
            onChanged: onChanged,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
        onTap: () => onChanged(!stateValue),
      ),
    );
  }

  Widget _buildSlider() {
    return Stack(
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
                  thumbShape:
                      BorderThumbShape(thumbRadius: 12.0, borderWidth: 4.0),
                ),
                child: Slider(
                  inactiveColor: const Color(0xffEAEAEF),
                  activeColor: const Color(0xffFE8BD1),
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
        const Positioned(
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
        const Positioned(
          left: 40,
          bottom: 55, // Adjust as needed
          child: Text(
            "اے",
            style: TextStyle(fontSize: 24, fontFamily: "UrduType"), // Large A
          ),
        ),
      ],
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
