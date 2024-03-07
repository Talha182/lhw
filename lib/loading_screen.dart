import 'package:flutter/material.dart';
import 'package:lhw/LoginSignUp/Login.dart';
import 'package:lhw/navy.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xffFE8BD1),
          rightDotColor: const Color(0xff7A7D84),
          size: 45,
        ),// or any other loading widget you prefer
      ),
    );
  }
}



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => isLoggedIn ? const Custom_NavBar() : const LoginScreen(),
    ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, checkLoginStatus);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingScreen(),
      ),
    );
  }
}
