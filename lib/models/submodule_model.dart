import 'dart:ui';

import 'package:flutter/material.dart';

class Submodule {
  final String title;
  final String description;
  final Offset buttonPosition;
  final String iconPath;
  final List<void Function()> features; // List of navigation actions
  final int numberOfQuizzes;
  final String titleAlignment;

  Submodule({
    required this.title,
    required this.description,
    required this.buttonPosition,
    required this.iconPath,
    required this.features,
    required this.numberOfQuizzes,
    required this.titleAlignment,

  });
}