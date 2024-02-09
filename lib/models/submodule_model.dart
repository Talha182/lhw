import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'feature_tile_model.dart'; // Ensure you have the GetX package imported

class Submodule {
  final int submoduleID;
  final String title;
  final String description;
  final Offset buttonPosition;
  final String iconPath;
  // Update: Store a list of callback functions to handle navigation
  final List<void Function()> navigateToFeatureCallbacks;
  final int numberOfQuizzes;
  final String titleAlignment;
  final List<FeatureCallback> featureCallbacks;

  Submodule({
    required this.submoduleID,
    required this.title,
    required this.description,
    required this.buttonPosition,
    required this.iconPath,
    required this.navigateToFeatureCallbacks, // Adjusted to callback functions
    required this.numberOfQuizzes,
    required this.titleAlignment,
    required this.featureCallbacks
  });


}
