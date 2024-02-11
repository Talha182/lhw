import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeCheck {
  static Future<void> checkFirstTimeAndShowDialog(
      String key, String dialogText, String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool(key) ?? true;

    // if (isFirstTime) {
    // Show the dialog with dynamic content
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        child: SizedBox(
          width: Get.width - 30,
          height: 300,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Stack(
                  children: [
                    const Positioned(
                        top: 20,
                        right: 20,
                        child: Text("Welcome to home page")),
                    Positioned(
                        bottom: 60,
                        right: 50,
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(child: Text("Go on")),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    await prefs.setBool(key, false);
    // }
  }
}
