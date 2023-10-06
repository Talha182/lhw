import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lhw/Profile/edit_profile.dart';
import 'package:lhw/controllers/profile_controller.dart';
import 'package:lhw/models/user_model.dart';

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
      body: FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;

              return Padding(
                padding: EdgeInsets.all(15),
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
                              child: Text(
                                "پروفائل تصویر تبدیل کریں۔",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "UrduType",
                                    color: Color(0xffFE8BD1)),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ClipOval(
                              child: Image.asset(
                                'assets/images/profile_pic.png', // replace with your asset image name
                                width: 80.0, // the width of the image widget
                                height: 80.0, // the height of the image widget
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 420,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
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
                                          duration:
                                              Duration(milliseconds: 300));
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/pencil_edit.svg",
                                          width: 17,
                                          height: 17,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "تفصیلات میں ترمیم کریں۔",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "UrduType",
                                              color: Color(0xffFE8BD1)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("عمومی تفصیلات",
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
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
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
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "UrduType",
                  color: Color(0xff7A7D84), // Grey color for headings
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                heading2,
                textAlign: TextAlign.end,
                style: TextStyle(
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
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "UrduType",
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                value2,
                textAlign: TextAlign.end,
                style: TextStyle(
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
