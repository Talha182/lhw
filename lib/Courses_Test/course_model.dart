import 'package:flutter/material.dart';

//course model
class Course {
  final String title;
  final LinearGradient gradient;
  final int quizCount;
  final int moduleCount;
  final String imagePath;
  final bool isStart;
  final bool isCompleted;
  final double progress; // New attribute for progress percentage

  Course({
    required this.title,
    required this.gradient,
    required this.quizCount,
    required this.moduleCount,
    required this.imagePath,
    this.isStart = false,
    this.isCompleted = false,
    this.progress = 0.0, // Default to 0.0
  });
}
