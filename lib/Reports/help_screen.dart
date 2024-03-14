import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Presentation/Presentation.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<String> messages = [
    "آپ کی پروفائل وہ جگہ ہے جہاں آپ کے ذاتی سفر کی عکاسی ہوتی ہے۔ ",
    "اپنی معلومات کو اپ ڈیٹ کریں اور اپنے سیکھنے کے تجربے کو اپنی ضروریات کے مطابق بنائیں۔",
  ];
  int messageIndex = 0; // Current message index
  Timer? messageTimer;
  Key animatedTextKey = UniqueKey();
  bool showGuideMessage = true;
  double _fabYPosition = 550.0;


  @override
  void initState() {
    super.initState();
    restartMessageCycle();
  }
  void restartMessageCycle() {
    setState(() {
      showGuideMessage = true; // Ensure the message area is visible
      messageIndex = 0; // Reset the index to start from the first message
      animatedTextKey = UniqueKey(); // Reset the key to restart the animation
    });
    messageTimer?.cancel(); // Cancel any existing timer
    messageTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        if (messageIndex < messages.length - 1) {
          setState(() {
            messageIndex++;
            animatedTextKey = UniqueKey(); // Update the key to force a rebuild
          });
        } else {
          timer.cancel();
          // Optionally hide messages after one full cycle:
          setState(() {
            showGuideMessage = false;
          });
        }
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    messageTimer?.cancel();

  }


  @override
  Widget build(BuildContext context) {
    final fabHeight = 65.0; // Standard height of a FAB
    final topSafeArea = MediaQuery.of(context).padding.top - 50;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom + 180;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.5,
          backgroundColor: Colors.white,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                  child: GestureDetector(
                    child: const Text(
                      "ہمیں لکھیں۔",
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 20,
                        color: Color(0xffFE8BD1),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5, right: 40),
                  child: Text(
                    "مدد",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    child: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffE3E3E3))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ئونٹ کا مواد",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 26,
                                color: Color(0xff72C391)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Color(0xffE0E0E0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          _buildExpandablePanel("یونٹ کا مواد کس پر مبنی ہے؟",
                              "یونٹ کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Color(0xffE0E0E0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          _buildExpandablePanel("یونٹ کا مواد کس پر مبنی ہے؟",
                              "یونٹ کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Color(0xffE0E0E0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          _buildExpandablePanel("یونٹ کا مواد کس پر مبنی ہے؟",
                              "یونٹ کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffE3E3E3))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "تکنیکی مسئلہ",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 26,
                                color: Color(0xff72C391)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Color(0xffE0E0E0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          _buildExpandablePanel(
                              "مجھے ایک ویڈیو میں پریشانی ہو رہی ہے۔ میں کیا کروں؟",
                              "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffE3E3E3))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "اکاؤنٹ سیٹنگز",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 26,
                                color: Color(0xff72C391)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Color(0xffE0E0E0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          _buildExpandablePanel(
                              "میں اپنی ذاتی معلومات میں تفصیلات کیسے تبدیل کر سکتی ہوں؟ ",
                              "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffE3E3E3))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ٹیسٹ",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 26,
                                color: Color(0xff72C391)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Color(0xffE0E0E0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          _buildExpandablePanel(
                              "اگر میں نے اچھا نہیں کیا تو کیا میں پوسٹ یونٹ کے آخری ٹیسٹ کو دوبارہ آزما سکتی ہوں؟",
                              "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xffE3E3E3))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "تمغے اور شناخت",
                            style: TextStyle(
                                fontFamily: "UrduType",
                                fontSize: 26,
                                color: Color(0xff72C391)),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Color(0xffE0E0E0),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          _buildExpandablePanel("ایپ میں تمغے کیسے دیئے جاتے ہیں؟",
                              "کورس کا مواد لیڈی ہیلتھ ورکرز کے لیے حکومت کی طرف سے مقرر کردہ نصاب پر مبنی ہے۔"),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: _fabYPosition,
            child: GestureDetector(
              onVerticalDragUpdate: (dragUpdateDetails) {
                setState(() {
                  _fabYPosition += dragUpdateDetails.delta.dy;
                  _fabYPosition = _fabYPosition.clamp(
                      topSafeArea, screenHeight - fabHeight - bottomSafeArea);
                });
              },
              onTap: restartMessageCycle,
              child: Container(
                margin: const EdgeInsets.only(bottom: 72.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (showGuideMessage)
                      CustomPaint(
                        painter: MenuBoxBackground(), // Implement this class as per your custom UI needs
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 100, // Minimum width to start with
                            maxWidth: 250, // Maximum width before wrapping
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                            child: AnimatedTextKit(
                              key: animatedTextKey,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  messages[messageIndex],
                                  textAlign: TextAlign.center,
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: "UrduType",
                                  ),
                                  speed: const Duration(milliseconds: 50),
                                ),
                              ],
                              totalRepeatCount: 1,
                              pause: const Duration(milliseconds: 5000),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      backgroundColor: const Color(0xffF6B3D0),
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: SvgPicture.asset(
                          "assets/images/samina_instructor.svg",
                          width: 60, // Fixed width for the SVG image
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

Widget _buildExpandablePanel(String title, String content) {
  return ExpandableNotifier(
    //initialize the controller
    controller: ExpandableController(initialExpanded: false),
    child: ExpandablePanel(
      header: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: "UrduType",
                  color: Color(0xff1C1D1F),
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Builder(
              builder: (context) {
                var controller = ExpandableController.of(context);
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: controller!.expanded
                        ? const Color(0xff0ffFE8BD1)
                        : const Color(0xffFE8BD1).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    controller.expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: controller.expanded
                        ? Colors.white
                        : const Color(0xffFE8BD1),
                    size: 25,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      collapsed: Container(), // Empty Container
      expanded: Center(
        child: Text(
          content,
          style: const TextStyle(
            fontFamily: "UrduType",
            fontSize: 20,
            color: Color(0xff414141),
          ),
        ),
      ),
      theme: const ExpandableThemeData(
        tapHeaderToExpand: true,
        tapBodyToCollapse: true,
        hasIcon: false,
      ),
    ),
  );
}
