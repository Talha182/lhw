import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:photo_view/photo_view.dart';

class LessonOption26 extends StatefulWidget {
  const LessonOption26({super.key});

  @override
  State<LessonOption26> createState() => _LessonOption26State();
}

class _LessonOption26State extends State<LessonOption26> {
  bool isSelected = false;
  bool isAnswered = false;

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
            maxHeight: 250,
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
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true, // allows dismissing by touching outside
    );
  }

  void showCustomDialog2() {
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
            maxHeight: 250,
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
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true, // allows dismissing by touching outside
    );
  }

  void showCustomDialog3() {
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
            maxHeight: 250,
            maxWidth: MediaQuery.of(Get.context!).size.width - 50,
          ),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2, // This will occupy 2/3 of the row
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              10.0), // Adjust the padding as needed
                          child: Text(
                            'غذائیت کی صورتحال',
                            style: TextStyle(
                              fontFamily: "UrduType",
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  16.0), // Adjust the padding as needed
                              child: Text(
                                'Lorem ipsum dolor یہ ایک انٹرایکٹو بٹن ہے۔ آپ اسے ایڈیٹر کے اوپری ٹول بار میں اپنی مرضی کے مطابق بنا سکتے ہیں اور ٹول ٹپس یا ونڈوز میں اضافی مواد شامل کر سکتے ہیں۔ تصاویر، ویڈیوز، آڈیوز، ٹائم لائنز، پی ڈی ایف، انٹرایکٹو سوالات شامل کریں... جو بھی آپ کی ضرورت ہے!',
                                style: TextStyle(
                                  fontFamily: "UrduType",
                                  fontSize: 14,
                                  color: Color(0xff7A7D84),
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1.5.toInt(), // This will occupy 1/3 of the row
                    child: Image.asset(
                      'assets/images/LessonOption26.png',
                      height: double.infinity,
                      fit: BoxFit
                          .cover, // Stretch the image to cover the entire container
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10, // Adjust the top position as needed
                right: 10, // Adjust the right position as needed
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true, // allows dismissing by touching outside
    );
  }

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
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
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
                            tween: Tween<double>(
                                begin: 0, end: 2.2),
                            duration: const Duration(milliseconds: 400),
                            builder:
                                (BuildContext context, double value, Widget? child) {
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
                      )                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
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
                      "آپ ڈیلیوری کے بعد چوتھے دن ماں سے ملنے جاتے ہیں۔ وہ اچانک بھاری اندام نہانی خارج ہونے کی شکایت کرتی ہے۔"
                      ,textAlign: TextAlign.center,
                      style:
                          TextStyle(fontFamily: "UrduType", fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 350,
                    height: 420,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: PhotoView(
                                imageProvider: const AssetImage('assets/images/LessonOption26.png'),
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.covered * 2,
                                backgroundDecoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.transparent,
                                ),
                              ),
                          ),
                        ),
                        Positioned(
                            top: 10, // Adjust as needed
                            left: 15, // Adjust as needed
                            child: GestureDetector(
                              onTap: () {
                                showCustomDialog2();
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
                        Positioned(
                            top: 35, // Adjust as needed
                            right: 40, // Adjust as needed
                            child: GestureDetector(
                                onTap: () {
                                  showCustomDialog4();
                                },
                                child: Image.asset(
                                    "assets/images/lesson_26.png"))),
                        Positioned(
                            top: 180, // Adjust as needed
                            right: 150, // Adjust as needed
                            child: GestureDetector(
                                onTap: () {
                                  showCustomDialog3();
                                },
                                child: Image.asset(
                                    "assets/images/lesson_26.png"))),
                        Positioned(
                            top: 310, // Adjust as needed
                            right: 70, // Adjust as needed
                            child: GestureDetector(
                                onTap: () {
                                 showCustomDialog2();
                                },
                                child: Image.asset(
                                  "assets/images/lesson_26.png",
                                ))),
                        Positioned(
                            bottom: 5, // Adjust as needed
                            right: 10, // Adjust as needed
                            child: GestureDetector(
                                onTap: () {
                                },
                                child: SvgPicture.asset(
                                  "assets/images/full_screen.svg",
                                ))),
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
                    onPressed: () {},
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
              Positioned(top: 200,left:70,child: ArrowContainer())
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
          child: Text('انٹرایکٹو عنصر دکھائیں۔',style: TextStyle(
            color: Colors.white,
            fontFamily: "UrduType",
            fontSize: 13
          ),),
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
