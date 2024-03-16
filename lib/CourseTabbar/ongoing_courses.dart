import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Presentation/Presentation.dart';
import 'courses_card.dart';
import 'total_courses.dart';
import 'package:provider/provider.dart';

import 'course_provider.dart';

class OnGoingCourses extends StatefulWidget {
  const OnGoingCourses({Key? key}) : super(key: key);

  @override
  State<OnGoingCourses> createState() => _OnGoingCoursesState();
}

class _OnGoingCoursesState extends State<OnGoingCourses> {
  List<String> messages = [
    "یہ جاری یونٹ ہیں۔ وہاں سے سیکھنے کا عمل جاری کریں جہاں آپ نے چھوڑا تھا۔",
  ];
  int messageIndex = 0; // Current message index
  Timer? messageTimer;
  Key animatedTextKey = UniqueKey();
  bool showGuideMessage = true;
  final GlobalKey _tabBarKey = GlobalKey();
  double _fabYPosition = 420.0;

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
    final provider = Provider.of<CoursesProvider>(context);
    final courses = provider.ongoingCourses; // Using the ongoingCourses getter
    final fabHeight = 65.0; // Standard height of a FAB
    final topSafeArea = MediaQuery.of(context).padding.top - 70;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom + 200;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: courses.isEmpty
          ? const Center(child: Text("No ongoing courses"))
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "جاری یونٹ",
                        style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            return CourseCard(course: course);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: _fabYPosition,
                  child: GestureDetector(
                    onVerticalDragUpdate: (dragUpdateDetails) {
                      setState(() {
                        _fabYPosition += dragUpdateDetails.delta.dy;
                        _fabYPosition = _fabYPosition.clamp(topSafeArea,
                            screenHeight - fabHeight - bottomSafeArea);
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
                              painter:
                                  MenuBoxBackground(), // Implement this class as per your custom UI needs
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 100, // Minimum width to start with
                                  maxWidth:
                                      250, // Maximum width before wrapping
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
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
