import 'package:flutter/material.dart';
import 'package:flutter_phone_number_field/flutter_phone_number_field.dart';
import 'package:get/get.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {

  bool _obscureText = true;
  bool _isChecked = false;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
                child: Text(
                  "پاس ورڈ ری سیٹ",
                  style: TextStyle(fontFamily: "UrduType", fontSize: 30),
                )),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Text(
                  "نیا پاس ورڈ درج کریں۔",
                  style: TextStyle(
                      fontFamily: "UrduType",
                      fontSize: 20,
                      color: Color(0xff878787)),
                ),
              ),
            ), SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: RichText(
                text: const TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xffEC5A53), // This makes the asterisk red
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'پاس ورڈ',
                      style: TextStyle(
                        fontFamily: "UrduType",
                        color: Colors.black, // Change the color as you want
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
                obscureText: _obscureText,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                        color: Colors.black,
                      ),
                      onPressed: _toggleVisibility,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xffCDD1E0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xffCDD1E0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xffCDD1E0),
                      ),
                    ))),
            const SizedBox(
              height: 20,
            ),   Container(
              alignment: Alignment.centerRight,
              child: RichText(
                text: const TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xffEC5A53), // This makes the asterisk red
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'پاس ورڈ کی تصدیق کریں',
                      style: TextStyle(
                        fontFamily: "UrduType",
                        color: Colors.black, // Change the color as you want
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
                obscureText: _obscureText,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                        color: Colors.black,
                      ),
                      onPressed: _toggleVisibility,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xffCDD1E0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xffCDD1E0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Color(0xffCDD1E0),
                      ),
                    ))),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: Get.width,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFE8BD1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(150, 37),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'لنک بھیجیں۔',
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}


