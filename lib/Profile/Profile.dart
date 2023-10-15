import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lhw/Profile/edit_profile.dart';
import 'package:lhw/controllers/profile_controller.dart';
import 'package:lhw/models/user_model.dart';

import '../Login_SignUp/Login.dart';
import '../repositories/authentication_repository/authentication_repository.dart';

class ProfileScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String dob;
  final String phone;
  final String nic;
  final String serviceYears;

  ProfileScreen(
      {this.fullName = "Default",
      this.email = "default@email.com",
      this.dob = "",
      this.phone = "",
      this.nic = "",
      this.serviceYears = ""});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;  // To store the selected image

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future captureImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image captured.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
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
                    "پروفائل",
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
      body: Column(
        children: [
          FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ProfileEdit());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: const Text(
                                    "پروفائل تصویر تبدیل کریں۔",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "UrduType",
                                        color: Color(0xffFE8BD1)),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProfileEdit(),
                                              transition: Transition.fade,
                                              duration: const Duration(
                                                  milliseconds: 300));
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
                                                  color: Color(0xffFE8BD1)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text("عمومی تفصیلات",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "UrduType",
                                          )),
                                    ],
                                  ),
                                  createDetailGroup("پیدائش کی تاریخ", "نام",
                                      "${userData.dob}", "${userData.name}"),
                                  createDetailGroup("یو سی کا نام", "فون نمبر",
                                      "دہلی یونیورسٹی", "${userData.phoneNo}"),
                                  createDetailGroup(
                                      "LHW شناختی نمبر",
                                      "سروس کے سال",
                                      "${userData.nic}",
                                      "${widget.serviceYears}"),
                                  createDetailGroup("ای میل", "گاؤں",
                                      "${userData.email}", "دہلی"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: InkWell(
              onTap: () async {
                await AuthenticationRepository.instance.Logout();
                // Redirect to the login page after logging out.
                Get.offAll(() => const LoginScreen(),duration: Duration(milliseconds: 200),transition: Transition.fade);
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xffFB6262),width: 1.2),),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,  // Ensures the Row takes only as much space as needed.

                    children: [
                      SvgPicture.asset("assets/images/signout.svg"),
                      const SizedBox(width: 10,),
                      const Text("لاگ آوٹ",style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 17,
                        color: Color(0xffFB6262)
                      ),)
                    ],
                  ),
              ),
            ),
          )
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
