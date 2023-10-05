import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhw/Login_SignUp/Forgot_Password.dart';
import 'package:lhw/Login_SignUp/Onboarding.dart';
import 'package:lhw/Login_SignUp/SignUp.dart';
import 'package:lhw/navy.dart';
import 'package:lhw/splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFE8BD1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(150, 37),
                  ),
                  onPressed: () {
                    Get.offAll(() => const SplashScreen(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 400));
                  },
                  child: const Text(
                    'لاگ ان کریں',
                    style: TextStyle(
                      fontFamily: 'UrduType',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
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
            )
          ],
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
          transition: Transition.fadeIn, duration: const Duration(milliseconds: 400));
    } else {
      Get.offAll(() => const Custom_NavBar(),
          transition: Transition.fadeIn, duration: const Duration(milliseconds: 400));
    }
  }
}
