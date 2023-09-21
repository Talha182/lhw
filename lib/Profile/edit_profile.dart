import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({Key? key}) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.end,
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
            RichText(
              text: TextSpan(
                text: '*',
                style: TextStyle(
                  color: Color(0xffEC5A53),  // This makes the asterisk red
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'پہلا نام',
                    style: TextStyle(
                      fontFamily: "UrduType",
                      color: Colors.black,  // Change the color as you want
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
