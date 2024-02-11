import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controllers/BookmarkController.dart';
import '../models/image_hotspot_model.dart';

class ImageHotspot extends StatefulWidget {
  final ImageHotspotModel imageHotspotModel;

  const ImageHotspot({
    Key? key,
    required this.imageHotspotModel,
  }) : super(key: key);

  @override
  State<ImageHotspot> createState() => _ImageHotspotState();
}

class _ImageHotspotState extends State<ImageHotspot> {
  void _showDialog(BuildContext context, String dialogText) {
    showAnimatedDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dialog'),
          content: Text(dialogText),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding:
              const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 5),
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
                    child: SizedBox(
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 2.2),
                        duration: const Duration(milliseconds: 400),
                        builder: (BuildContext context, double value,
                            Widget? child) {
                          return LinearPercentIndicator(
                            lineHeight: 8.0,
                            percent: 1,
                            backgroundColor: Colors.white,
                            progressColor: const Color(0xffFE8BD1),
                            barRadius: const Radius.circular(10),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {}, child: const Icon(Icons.bookmark_outline)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
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
              Text(
                "آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "UrduType", fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.imageHotspotModel.imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/touch.svg',
                              width: 30,
                              fit: BoxFit.contain,
                            ),
                          ),
                          // child: Image.asset("assets/images/team.png"),
                        ),
                      ),
                      ...widget.imageHotspotModel.hotspots.map((hotspot) {
                        return Positioned(
                          left: hotspot.offset.dx,
                          top: hotspot.offset.dy,
                          child: GestureDetector(
                            onTap: () =>
                                _showDialog(context, hotspot.dialogText),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/lesson_26.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
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
                onPressed: () {
                  // navigationController.navigateToNextFeatureOrBack();
                  Get.back();
                },
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
      ),
    );
  }
}



class ArrowContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 35,
      child: CustomPaint(
        painter: ArrowPainter(),
        child: const Center(
          child: Text(
            'انٹرایکٹو عنصر دکھائیں۔',
            style: TextStyle(
                color: Colors.white, fontFamily: "UrduType", fontSize: 13),
          ),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    const double arrowWidth = 15.0; // width of the arrow (beak)
    const double arrowHeight = 15.0; // height of the arrow (beak)
    const double cornerRadius = 10.0; // radius for rounded corners

    final path = Path()
      ..moveTo(arrowWidth + cornerRadius, 0)
      ..lineTo(size.width - cornerRadius, 0)
      ..arcToPoint(Offset(size.width, cornerRadius),
          radius: const Radius.circular(cornerRadius), clockwise: true)
      ..lineTo(size.width, size.height - cornerRadius)
      ..arcToPoint(Offset(size.width - cornerRadius, size.height),
          radius: const Radius.circular(cornerRadius), clockwise: true)
      ..lineTo(arrowWidth + cornerRadius, size.height)
      ..arcToPoint(Offset(arrowWidth, size.height - cornerRadius),
          radius: const Radius.circular(cornerRadius), clockwise: true)
      ..lineTo(arrowWidth, size.height / 2 + arrowHeight / 2)
      ..lineTo(0, size.height / 2)
      ..lineTo(arrowWidth, size.height / 2 - arrowHeight / 2)
      ..lineTo(arrowWidth, cornerRadius)
      ..arcToPoint(const Offset(arrowWidth + cornerRadius, 0),
          radius: const Radius.circular(cornerRadius), clockwise: true)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
