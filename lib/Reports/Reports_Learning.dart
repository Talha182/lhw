import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter_svg/svg.dart';
import '../Presentation/Presentation.dart';
import 'Achievements.dart'; // Your import paths
import 'Sargarmi.dart'; // Your import paths
import 'Seekhna.dart'; // Your import paths

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _fabYPosition = 500.0;
  List<String> messages = [
    "اپنی ترقی کے عمل کا حساب لگائیں! ",
    "اس سے آپ کو معلوم ہوگا کہ  آپ نے کتنا کام کیا ہے اور آپ کے سیکھنے کے سفر میں آگے کیا ہے۔",
  ];
  int messageIndex = 0; // Current message index
  Timer? messageTimer;
  Key animatedTextKey = UniqueKey();
  bool showGuideMessage = true;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2); // Set initial index to 2
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
    _tabController.dispose();
    messageTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fabHeight = 65.0; // Standard height of a FAB
    final topSafeArea = MediaQuery.of(context).padding.top - 50;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom + 180;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        title: const Text("نتائج",
            style: TextStyle(color: Colors.black, fontFamily: "UrduType")),
        centerTitle: true,
        backgroundColor: Colors.white,
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.arrow_forward, color: Colors.black),
        //     onPressed: () {
        //       // Your navigation logic here
        //     },
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffDCEFDE),
                                    Color(0xff81C588),
                                  ]),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0, right: 2, left: 10),
                                        child: Text(
                                          "مہارت پوزیشن:سندھ / بلوچستان / خیبر پختون خوا /پنجابز",
                                          style: TextStyle(
                                            fontFamily: "UrduType",
                                            color: Color(0xff685F78),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(bottom: 8.0, right: 20),
                                      child: Text(
                                        "5",
                                        style: TextStyle(
                                          fontFamily: "UrduType",
                                          fontSize: 25,
                                          color: Color(0xff002058),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xffFCF4D9),
                                      Color(0xffFDCD4F),
                                    ])),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.only(top: 8.0, right: 10),
                                        child: Text(
                                          "یونٹ کا حساب",
                                          style: TextStyle(
                                            fontFamily: "UrduType",
                                            color: Color(0xff685F78),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(bottom: 8.0, right: 20),
                                      child: Text(
                                        "5",
                                        style: TextStyle(
                                          fontFamily: "UrduType",
                                          fontSize: 25,
                                          color: Color(0xff002058),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xffE6ECF9),
                                      Color(0xff839EE2),
                                    ])),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.only(top: 8.0, right: 10),
                                        child: Text(
                                          " پڑھائی کا عرصہ",
                                          style: TextStyle(
                                            fontFamily: "UrduType",
                                            color: Color(0xff685F78),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(bottom: 8.0, right: 20),
                                      child: Text(
                                        "60",
                                        style: TextStyle(
                                          fontFamily: "UrduType",
                                          fontSize: 25,
                                          color: Color(0xff002058),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                height: 75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color(0xffF4B9E1),
                                      Color(0xffED8DCE),
                                    ])),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding:
                                        EdgeInsets.only(top: 8.0, right: 10),
                                        child: Text(
                                          "آخری ٹیسٹ کے نتائج",
                                          style: TextStyle(
                                            fontFamily: "UrduType",
                                            color: Color(0xff685F78),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.only(bottom: 8.0, right: 20),
                                      child: Text(
                                        "90%",
                                        style: TextStyle(
                                          fontFamily: "UrduType",
                                          fontSize: 25,
                                          color: Color(0xff002058),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ButtonsTabBar(
                  controller: _tabController,
                  splashColor: Colors.transparent,
                  height: 50,
                  radius: 20,
                  elevation: 1,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                  backgroundColor: Colors.white,
                  unselectedBackgroundColor: const Color(0xffF0F0F0),
                  unselectedLabelStyle: const TextStyle(
                      fontFamily: 'UrduType',
                      color: Color(0xff685F78),
                      fontWeight: FontWeight.w600),
                  labelStyle: const TextStyle(
                      fontFamily: 'UrduType',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: "کامیابیاں اور انعامات"),
                    Tab(text: "سرگرمی کی تفصیلات"),
                    Tab(text: "سیکھنے کا تجزیہ"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      const Achievements(),
                      const Sargarmi(),
                      Seekhna(),
                    ],
                  ),
                ),
              ],
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