import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
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
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                        Text("عمومی تفصیلات",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "UrduType",
                            )),
                      ],
                    ),

                    createDetailGroup("پیدائش کی تاریخ", "نام", "1/07/2023", "کوڈی فشر"),
                    createDetailGroup("یو سی کا نام", "فون نمبر", "دہلی یونیورسٹی", "+91 7232632621"),
                    createDetailGroup("LHW شناختی نمبر", "سروس کے سال", "62328618264", "4"),
                    createDetailGroup("ای میل", "گاؤں", "CodyFisher@lhw.com", "دہلی"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget createDetailGroup(String heading1, String heading2, String value1, String value2) {
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