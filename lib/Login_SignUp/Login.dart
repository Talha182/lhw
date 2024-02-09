import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lhw/Bookmarks.dart';
import 'package:lhw/Login_SignUp/Forgot_Password.dart';
import 'package:lhw/Login_SignUp/SignUp.dart';
import 'package:lhw/navy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/signup_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _isChecked = false;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool areFieldsEmpty(TextEditingController emailController,
      TextEditingController passwordController) {
    return emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 36),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                "خوش آمدید",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "UrduType", fontSize: 24),
                textDirection: TextDirection.ltr,
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.clearLoginFields();
                Get.to(() => const SignUpScreen(),
                    transition: Transition.fade,
                    duration: const Duration(milliseconds: 300));
              },
              child: const Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "LHW",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 14,
                        color: Color(0xff878787)),
                  ),
                  TextSpan(
                    text: " میں نئے ہیں؟",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 14,
                        color: Color(0xff878787)),
                  ),
                  TextSpan(
                    text: "سائن اپ کریں",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 14,
                        color: Color(0xffFE8BD1)),
                  ),
                ]),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(right: 8, top: 36, bottom: 16),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "لیڈی ہیلتھ ورکر کا شناختی نمبر",
                  ),
                  TextSpan(text: "*", style: TextStyle(color: Colors.red))
                ]),
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontFamily: "UrduType",
                    fontSize: 14,
                    color: Color(0xff0F0D18)),
              ),
            ),

            TextField(
              controller: controller.email,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0), // Adjust vertical padding
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
                    color: Color(0xfff28bc9),
                    width: 2,
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 16, right: 8),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:    "پاس ورڈ",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 14,
                          color: Color(0xff0F0D18)),
                    ), TextSpan(
                      text: " *",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 14,
                          color: Color(0xffff0000)),
                    )
                  ],

                ),
                textDirection: TextDirection.rtl,
              ),
            ),

            TextField(
                controller: controller.password,
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
                        color: Color(0xfff28bc9),
                        width: 2,
                      ),
                    ))),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
              child: ElevatedButton(
                onPressed: () {
                  if (areFieldsEmpty(
                      controller.email, controller.password)) {
                    Fluttertoast.showToast(
                        msg: "Please fill all the fields!",
                        backgroundColor: Colors.red.withOpacity(0.1),
                        textColor: Colors.red);
                  } else {
                    SignUpController.instance.Login(
                        controller.email.text.trim(),
                        controller.password.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(
                  // shadowColor: Colors.red,
                  padding: const EdgeInsets.all(15.0),
                  backgroundColor: const Color(0xCDF36ABC), // Button color when not pressed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0), // Set your desired border radius
                  ),
                ),
                child: const Text(
                  'لاگ ان کریں',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: "UrduType",
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordScreen(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 200));
                    },
                    child: const Text(
                      "پاسورڈ بھول گئے ہیں؟",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 14,
                          color: Color(0xffFE8BD1)),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        " مجھے یاد رکھیں",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 14,
                            color: Color(0xff0F0D18)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomCheckbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                    ],
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

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const RoundedButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xffFE8BD1)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'UrduType',
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox(
      {super.key, required this.value, required this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: const Color(0xffaba8a8)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.value ? const Icon(Icons.check, size: 20.0) : null,
      ),
    );
  }
}
