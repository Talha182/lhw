import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lhw/Mobile_Lesson%20&%20Flashcards/flash_cards_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:photo_view/photo_view.dart';

import '../controllers/BookmarkController.dart';
import '../controllers/feature_navigation.dart';

class ImageHotspot extends StatefulWidget {
  const ImageHotspot({super.key});

  @override
  State<ImageHotspot> createState() => _ImageHotspotState();
}

class _ImageHotspotState extends State<ImageHotspot> {
  bool isSelected = false;
  bool isAnswered = false;

  int questionIndex = 0;
  String selectedAnswer = '';
  int? selectedOptionIndex;
  final BookmarkController bookmarkController = Get.put(BookmarkController());
  // final navigationController = Get.find<FeatureNavigationController>();

  final List<ClickableArea> clickableAreas = [
    ClickableArea(
      position: const Offset(200, 40), // Adjust positions as needed
      dialogText: 'یہ پہلا کلک ایبل علاقہ ہے۔',
      dialogImage: 'assets/images/lesson_26.png',
    ),
    ClickableArea(
      position: const Offset(150, 180),
      dialogText: 'یہ دوسرا کلک ایبل علاقہ ہے۔',
      dialogImage: 'assets/images/fatigue.png',
    ),
    ClickableArea(
      position: const Offset(220, 310),
      dialogText: 'یہ تیسرا کلک ایبل علاقہ ہے۔',
      dialogImage: 'assets/images/touch.png',
    ),
  ];


  void showCustomDialog4() {
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
            maxHeight: 270,
            maxWidth: MediaQuery.of(Get.context!).size.width - 50,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    )),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xffFE8BD1),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/fatigue.png",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                const Text(
                  'غذائیت کی صورتحال',
                  style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      'Lorem ipsum dolor یہ ایک انٹرایکٹو بٹن ہے۔ آپ اسے ایڈیٹر کے اوپری ٹول بار میں اپنی مرضی کے مطابق بنا سکتے ہیں اور ٹول ٹپس یا ونڈوز میں اضافی مواد شامل کر سکتے ہیں۔ تصاویر، ویڈیوز، آڈیوز، ٹائم لائنز، پی ڈی ایف، انٹرایکٹو سوالات شامل کریں... جو بھی آپ کی ضرورت ہے!',
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 14,
                          color: Color(0xff7A7D84)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true, // allows dismissing by touching outside
    );
  }

  void showCustomDialog0(
      BuildContext context, String dialogText, String dialogImage) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 250,
              maxWidth: MediaQuery.of(context).size.width - 50,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close),
                        ),
                      );
                    },
                  ),
                  const Text(
                    'غذائیت کی صورتحال',
                    style:
                        TextStyle(fontFamily: "UrduType", fontSize: 20),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            dialogText,
                            style: const TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 14,
                                color: Color(0xff7A7D84)),
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            dialogImage,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          child: Stack(
            children: [
              Column(
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
                          onTap: () {
                            final bookmarkController =
                                Get.find<BookmarkController>();
                            bookmarkController.addBookmark(
                              Bookmark(
                                  title: 'LessonOption20',
                                  routeName: '/lessonOption20'),
                            );
                            // Optionally, show a snackbar or some feedback to the user
                            Get.snackbar('Bookmark Added',
                                'This page has been added to your bookmarks');
                          },
                          child: const Icon(Icons.bookmark_outline)),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 10, top: 10, bottom: 10),
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
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "UrduType", fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 360,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(image: AssetImage(
                        'assets/images/LessonOption26.png',),fit: BoxFit.cover)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 10, // Adjust as needed
                            left: 15, // Adjust as needed
                            child: GestureDetector(
                              onTap: () {
                                showCustomDialog4();
                              },
                              child: Container(
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/touch.svg',
                                    width: 30,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                // child: Image.asset("assets/images/team.png"),
                              ),
                            )),
                        ...clickableAreas
                            .map((area) => Positioned(
                                  top: area.position.dy,
                                  left: area.position.dx,
                                  child: GestureDetector(
                                    onTap: () => showCustomDialog0(context,
                                        area.dialogText, area.dialogImage),
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/lesson_26.png',
                                          width: 30,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Spacer(),
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Positioned(
                  bottom: 90, // Adjust as needed
                  right: 15, // Adjust as needed
                  child: CircleAvatar(
                    backgroundColor: const Color(0xffF6B3D0),
                    radius: 30,
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: SvgPicture.asset(
                          "assets/images/samina_instructor.svg",
                          fit: BoxFit.fill,
                        )),
                  )),
              Positioned(top: 200, left: 70, child: ArrowContainer())
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

class ClickableArea {
  final Offset position;
  final String dialogText;
  final String dialogImage;
  final String touchIcon;

  ClickableArea({
    required this.position,
    required this.dialogText,
    required this.dialogImage,
    this.touchIcon = 'assets/images/lesson_26.png',
  });
}
