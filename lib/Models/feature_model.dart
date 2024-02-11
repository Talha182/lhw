import 'package:flutter/material.dart';

enum FeatureType { video, presentation, quiz }

class Feature {
  final String title;
  final FeatureType featureType;
  bool isCompleted; // Attribute to indicate completion status
  final String duration;
  final dynamic relatedData; // Optional field to hold related data


  Feature({
    required this.title,
    required this.featureType,
    required this.duration,
    this.isCompleted = false, // Default is not completed
    this.relatedData, // Added this line

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
    return isCompleted ? const Color(0xff9AC9C2) : const Color(0xff685F78); // Green for completed, black for others
  }
}
