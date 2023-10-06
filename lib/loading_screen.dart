import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xffFE8BD1),
          rightDotColor: const Color(0xff7A7D84),
          size: 20,
        ),// or any other loading widget you prefer
      ),
    );
  }
}
