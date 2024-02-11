import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'feature_model.dart'; // Ensure you have the GetX package imported

class Submodule {
  final int submoduleID;
  final String title;
  final String description;
  final Offset buttonPosition;
  final String iconPath;
  // Update: Store a list of callback functions to handle navigation
  final int numberOfQuizzes;
  final String titleAlignment;
  final List<Feature> Features;

  Submodule({
    required this.submoduleID,
    required this.title,
    required this.description,
    required this.buttonPosition,
    required this.iconPath,
    required this.numberOfQuizzes,
    required this.titleAlignment,
    required this.Features
  });


}
