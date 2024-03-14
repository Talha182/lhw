import 'dart:async';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Settings/Samaji.dart';
import 'package:lhw/Settings/data.dart';

import '../Presentation/Presentation.dart';
import 'Itla\'aat.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> messages = [
    "آپ کی پروفائل وہ جگہ ہے جہاں آپ کے ذاتی سفر کی عکاسی ہوتی ہے۔ ",
    "اپنی معلومات کو اپ ڈیٹ کریں اور اپنے سیکھنے کے تجربے کو اپنی ضروریات کے مطابق بنائیں۔",
  ];
  int messageIndex = 0; // Current message index
  Timer? messageTimer;
  Key animatedTextKey = UniqueKey();
  bool showGuideMessage = true;
  final GlobalKey _tabBarKey = GlobalKey();
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

    return DefaultTabController(
      length: 3,
      initialIndex: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.5,
            backgroundColor: Colors.white,
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 50, // Added this to make the space equally spread
                    ),
                    const Text(
                      "سیٹنگز",
                      style: TextStyle(
                        fontFamily: 'UrduType',
                        fontSize: 20,
                        color: Color(0xff232323),
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    GestureDetector(
                      child: const Icon(
                          Icons.arrow_forward, color: Colors.black),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            _tabBar(),
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
      ),
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              ButtonsTabBar(
                key: _tabBarKey,
                splashColor: Colors.transparent,
                height: 50,
                radius: 20,
                elevation: 1,
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
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
                tabs: [
                  Tab(text: "سوشل میڈیا"),
                  Tab(text: "انٹرنیٹ اور وای فای"),
                  Tab(text: "اطلاعات "),
                ],
              ),

            ],
          ),
          const Expanded(
            child: TabBarView(
              children: <Widget>[

                SocialMediaScreen(),
                DataScreen(),
                ItlaatScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}