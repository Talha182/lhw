import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhw/models/interactive_images_model.dart';

import '../BranchingScenarios/ImageBranchingScenario.dart';
import '../BranchingScenarios/TextBranchingScenario.dart';
import '../Infographics/infographics.dart';
import '../InteractiveAnimationVideo/interactive_animation_video.dart';
import '../Presentation/presentation_model.dart';
import '../ComicStrip/comic_strip.dart';
import '../models/flash_cards_screen_model.dart';
import '../models/image_hotspot_model.dart';

class TestCourseModel {
  final int courseId;
  final String title;
  final Map<String, String> gradient;
  final int quizCount;
  final int moduleCount;
  final String imagePath;
  bool isStart;
  bool isCompleted;
  double progress;
  final String arrowText;
  final List<Module> modules;

  TestCourseModel({
    required this.courseId,
    required this.title,
    required this.gradient,
    required this.quizCount,
    required this.moduleCount,
    required this.imagePath,
    required this.isStart,
    this.isCompleted = false, // Default to false
    required this.progress,
    required this.arrowText,
    required this.modules,
  });

  factory TestCourseModel.fromJson(Map<String, dynamic> json) {
    return TestCourseModel(
      courseId: json['courseId'],
      title: json['title'],
      gradient: {
        'start': json['gradient']['start'],
        'end': json['gradient']['end'],
      },
      quizCount: json['quizCount'],
      moduleCount: json['moduleCount'],
      imagePath: json['imagePath'],
      isStart: json['isStart'],
      isCompleted: json['isCompleted'] as bool? ?? false,
      progress: json['progress'] ?? 0.0,
      arrowText: json['arrowText'],
      modules: List<Module>.from(json['modules'].map((x) => Module.fromJson(x))),
    );
  }

  // Method to update course progress
  void updateCourseCompletionProgress() {
    int completedFeaturesCount = 0;
    int totalFeaturesCount = 0;

    // Iterate through modules
    for (Module module in modules) {
      // Update module completion status and progress value
      module.updateCompletionStatus();
      module.updateProgressValue();

      // Iterate through submodules
      for (Submodule submodule in module.submodules) {
        // Update submodule completion status
        submodule.updateCompletionStatus();

        // Update feature completion status and count completed features
        for (Feature feature in submodule.features) {
          totalFeaturesCount++;
          if (feature.isCompleted) {
            completedFeaturesCount++;
          }
        }
      }
    }

    // Calculate overall course progress
    if (totalFeaturesCount > 0) {
      progress = completedFeaturesCount / totalFeaturesCount;
    } else {
      progress = 0.0;
    }
  }
}

class Module {
  final int moduleId;
  final String title;
  final String imagePath;
  final int submoduleCount;
  bool isStart;
  bool isCompleted;
  double progressValue;
  final List<Submodule> submodules;

