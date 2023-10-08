import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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

  bool areFieldsEmpty(TextEditingController emailController, TextEditingController passwordController) {
    return emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty;
  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Center(
                child: Text(
              "خوش آمدید",
              style: TextStyle(fontFamily: "UrduType", fontSize: 30),
            )),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "میں نئے ہیں؟",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 20,
                        color: Color(0xff878787)),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.clearLoginFields();
                      Get.to(() => const SignUpScreen(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 500));
                    },
                    child: const Text(
                      "سائن اپ",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 20,
                          color: Color(0xffFE8BD1)),
                    ),
                  ),
                  const Text(
                    "LHW",
                    style: TextStyle(
                        fontFamily: "UrduType",
                        fontSize: 20,
                        color: Color(0xff878787)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "لیڈی ہیلتھ ورکر کا شناختی نمبر*",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 16,
                  color: Color(0xff0F0D18)),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: controller.email,
              keyboardType: TextInputType.phone,
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
                    color: Color(0xffCDD1E0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "پاس ورڈ",
              style: TextStyle(
                  fontFamily: "UrduType",
                  fontSize: 16,
                  color: Color(0xff0F0D18)),
            ),
            const SizedBox(
              height: 5,
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
                        color: Color(0xffCDD1E0),
                      ),
                    ))),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: Get.width,
                height: 45,
                  child:RoundedButton(
                      title: 'لاگ ان کریں',
                      onTap: () {
                        if (areFieldsEmpty(controller.email, controller.password)) {
                          Fluttertoast.showToast(
                              msg: "Please fill all the fields!",
                              backgroundColor: Colors.red.withOpacity(0.1),
                              textColor: Colors.red
                          );
                        } else {
                          SignUpController.instance.Login(
                              controller.email.text.trim(),
                              controller.password.text.trim()
                          );
                        }
                      }
                  )



              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomCheckbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "مجھے پہچانتے ہو",
                        style: TextStyle(
                            fontFamily: "UrduType",
                            fontSize: 16,
                            color: Color(0xff0F0D18)),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordScreen(),
                          transition: Transition.fade,
                          duration: const Duration(milliseconds: 400));
                    },
                    child: const Text(
                      "پاسورڈ بھول گے؟",
                      style: TextStyle(
                          fontFamily: "UrduType",
                          fontSize: 16,
                          color: Color(0xffFE8BD1)),
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

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const RoundedButton({
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
          border: Border.all(width: 1.0, color: const Color(0xffE5E5E5)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.value ? const Icon(Icons.check, size: 20.0) : null,
      ),
    );
  }
}

class InitialRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _checkFirstTime();
    return const Scaffold(
        body: Center(
            child:
                CircularProgressIndicator())); // Loading screen while checking
  }

  _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('is_first_time') ?? true;

    if (isFirstTime) {
      Get.offAll(() => const LoginScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 400));
    } else {
      Get.offAll(() => const Custom_NavBar(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 400));
    }
  }
}
