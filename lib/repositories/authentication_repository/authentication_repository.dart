import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lhw/Login_SignUp/Login.dart';
import 'package:lhw/controllers/signup_controller.dart';
import 'package:lhw/navy.dart';
import 'package:lhw/splash/splash.dart';

import 'auth_status.dart';
import 'exceptions/signup_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variable
  final _auth = FirebaseAuth.instance;
  final Rx<User?> firebaseUser = Rx<User?>(null);
  var verificationId = ''.obs;
  var authStatus = AuthStatus.undecided.obs;


  @override
  void onReady() {
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, (User? user) {
      if (user == null) {
        authStatus.value = AuthStatus.unauthenticated;
      } else {
        authStatus.value = AuthStatus.authenticated;
      }
    });
  }


  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const Custom_NavBar());
    }
  }

  // _setInitialScreen(User? user) async {
  //   Get.offAll(() => LoadingScreen()); // Initially show the loading screen
  //
  //   await Future.delayed(Duration(seconds: 2)); // Optional: wait for 2 seconds or any desired duration
  //
  //   user == null
  //       ? Get.offAll(() => const LoginScreen())
  //       : Get.offAll(() => const Custom_NavBar());
  // }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const Custom_NavBar())
          : Get.to(() => const SplashScreen());
      Fluttertoast.showToast(
          msg: "Account created successfully!",
          backgroundColor: Colors.green.withOpacity(0.1),
          textColor: Colors.green);
    } on FirebaseException catch (e) {
      final ex = SignUpExceptions.code(e.code);
      print(ex.message);
      throw ex;
    } catch (_) {
      const ex = SignUpExceptions();
      print(ex.message);
      throw ex;
    }
  }

  Future<void> LoginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Clear text fields only after successful login
      SignUpController.instance.clearLoginFields();

      // Show toast for successful login
      Fluttertoast.showToast(
          msg: "Login successful!",
          backgroundColor: Colors.green.withOpacity(0.1),
          textColor: Colors.green);

      firebaseUser.value != null
          ? Get.offAll(() => const Custom_NavBar(),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 300))
          : Get.to(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          Fluttertoast.showToast(
              msg: "Email not found.",
              backgroundColor: Colors.red.withOpacity(0.1),
              textColor: Colors.red);
          break;
        case 'wrong-password':
          Fluttertoast.showToast(
              msg: "Incorrect password.",
              backgroundColor: Colors.red.withOpacity(0.1),
              textColor: Colors.red);
          break;
        default:
          Fluttertoast.showToast(
              msg: "Both email and password are incorrect.",
              backgroundColor: Colors.red.withOpacity(0.1),
              textColor: Colors.red);
      }
      throw e;
    } catch (_) {
      const ex = SignUpExceptions();
      print("EXCEPTION - ${ex.message}");
      throw ex;
    }
  }

  Future<void> Logout() async {
    await _auth.signOut();
  }
}
