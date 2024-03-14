import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Presentation/Presentation.dart';
import 'MessageScreen.dart';

class GroupsDiscussion extends StatefulWidget {
  final bool showAppBar; // Add this line

  const GroupsDiscussion({super.key, required this.showAppBar});

  @override
  State<GroupsDiscussion> createState() => _GroupsDiscussionState();
}

class _GroupsDiscussionState extends State<GroupsDiscussion> {
  double _fabYPosition = 500.0;
  List<String> messages = [
    "مزے کی بات یہ ہے کہ ہر سبق کے لئے الگ بات چیت کا گروپ ہے جس کا آپ حصه ہیں۔",
    "اس گروپ میں ہم نے سبق کے متعلق بات کرنی ہے تاکہ ہم اپنے علم میں زیادہ سے زیادہ اضافہ کر سکیں۔ شروع کریں ؟",
  ];
  int messageIndex = 0; // Current message index
  Timer? messageTimer;
  Key animatedTextKey = UniqueKey();
  bool showGuideMessage = true;

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
      appBar: widget.showAppBar // Check the condition here
          ? PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: Colors.white,
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        children: [
                          GestureDetector(
                            child: SvgPicture.asset(
                              'assets/images/bell.svg',
                              color: Colors.black,
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            child: SvgPicture.asset(
                              'assets/images/magnifier.svg',
                              color: Colors.black,
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    Text(
                        "بات چیت",
                        style: TextStyle(
                          fontFamily: 'UrduType',
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )):null,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                children: [
                  const Text(
                    "بات چیت: ایک ساتھ بڑھیں اور سیکھیں۔",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withOpacity(0.1))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(colors: [
                                      Color(0xffED8DCE),
                                      Color(0xffED8DCE)
                                    ])),
                                child: ClipOval(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SvgPicture.asset(
                                      "assets/images/samina_group.svg",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "جنرل چیٹ",
                                style:
                                    TextStyle(fontFamily: "UrduType", fontSize: 18),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "",
                                style: TextStyle(
                                    fontFamily: "UrduType",
                                    fontSize: 18,
                                    color: Color(0xffFE8BD1)),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              SvgPicture.asset(
                                "assets/images/Icon.svg",
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "یونٹ کی باتیں",
                    style: TextStyle(
                      fontFamily: "UrduType",
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MessageScreen(showAppbar: true,),
                          transition: Transition.fadeIn,
                          duration: const Duration(milliseconds: 300));
                    },
                    child: Container(
                      width: Get.width,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black.withOpacity(0.1))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(colors: [
                                        Color(0xffED8DCE),
                                        Color(0xffED8DCE)
                                      ])),
                                  child: ClipOval(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Image.asset(
                                        "assets/images/1.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "باب 1 تعارف",
                                  style: TextStyle(
                                      fontFamily: "UrduType", fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    width: 35,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff72C391),
                                        borderRadius: BorderRadius.circular(13)),
                                    child: const Center(
                                      child: Text(
                                        "21",
                                        style: TextStyle(
                                            fontFamily: "UrduType",
                                            color: Colors.white),
                                      ),
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/Icon.svg",
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DiscussionGroupsChatCard(
                    gradient: const LinearGradient(
                        colors: [Color(0xffF48C14), Color(0xffFABC74)]),
                    image: Image.asset(
                      "assets/images/2.png",
                      fit: BoxFit.fill,
                    ),
                    titleText: "باب 2: کمیونٹی کے ساتھ کام کرنا",
                    endImage: "assets/images/Icon.svg",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DiscussionGroupsChatCard(
                    gradient: const LinearGradient(
                        colors: [Color(0xff937FFB), Color(0xffA896FC)]),
                    image: Image.asset(
                      "assets/images/community.png",
                      fit: BoxFit.fill,
                    ),
                    titleText: "باب 3: باہمی رابطے اور صحت کی تعلیم",
                    endImage: "assets/images/Icon.svg",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DiscussionGroupsChatCard(
                    gradient: const LinearGradient(
                        colors: [Color(0xff34B2D5), Color(0xff5DCBE9)]),
                    image: Image.asset(
                      "assets/images/3.png",
                      fit: BoxFit.fill,
                    ),
                    titleText: "باب 4: خاندانی منصوبہ بندی",
                    endImage: "assets/images/Icon.svg",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DiscussionGroupsChatCard(
                    gradient: const LinearGradient(
                        colors: [Color(0xffF66592), Color(0xffFB80A9)]),
                    image: Image.asset(
                      "assets/images/4.png",
                      fit: BoxFit.fill,
                    ),
                    titleText: "باب 5: قبل از پیدائش کی دیکھ بھال",
                    endImage: "assets/images/locked_group.svg",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DiscussionGroupsChatCard(
                    gradient: const LinearGradient(
                        colors: [Color(0xff6DB374), Color(0xffAFD6B3)]),
                    image: Image.asset(
                      "assets/images/5.png",
                      fit: BoxFit.fill,
                    ),
                    titleText: "باب 6: حمل کے دوران دیکھ بھال ",
                    endImage: "assets/images/locked_group.svg",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DiscussionGroupsChatCard(
                    gradient: const LinearGradient(
                        colors: [Color(0xffEDBB71), Color(0xffF4D5A8)]),
                    image: Image.asset(
                      "assets/images/two_women.png",
                      fit: BoxFit.fill,
                    ),
                    titleText: "باب 7: نوزائیدہ بچوں کی دیکھ بھال ",
                    endImage: "assets/images/locked_group.svg",
                  ),
                  const SizedBox(
                    height: 100,
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

class DiscussionGroupsChatCard extends StatelessWidget {
  final LinearGradient gradient;
  final Image image;
  final String titleText;
  final String endImage;

  const DiscussionGroupsChatCard({
    Key? key,
    required this.gradient,
    required this.image,
    required this.titleText,
    required this.endImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.1))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, gradient: gradient),
                  child: ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: image,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  titleText,
                  style: const TextStyle(fontFamily: "UrduType", fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  endImage,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
