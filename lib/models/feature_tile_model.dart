import 'package:flutter/material.dart';

enum FeatureType { video, presentation, quiz }

class FeatureCallback {
  final String title;
  final FeatureType featureType;
  final Future<void> Function() callback; // Ensure this is a Future function
  bool isCompleted; // Attribute to indicate completion status
  final String duration;

  FeatureCallback( {
    required this.title,
    required this.featureType,
    required this.callback,
    required this.duration,
    this.isCompleted = false, // Default is not completed
  });

  IconData get icon {
    if (isCompleted) {
      return Icons.check_circle; // Green tick icon for completed features
    } else {
      switch (featureType) {
        case FeatureType.video:
          return Icons.play_arrow; // Example icon for video
        case FeatureType.presentation:
          return Icons.slideshow; // Example icon for presentation
        case FeatureType.quiz:
          return Icons.question_answer; // Example icon for quiz
        default:
          return Icons.help; // Default icon
      }
    }
  }

  Color get iconColor {
    return isCompleted ? Color(0xff9AC9C2) : Color(0xff685F78); // Green for completed, black for others
  }
}
