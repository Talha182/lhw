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
  final List<String> gradient;
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

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'title': title,
      'quizCount': quizCount,
      'moduleCount': moduleCount,
      'imagePath': imagePath,
      'isStart': isStart ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
      'progress': progress,
      'arrowText': arrowText,
      'gradient': jsonEncode(gradient),
      'modules': jsonEncode(modules.map((module) => module.toMap()).toList()),
    };
  }
  static Course fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map['courseId'],
      title: map['title'],
      quizCount: map['quizCount'],
      moduleCount: map['moduleCount'],
      imagePath: map['imagePath'],
      isStart: map['isStart'] == 1,
      isCompleted: map['isCompleted'] == 1,
      progress: map['progress'],
      arrowText: map['arrowText'],
      gradient: (jsonDecode(map['gradient']) as List<dynamic>)
          .map((color) => color.toString())
          .toList(),
      modules: (jsonDecode(map['modules']) as List<dynamic>)
          .map((moduleJson) => Module.fromMap(moduleJson))
          .toList(),
    );
  }


  factory Course.fromJson(Map<String, dynamic> json) {
    // Correctly handling gradient as a List<String>
    List<String> gradient = [];
    if (json['gradient'] != null) {
      gradient = List<String>.from(json['gradient']);
    }

    // Ensuring modules are safely parsed, handling potential null values within each module
    var modulesJson = json['modules'] as List<dynamic>? ?? [];
    List<Module> modules = modulesJson.isNotEmpty
        ? modulesJson.map((e) => Module.fromJson(e as Map<String, dynamic>)).toList()
        : [];

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

  Map<String, dynamic> toMap() {
    return {
      'moduleId': moduleId,
      'courseId': courseId,
      'title': title,
      'imagePath': imagePath,
      'submoduleCount': submoduleCount,
      'isStart': isStart ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
      'progressValue': progressValue,
      'submodules':
      jsonEncode(submodules.map((submodule) => submodule.toMap()).toList()),
    };
  }

  static Module fromMap(Map<String, dynamic> map) {
    // This variable will hold the decoded submodules list
    List<Submodule> decodedSubmodules = [];

    // Check if 'submodules' is a string (encoded as JSON)
    if (map['submodules'] is String) {
      // If it's a string, decode it
      List<dynamic> jsonList = jsonDecode(map['submodules']);
      decodedSubmodules =
          jsonList.map((json) => Submodule.fromMap(json)).toList();
    } else if (map['submodules'] is List) {
      // If it's already a List, use it directly
      decodedSubmodules = (map['submodules'] as List)
          .map((submoduleMap) => Submodule.fromMap(submoduleMap))
          .toList();
    } else {
      print("Unexpected type for 'submodules', neither String nor List");
    }

    return Module(
      moduleId: map['moduleId'],
      courseId: map['courseId'],
      title: map['title'],
      imagePath: map['imagePath'],
      submoduleCount: map['submoduleCount'],
      isStart: map['isStart'] == 1,
      isCompleted: map['isCompleted'] == 1,
      progressValue: map['progressValue'],
      submodules: decodedSubmodules,
    );
  }

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

  Map<String, dynamic> toMap() {
    // Convert features list to a JSON string before saving to the database
    var featuresMap = features.map((feature) => feature.toMap()).toList();
    return {
      'submoduleId': submoduleId,
      'moduleId': moduleId,
      'title': title,
      'description': description,
      'iconPath': iconPath,
      'numberOfQuizzes': numberOfQuizzes,
      'isCompleted': isCompleted ? 1 : 0,
      'features':
      jsonEncode(featuresMap), // Encoding the features list to a string
    };
  }

  static Submodule fromMap(Map<String, dynamic> map) {
    // Handling the features either as a JSON-encoded string or as a direct list
    List<Feature> decodedFeatures = [];
    var featuresData = map['features'];
    if (featuresData is String) {
      // Decode if it's a string
      List<dynamic> featuresList = jsonDecode(featuresData);
      decodedFeatures = featuresList.map((f) => Feature.fromMap(f)).toList();
    } else if (featuresData is List) {
      // Directly use it if it's already a List
      decodedFeatures = featuresData.map((f) => Feature.fromMap(f)).toList();
    }

    return Submodule(
      submoduleId: map['submoduleId'],
      moduleId: map['moduleId'],
      title: map['title'],
      description: map['description'],
      iconPath: map['iconPath'],
      numberOfQuizzes: map['numberOfQuizzes'],
      isCompleted: map['isCompleted'] == 1,
      features: decodedFeatures,
    );
  }

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
  final int featureId;
  final String title;
  final FeatureType featureType;
  bool isCompleted;
  final int submoduleId;
  final String duration;
  final dynamic relatedData; // Optional field to hold related data

  Feature({
    required this.featureId,
    required this.title,
    required this.featureType,
    this.isCompleted = false,
    required this.submoduleId,
    required this.duration,
    this.relatedData,
  });

  // Convert string to FeatureType enum
  static FeatureType _featureTypeFromString(String typeString) {
    return FeatureType.values.firstWhere(
            (type) => type.toString().split('.').last == typeString,
        orElse: () => FeatureType.video); // Default to video if not found
  }

  Map<String, dynamic> toMap() {
    return {
      'featureId': featureId,
      'title': title,
      'featureType':
      featureType.toString().split('.').last, // Convert enum to string
      'isCompleted': isCompleted ? 1 : 0,
      'submoduleId': submoduleId,
      'duration': duration,
      'relatedData':
      relatedData != null ? jsonEncode(relatedData) : jsonEncode({}),
    };
  }

  static Feature fromMap(Map<String, dynamic> map) {
    return Feature(
      featureId: map['featureId'],
      title: map['title'],
      featureType: _featureTypeFromString(map['featureType']),
      isCompleted: map['isCompleted'] == 1,
      submoduleId: map['submoduleId'],
      duration: map['duration'],
      relatedData:
      map['relatedData'] != null ? jsonDecode(map['relatedData']) : null,
    );
  }

  factory Feature.fromJson(Map<String, dynamic> json) {
    final int featureId = json['featureId'] as int? ?? 0;
    final String title = json['title'] as String? ?? 'Unknown Feature';
    final String duration =
        json['duration'] as String? ?? '0min'; // Default value if null
    final featureType = _parseFeatureType(json['featureType'] as String? ?? '');
    var relatedData = json['relatedData'] != null
        ? jsonDecode(json['relatedData'] as String)
        : <String, dynamic>{}; // Safe parsing with default

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
      relatedData: relatedData, featureId: featureId,
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
}

Future<List<Course>> fetchCourses() async {
  String jsonString = await rootBundle.loadString('assets/data/courses.json');
  final jsonData = json.decode(jsonString) as Map<String, dynamic>;
  return List<Course>.from(
      jsonData['courses'].map((x) => Course.fromJson(x)));
}
