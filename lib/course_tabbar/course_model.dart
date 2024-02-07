import 'package:flutter/material.dart';

import 'ModuleTest/module_model.dart';

//course model
class Course {
  final int courseId;
  final String title;
  final LinearGradient gradient;
  final int quizCount;
  final int moduleCount;
  final String imagePath;
  final bool isStart;
  final bool isCompleted;
  final double progress; // New attribute for progress percentage
  final String arrowText;
  final List<Module> modules;

  Course({
    required this.courseId,
    required this.title,
    required this.gradient,
    required this.quizCount,
    required this.moduleCount,
    required this.imagePath,
    this.arrowText = 'Completed',
    this.isStart = false,
    this.isCompleted = false,
    this.progress = 0.0, // Default to 0.0
    required this.modules, // add this line
  });
}