  Module({
    required this.moduleId,
    required this.title,
    required this.imagePath,
    required this.submoduleCount,
    required this.isStart,
    this.isCompleted = false, // Default to false
    required this.progressValue,
    required this.submodules,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      moduleId: json['moduleId'],
      title: json['title'],
      imagePath: json['imagePath'],
      submoduleCount: json['submoduleCount'],
      isStart: json['isStart'],
      progressValue: json['progressValue'] ?? 0.0,
      submodules: List<Submodule>.from(
          json['submodules'].map((x) => Submodule.fromJson(x))),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  // Method to calculate progress based on completed submodules and features
  void updateProgressValue() {
    int totalFeaturesCount = submodules
        .map((submodule) => submodule.features.length)
        .reduce((value, element) => value + element);
    int completedFeaturesCount = submodules
        .expand((submodule) => submodule.features)
        .where((feature) => feature.isCompleted)
        .length;

    // Calculate equal portion of progress for each feature
    double portionOfProgress = totalFeaturesCount > 0
        ? 1 / totalFeaturesCount
        : 0.0;

    // Calculate total progress based on completed features
    double totalProgress = completedFeaturesCount * portionOfProgress;

    // Update module progress value
    progressValue = totalProgress;
  }

  // Method to update module's completion status
  void updateCompletionStatus() {
    // Check if all submodules and their features are completed
    this.isCompleted = submodules.every((submodule) {
      submodule
          .updateCompletionStatus(); // Ensure submodule completion status is up to date
      return submodule.isCompleted;
    });
  }
}


class Submodule {
  final int submoduleId;
  final String title;
  final String description;
  final String iconPath;
  final int numberOfQuizzes;
  bool isCompleted;
  final List<Feature> features;

  Submodule({
    required this.submoduleId,
    required this.title,
    required this.description,
    required this.iconPath,
    this.isCompleted = false, // Default to false
    required this.numberOfQuizzes,
    required this.features,
  });

  factory Submodule.fromJson(Map<String, dynamic> json) {
    return Submodule(
      submoduleId: json['submoduleId'],
      title: json['title'],
      description: json['description'],
      iconPath: json['iconPath'],
      numberOfQuizzes: json['numberOfQuizzes'],
      features:
          List<Feature>.from(json['features'].map((x) => Feature.fromJson(x))),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
  // Method to check and update completion status
  void updateCompletionStatus() {
    // Check if all features are completed
    this.isCompleted = features.every((feature) => feature.isCompleted);

    // You can include additional logic here if needed, for example, to perform actions when a submodule is completed
  }
}

// Assuming the enum FeatureType is defined as shown previously
enum FeatureType {
  video,
  presentation,
  quiz,
  comicStrips,
  flashCards,
  infographics,
  interactiveAnimationVideo,
  interactiveImage,
  imageHotspot,
  textBranchingScenario,
  imageBranchingScenario,
  animationVideo,
  unknown
}

class Feature {
  final String title; // Example of a String field that might cause the error
  final FeatureType featureType;
  bool isCompleted; // Example bool field that might cause the error
  final String duration;
  final dynamic relatedData; // Optional field to hold related data

  Feature({
    required this.title,
    required this.featureType,
    this.isCompleted = false, // Default to false
    required this.duration,
    this.relatedData,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    FeatureType featureType = FeatureType.values.firstWhere(
      (type) => type.toString().split('.').last == json['featureType'],
      orElse: () => FeatureType.unknown,
    );

    dynamic relatedData;
    if (featureType == FeatureType.presentation &&
        json.containsKey('presentationModel')) {
      relatedData = PresentationModel.fromJson(json['presentationModel']);
    }
    // Correction in Feature.fromJson for handling comic strips
    if (json.containsKey('comicStrips')) {
      List<dynamic> comicStripsJson = json['comicStrips'] as List;
      relatedData = comicStripsJson
          .map((csJson) =>
              ComicStripModel.fromJson(csJson as Map<String, dynamic>))
          .toList();
    }

    if (json.containsKey('flashCards')) {
      List<dynamic> flashCardsJson = json['flashCards'] as List;
      relatedData = flashCardsJson
          .map((fcJson) => FlashCard.fromJson(fcJson as Map<String, dynamic>))
          .toList();
    }

    if (featureType == FeatureType.infographics &&
        json.containsKey('infographics')) {
      var infographicsJson = json['infographics'] as List;
      relatedData =
          InfographicsModel.fromJson({'infographics': infographicsJson});
    }

    if (featureType == FeatureType.interactiveAnimationVideo &&
        json.containsKey('videoPath')) {
      relatedData = InteractiveAnimationVideoModel.fromJson(json);
    }

    if (featureType == FeatureType.interactiveImage &&
        json.containsKey('interactiveImageModel')) {
      List<dynamic> imagesInfoJson = json['interactiveImageModel'] as List;
      relatedData = imagesInfoJson
          .map((imageJson) => InteractiveImageModel.fromJson(imageJson))
          .toList();
    }
    // Hotspot Image
    if (featureType == FeatureType.imageHotspot &&
        json.containsKey('imageHotspot')) {
      relatedData = ImageHotspotModel.fromJson(json['imageHotspot']);
    }
    if (featureType == FeatureType.textBranchingScenario) {
      relatedData = TextBranchingScenarioModel.fromJson(
          json['textBranchingScenarioModel']);
    }
    if (featureType == FeatureType.imageBranchingScenario) {
      relatedData = ImageBranchingScenarioModel.fromJson(
          json['imageBranchingScenarioModel']);
    }

    return Feature(
      title: json['title'] as String? ?? 'Default Title',
      featureType: featureType,
      isCompleted: json['isCompleted'] as bool? ?? false,
      duration: json['duration'] as String? ?? 'Default duration',
      relatedData: relatedData,
    );
  }

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
        case FeatureType.comicStrips:
          return Icons.image; // Example icon for comic strips
        case FeatureType.flashCards:
          return Icons.flash_on; // Example icon for flash cards
        case FeatureType.infographics:
          return Icons.insert_chart; // Example icon for infographics
        case FeatureType.interactiveAnimationVideo:
          return Icons.videocam; // Example icon for interactive animation video
        case FeatureType.interactiveImage:
          return Icons.image_aspect_ratio; // Example icon for interactive image
        case FeatureType.imageHotspot:
          return Icons.image; // Example icon for hotspot image
        case FeatureType.textBranchingScenario:
          return Icons.text_fields; // Example icon for text branching scenario
        case FeatureType.imageBranchingScenario:
          return Icons.image; // Example icon for image branching scenario
        default:
          return Icons.help; // Default icon
      }
    }
  }

  Color get iconColor {
    return isCompleted
        ? const Color(0xff9AC9C2)
        : const Color(0xff685F78); // Green for completed, purple for others
  }
}

Future<List<TestCourseModel>> fetchCourses() async {
  String jsonString = await rootBundle.loadString('assets/data/courses.json');
  final jsonData = json.decode(jsonString) as Map<String, dynamic>;
  return List<TestCourseModel>.from(
      jsonData['courses'].map((x) => TestCourseModel.fromJson(x)));
}
