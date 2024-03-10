import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lhw/navy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/database_helper.dart';
import '../models/user_model.dart';
import '../services/global_user.dart';
import '../services/user_service.dart';
import 'Forgot_Password.dart';
import 'SignUp.dart';

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

  Future<void> login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    final User? user = await DatabaseHelper.instance.loginUser(email, password);

    if (user != null) {
      await UserService.saveUser(
          user); // Saves user to SharedPreferences and marks as logged in
      GlobalUser.updateUser(user); // Updates the global user instance
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await prefs.setString('userEmail', email);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Custom_NavBar()));
    } else {
      Fluttertoast.showToast(
          msg: "Login failed. Please check your credentials.");
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool areFieldsEmpty(TextEditingController emailController,
      TextEditingController passwordController) {
    return emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5, top: 24.0),
              child: Center(
                child: Text(
                  "خوش آمدید",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "UrduType", fontSize: 24),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SignUpScreen());
                  },
                  child: const Text(
                    "سائن اپ کریں۔",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 18,
                        color: Color(0xffFE8BD1)),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                const Text(
                  "پہلا اکاؤنٹ؟",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "UrduType",
                      fontSize: 18,
                      color: Color(0xff878787)),
                  textDirection: TextDirection.ltr,
                ),
              ],
            )),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8, top: 36, bottom: 10),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "لیڈی ہیلتھ ورکر کا آی ڈی نمبر",
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
              controller: emailController,
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
              padding: EdgeInsets.only(top: 30.0, bottom: 10, right: 8),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "پاس ورڈ",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 14,
                          color: Color(0xff0F0D18)),
                    ),
                    TextSpan(
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
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
              child: ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  // shadowColor: Colors.red,
                  padding: const EdgeInsets.all(15.0),
                  backgroundColor:
                      const Color(0xffFE8BD1), // Button color when not pressed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        24.0), // Set your desired border radius
                  ),
                ),
                child: const Center(
                  child: Text(
                    'لاگ ان',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: "UrduType",
                      color: Colors.white,
                    ),
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
                      "پاسورڈ بھول گئے؟",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 14,
                          color: Color(0xffFE8BD1)),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "یہ معلومات یاد رکھیں",
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
