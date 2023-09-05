import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double width;
  final double height;
  final double value; // value should be between 0 and 1

  ProgressBar({
    required this.width,
    required this.height,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(height / 2)),
      child: Container(
        width: width,
        height: height,
        child: LinearProgressIndicator(
          minHeight: height,
          value: value,
          color: Color(0xff9AC9C2),
          backgroundColor: Colors.grey[300],
        ),
      ),
    );
  }
}