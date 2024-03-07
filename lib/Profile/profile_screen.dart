import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lhw/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/database_helper.dart';
import '../LoginSignUp/Login.dart';
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
    _loadUserData();
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
      final User? userFromDb = await DatabaseHelper.instance.getUserByEmail(userEmail);
      setState(() {
        user = userFromDb;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      // Add your navigation logic here
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
          : Padding(
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
                            createDetailGroup("لیڈی ہیلتھووڑکر شناختی نمبر", "سروس کے سال",
                                "${user!.nic}", "${user!.yearsExperience}"),
                            createDetailGroup(
                                "ای میل (لازم نہیں)", "گاؤں", "${user!.email}", "دہلی"),
                            const SizedBox(height: 15,),
                            GestureDetector(
                              onTap: () async{
                                await UserService.logout();
                                GlobalUser.clearUser(); // Clears the global user instance
                                Get.offAll(() => const LoginScreen());
                              },
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: const Color(0xffFB6262),
                                  )
                                ),
                                child:  const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.logout,color: Color(0xffFB6161) ,),
                                    SizedBox(width: 5,),
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