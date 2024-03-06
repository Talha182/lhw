import 'dart:convert';
import 'package:flutter/material.dart';

import '../Database/database_helper.dart';

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
      'progress': progress ?? 0.0,
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
      progress: map['progress'] ?? 0.0,
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

    var modulesJson = json['modules'] as List<dynamic>? ?? [];
    List<Module> modules = modulesJson.isNotEmpty
        ? modulesJson
            .map((e) => Module.fromJson(e as Map<String, dynamic>))
            .toList()
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
  void updateModules(Module updatedModule) {
    int index = modules
        .indexWhere((module) => module.moduleId == updatedModule.moduleId);
    if (index != -1) {
      modules[index] = updatedModule;
    }
  }
}

class Module with ChangeNotifier {
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
    required this.progressValue, // Initialize with a value
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
    List<Submodule> decodedSubmodules = [];
    if (map['submodules'] is String) {
      List<dynamic> jsonList = jsonDecode(map['submodules']);
      decodedSubmodules =
          jsonList.map((json) => Submodule.fromMap(json)).toList();
    } else if (map['submodules'] is List) {
      decodedSubmodules = (map['submodules'] as List)
          .map((submoduleMap) => Submodule.fromMap(submoduleMap))
          .toList();
    }

    return Module(
      moduleId: map['moduleId'],
      courseId: map['courseId'],
      title: map['title'],
      imagePath: map['imagePath'],
      submoduleCount: map['submoduleCount'],
      isStart: map['isStart'] == 1,
      isCompleted: map['isCompleted'] == 1,
      progressValue: map['progressValue'].toDouble(),
      submodules: decodedSubmodules,
    );
  }

  Map<String, dynamic> toMapWithCourseId(int courseId) {
    var map = toMap();
    map['courseId'] = courseId;
    return map;
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

  Submodule copyWith({
    int? moduleId,
  }) {
    return Submodule(
      submoduleId: this.submoduleId,
      moduleId: moduleId ?? this.moduleId,
      title: this.title,
      description: this.description,
      iconPath: this.iconPath,
      numberOfQuizzes: this.numberOfQuizzes,
      isCompleted: this.isCompleted,
      features: this.features,
    );
  }

  Map<String, dynamic> toMapWithModuleId(int moduleId) {
    var map = toMap();
    map['moduleId'] = moduleId;
    return map;
  }

  Map<String, dynamic> toMap() {
    // Convert the list of features to a JSON string
    String featuresJson =
        jsonEncode(features.map((feature) => feature.toMap()).toList());

    return {
      'submoduleId': submoduleId,
      'moduleId': moduleId,
      'title': title,
      'description': description,
      'iconPath': iconPath,
      'numberOfQuizzes': numberOfQuizzes,
      'isCompleted': isCompleted ? 1 : 0,
      'features': featuresJson, // Store the JSON string
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
}

class Feature extends ChangeNotifier {
  final int featureId;
  final String title;
  final FeatureType featureType;
  ValueNotifier<bool> isCompleted;
  final int submoduleId;
  final String duration;
  final dynamic data;

  Feature({
    required this.featureId,
    required this.title,
    required this.featureType,
    required bool isCompleted,
    required this.submoduleId,
    required this.duration,
    required this.data,
  }) : this.isCompleted = ValueNotifier(isCompleted);

  void toggleCompletion() async {
    isCompleted.value = !isCompleted.value;
    // Make sure to update the database or any persistent storage here
    await DatabaseHelper.instance.markFeatureAsCompleted(featureId);
  }

  void toggleFeatureCompletion(Feature feature) async {
    // Assuming you have a method to update the database
    bool updateSuccessful = await DatabaseHelper.instance
        .toggleFeatureCompletion(feature.featureId);

    if (updateSuccessful) {
      feature.toggleCompletion();
      notifyListeners(); // If using a provider/model that extends ChangeNotifier
    }
  }

  static FeatureType _featureTypeFromString(String typeString) {
    switch (typeString) {
      case "presentation":
        return FeatureType.presentation;
      case "comicStrip":
        return FeatureType.comicStrip;
      case "flashCard": // Add this case
        return FeatureType.flashCard;
      case "infographics": // Add this case
        return FeatureType.infographics;
      case "interactiveAnimationVideo": // Add this case
        return FeatureType.interactiveAnimationVideo;
      case "interactiveImage":
        return FeatureType.interactiveImage;
      case "imageHotspot": // Add this case
        return FeatureType.imageHotspot;
      case "imageBranchingScenario": // Add this case
        return FeatureType.imageBranchingScenario;
      case "textBranchingScenario": // Add this case
        return FeatureType.textBranchingScenario;
      default:
        return FeatureType.unknown;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'featureId': featureId,
      'submoduleId': submoduleId,
      'title': title,
      'featureType': featureType.toString().split('.').last,
      'isCompleted': isCompleted.value ? 1 : 0,
      'duration': duration,
      'data': jsonEncode(data),
    };
  }

  static Feature fromMap(Map<String, dynamic> map) {
    var dataField = map['data'];
    dynamic decodedData =
        dataField is String ? jsonDecode(dataField) : dataField;
    return Feature(
      featureId: map['featureId'] ?? 0,
      title: map['title'] ?? 'Unknown Feature',
      featureType:
          _featureTypeFromString(map['featureType']) ?? FeatureType.unknown,
      isCompleted: map['isCompleted'] == 1,
      submoduleId: map['submoduleId'] ?? 0,
      duration: map['duration'] ?? '0min',
      data: decodedData,
    );
  }

  factory Feature.fromJson(Map<String, dynamic> json) {
    final int featureId = json['featureId'] as int? ?? 0;
    final String title = json['title'] as String? ?? 'Unknown Feature';
    final String duration = json['duration'] as String? ?? '0min';
    final FeatureType featureType =
        _parseFeatureType(json['featureType'] as String? ?? '');
    final dynamic data = json['data'];

    return Feature(
      featureId: featureId,
      title: title,
      featureType: featureType,
      isCompleted: json['isCompleted'] as bool? ?? false,
      submoduleId: json['submoduleId'] as int? ?? 0,
      duration: duration,
      data: data,
    );
  }
  Feature copyWith({
    int? submoduleId,
  }) {
    return Feature(
      featureId: this.featureId,
      title: this.title,
      featureType: this.featureType,
      isCompleted: this.isCompleted.value,
      submoduleId: submoduleId ?? this.submoduleId,
      duration: this.duration,
      data: this.data,
    );
  }

  IconData get icon {
    if (isCompleted.value) {
      return Icons.check_circle;
    } else {
      switch (featureType) {
        case FeatureType.video:
          return Icons.play_arrow;
        case FeatureType.presentation:
          return Icons.slideshow;
        case FeatureType.quiz:
          return Icons.question_answer;
        case FeatureType.comicStrip:
          return Icons.image;
        case FeatureType.flashCard:
          return Icons.flash_on;
        case FeatureType.infographics:
          return Icons.insert_chart;
        case FeatureType.interactiveAnimationVideo:
          return Icons.videocam;
        case FeatureType.interactiveImage:
          return Icons.image_aspect_ratio;
        case FeatureType.imageHotspot:
          return Icons.image;
        case FeatureType.textBranchingScenario:
          return Icons.text_fields;
        case FeatureType.imageBranchingScenario:
          return Icons.image;
        default:
          return Icons.help;
      }
    }
  }

  Color get iconColor {
    return isCompleted.value
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

enum FeatureType {
  video,
  presentation,
  quiz,
  comicStrip,
  flashCard,
  infographics,
  interactiveAnimationVideo,
  interactiveImage,
  imageHotspot,
  textBranchingScenario,
  imageBranchingScenario,
  animationVideo,
  unknown
}
