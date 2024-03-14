import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lhw/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/database_helper.dart';
import '../LoginSignUp/Login.dart';
import '../Presentation/Presentation.dart';
import '../models/user_model.dart';
import '../services/global_user.dart';
import '../services/user_service.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  File? _image; // To store the selected image
  double _fabYPosition = 550.0;
  List<String> messages = [
    "آپ کی پروفائل وہ جگہ ہے جہاں آپ کے ذاتی سفر کی عکاسی ہوتی ہے۔ ",
    "اپنی معلومات کو اپ ڈیٹ کریں اور اپنے سیکھنے کے تجربے کو اپنی ضروریات کے مطابق بنائیں۔",
  ];
  int messageIndex = 0; // Current message index
  Timer? messageTimer;
  Key animatedTextKey = UniqueKey();
  bool showGuideMessage = true;

  Future getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    restartMessageCycle();

    _loadUserData();
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


  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userEmail = prefs.getString('userEmail');
    if (userEmail != null) {
      final User? userFromDb =
          await DatabaseHelper.instance.getUserByEmail(userEmail);
      setState(() {
        user = userFromDb;
      });
    }
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 50, // Added this to make the space equally spread
                  ),
                  const Text(
                    "ذاتی معلومات ",
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 20,
                      color: Color(0xff232323),
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  GestureDetector(
                    child: const Icon(Icons.arrow_forward, color: Colors.black),
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
      body: user == null
          ? const LoadingScreen()
          : Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "تصویر تبدیل کریں",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "UrduType",
                                  color: Color(0xffFE8BD1),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ClipOval(
                                child: _image == null
                                    ? Image.asset(
                                        'assets/images/profile_pic.png',
                                        width: 80.0,
                                        height: 80.0,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        _image!,
                                        width: 80.0,
                                        height: 80.0,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 420,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => ProfileEdit());
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/pencil_edit.svg",
                                            width: 17,
                                            height: 17,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "تفصیلات میں ترمیم کریں۔",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "UrduType",
                                              color: Color(0xffFE8BD1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Text("عام تفصیلات",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "UrduType",
                                        )),
                                  ],
                                ),
                                createDetailGroup("یوم پیدائش", "نام",
                                    "${user!.dob}", "${user!.name}"),
                                createDetailGroup("ضلع کا نام", "فون نمبر",
                                    "دہلی یونیورسٹی", "${user!.phone}"),
                                createDetailGroup(
                                    "لیڈی ہیلتھووڑکر شناختی نمبر",
                                    "سروس کے سال",
                                    "${user!.nic}",
                                    "${user!.yearsExperience}"),
                                createDetailGroup("ای میل (لازم نہیں)", "گاؤں",
                                    "${user!.email}", "دہلی"),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await UserService.logout();
                                    GlobalUser
                                        .clearUser(); // Clears the global user instance
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: const Color(0xffFB6262),
                                        )),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color: Color(0xffFB6161),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("لاگ آوٹ",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "UrduType",
                                              color: Color(0xffFB6161),
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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

Widget createDetailGroup(
    String heading1, String heading2, String value1, String value2) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                heading1,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "UrduType",
                  color: Color(0xff7A7D84), // Grey color for headings
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                heading2,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "UrduType",
                  color: Color(0xff7A7D84), // Grey color for headings
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                value1,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "UrduType",
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                value2,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "UrduType",
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
