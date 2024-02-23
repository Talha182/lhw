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

class Course {
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

  Course({
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

  factory Course.fromJson(Map<String, dynamic> json) {
    // Handling gradient with more detailed null check
    var gradientJson = json['gradient'] as Map<String, dynamic>? ?? {};
    Map<String, String> gradient = {};
    if (gradientJson.isNotEmpty) {
      gradient = gradientJson.map((key, value) => MapEntry(key, value ?? '#FFFFFF'));
    } else {
      gradient = {"startColor": "#FFFFFF", "endColor": "#000000"}; // Default gradient
    }

    // Ensuring modules are safely parsed, handling potential null values within each module
    var modulesJson = json['modules'] as List<dynamic>? ?? [];
    List<Module> modules = [];
    if (modulesJson.isNotEmpty) {
      modules = modulesJson.map((e) => Module.fromJson(e as Map<String, dynamic>)).toList();
    }

    return Course(
      courseId: json['courseId'] as int? ?? 0,
      title: json['title'] as String? ?? 'Unknown Course',
      gradient: gradient,
      quizCount: json['quizCount'] as int? ?? 0,
      moduleCount: json['moduleCount'] as int? ?? 0,
      imagePath: json['imagePath'] as String? ?? '',
      isStart: json['isStart'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      arrowText: json['arrowText'] as String? ?? '',
      modules: modules,
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
  final int courseId;
  final String title;
  final String imagePath;
  final int submoduleCount;
  bool isStart;
  bool isCompleted;
  double progressValue;
  final List<Submodule> submodules;

  Module({
    required this.moduleId,
    required this.courseId,
    required this.title,
    required this.imagePath,
    required this.submoduleCount,
    required this.isStart,
    this.isCompleted = false,
    required this.progressValue,
    required this.submodules,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    List<Submodule> submodulesList = [];
    if (json['submodules'] != null) {
      submodulesList = List<Map<String, dynamic>>.from(json['submodules'])
          .map<Submodule>((submoduleJson) => Submodule.fromJson(submoduleJson))
          .toList();
    }

    return Module(
      moduleId: json['moduleId'] as int? ?? 0,
      courseId: json['courseId'] as int? ?? 0,
      title: json['title'] as String? ?? "Unknown Module",
      imagePath: json['imagePath'] as String? ?? '',
      submoduleCount: json['submoduleCount'] as int? ?? 0,
      isStart: json['isStart'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      progressValue: (json['progressValue'] as num?)?.toDouble() ?? 0.0,
      submodules: submodulesList,
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
    double portionOfProgress =
        totalFeaturesCount > 0 ? 1 / totalFeaturesCount : 0.0;

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
  final int moduleId;
  final String title;
  final String description;
  final String iconPath;
  final int numberOfQuizzes;
  bool isCompleted;
  final List<Feature> features;

  Submodule({
    required this.submoduleId,
    required this.moduleId,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.numberOfQuizzes,
    this.isCompleted = false,
    required this.features,
  });

  factory Submodule.fromJson(Map<String, dynamic> json) {
    // Ensures 'features' is not null and is a list before mapping
    List<Feature> parsedFeatures = [];
    if (json['features'] != null && json['features'] is List) {
      parsedFeatures = List<Map<String, dynamic>>.from(json['features'])
          .map<Feature>((featureJson) => Feature.fromJson(featureJson))
          .toList();
    }

    return Submodule(
      submoduleId: json['submoduleId'] as int? ?? 0,
      moduleId: json['moduleId'] as int? ?? 0,
      title: json['title'] as String? ?? "Unknown Submodule",
      description: json['description'] as String? ?? '',
      iconPath: json['iconPath'] as String? ?? '',
      numberOfQuizzes: json['numberOfQuizzes'] as int? ?? 0,
      features: parsedFeatures,
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
  final int submoduleId;
  final String duration;
  final dynamic relatedData; // Optional field to hold related data

  Feature({
    required this.title,
    required this.featureType,
    this.isCompleted = false, // Default to false
    required this.duration,
    required this.submoduleId,
    this.relatedData,
  });


  factory Feature.fromJson(Map<String, dynamic> json) {
    final String title = json['title'] as String? ?? 'Unknown Feature';
    final String duration = json['duration'] as String? ?? '0min'; // Default value if null
    final featureType = _parseFeatureType(json['featureType'] as String? ?? '');
    var relatedData = json['relatedData'] != null ? jsonDecode(json['relatedData'] as String) : <String, dynamic>{}; // Safe parsing with default


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
      title: title,
      featureType: featureType, // Assuming this is parsed elsewhere
      isCompleted: json['isCompleted'] == 1,
      duration: duration,
      submoduleId: json['submoduleId'] as int? ?? 0,
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

  static FeatureType _parseFeatureType(String featureTypeStr) {
    return FeatureType.values.firstWhere(
          (e) => e.toString().split('.').last == featureTypeStr,
      orElse: () => FeatureType.unknown,
    );
  }

  static dynamic _parseRelatedData(FeatureType featureType, Map<String, dynamic> json) {
    switch (featureType) {
      case FeatureType.presentation:
        return json.containsKey('presentationModel')
            ? PresentationModel.fromJson(json['presentationModel'] as Map<String, dynamic>)
            : null;
      case FeatureType.comicStrips:
        return json.containsKey('comicStrips')
            ? List<dynamic>.from(json['comicStrips']).map((csJson) => ComicStripModel.fromJson(csJson as Map<String, dynamic>)).toList()
            : [];
      case FeatureType.flashCards:
        return json.containsKey('flashCards')
            ? List<dynamic>.from(json['flashCards']).map((fcJson) => FlashCard.fromJson(fcJson as Map<String, dynamic>)).toList()
            : [];
      case FeatureType.infographics:
        return json.containsKey('infographics')
            ? InfographicsModel.fromJson({'infographics': List<Map<String, dynamic>>.from(json['infographics'])})
            : null;
      case FeatureType.interactiveAnimationVideo:
        return json.containsKey('videoPath')
            ? InteractiveAnimationVideoModel.fromJson(json)
            : null;
      case FeatureType.interactiveImage:
        return json.containsKey('interactiveImageModel')
            ? List<dynamic>.from(json['interactiveImageModel']).map((imageJson) => InteractiveImageModel.fromJson(imageJson as Map<String, dynamic>)).toList()
            : [];
      case FeatureType.imageHotspot:
        return json.containsKey('imageHotspot')
            ? ImageHotspotModel.fromJson(json['imageHotspot'] as Map<String, dynamic>)
            : null;
      case FeatureType.textBranchingScenario:
        return json.containsKey('textBranchingScenarioModel')
            ? TextBranchingScenarioModel.fromJson(json['textBranchingScenarioModel'] as Map<String, dynamic>)
            : null;
      case FeatureType.imageBranchingScenario:
        return json.containsKey('imageBranchingScenarioModel')
            ? ImageBranchingScenarioModel.fromJson(json['imageBranchingScenarioModel'] as Map<String, dynamic>)
            : null;
      default:
        return null;
    }
  }
}

Future<List<Course>> fetchCourses() async {
  String jsonString = await rootBundle.loadString('assets/data/courses.json');
  final jsonData = json.decode(jsonString) as Map<String, dynamic>;
  return List<Course>.from(
      jsonData['courses'].map((x) => Course.fromJson(x)));
}
