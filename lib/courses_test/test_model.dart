import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestCourseModel {
  final int courseId;
  final String title;
  final Map<String, String> gradient;
  final int quizCount;
  final int moduleCount;
  final String imagePath;
  final bool isStart;
  final bool isCompleted;
  final double progress;
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
    required this.isCompleted,
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
      isCompleted: json['isCompleted'],
      progress: json['progress'].toDouble(),
      arrowText: json['arrowText'],
      modules: List<Module>.from(json['modules'].map((x) => Module.fromJson(x))),
    );
  }
}

class Module {
  final int moduleId;
  final String title;
  final String imagePath;
  final int submoduleCount;
  final bool isStart;
  final double progressValue;
  final List<Submodule> submodules;

  Module({
    required this.moduleId,
    required this.title,
    required this.imagePath,
    required this.submoduleCount,
    required this.isStart,
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
      progressValue: json['progressValue'].toDouble(),
      submodules: List<Submodule>.from(json['submodules'].map((x) => Submodule.fromJson(x))),
    );
  }
}

class Submodule {
  final int submoduleId;
  final String title;
  final String description;
  final Map<String, double> buttonPosition;
  final String iconPath;
  final int numberOfQuizzes;
  final String titleAlignment;
  final List<Feature> features;

  Submodule({
    required this.submoduleId,
    required this.title,
    required this.description,
    required this.buttonPosition,
    required this.iconPath,
    required this.numberOfQuizzes,
    required this.titleAlignment,
    required this.features,
  });

  factory Submodule.fromJson(Map<String, dynamic> json) {
    return Submodule(
      submoduleId: json['submoduleId'],
      title: json['title'],
      description: json['description'],
      buttonPosition: Map<String, double>.from(json['buttonPosition']),
      iconPath: json['iconPath'],
      numberOfQuizzes: json['numberOfQuizzes'],
      titleAlignment: json['titleAlignment'],
      features: List<Feature>.from(json['features'].map((x) => Feature.fromJson(x))),
    );
  }
}

// Assuming the enum FeatureType is defined as shown previously
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
    this.isCompleted = false, // Default is not completed
    required this.duration,
    this.relatedData,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      title: json['title'],
      featureType: FeatureType.values.firstWhere(
            (e) => e.toString().split('.').last == json['featureType'],
        orElse: () => FeatureType.video, // Default to video if not found
      ),
      isCompleted: json['isCompleted'],
      duration: json['duration'],
      relatedData: json['relatedData'],
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
        default:
          return Icons.help; // Default icon
      }
    }
  }

  Color get iconColor {
    return isCompleted ? const Color(0xff9AC9C2) : const Color(0xff685F78); // Green for completed, purple for others
  }
}

Future<List<TestCourseModel>> fetchCourses() async {
  String jsonString = await rootBundle.loadString('assets/data/courses.json');
  final jsonData = json.decode(jsonString) as Map<String, dynamic>;
  return List<TestCourseModel>.from(jsonData['courses'].map((x) => TestCourseModel.fromJson(x)));
}


// Future<List<TestCourseModel>> fetchCourses() async {
//   String jsonString = await rootBundle.loadString('assets/data/courses.json');
//   final jsonData = json.decode(jsonString)['courses'] as List<dynamic>;
//   return jsonData.map((courseJson) => TestCourseModel(
//     courseId: courseJson['courseId'],
//     title: courseJson['title'],
//     gradientStart: courseJson['gradient']['start'],
//     gradientEnd: courseJson['gradient']['end'],
//     quizCount: courseJson['quizCount'],
//     moduleCount: courseJson['moduleCount'],
//     imagePath: courseJson['imagePath'],
//     isStart: courseJson['isStart'],
//     isCompleted: courseJson['isCompleted'],
//     progress: courseJson['progress'],
//     arrowText: courseJson['arrowText'],
//     modules: (courseJson['modules'] as List<dynamic>).map((moduleJson) {
//       return Module(
//         moduleId: moduleJson['moduleId'],
//         title: moduleJson['title'],
//         imagePath: moduleJson['imagePath'],
//         submoduleCount: moduleJson['submoduleCount'],
//         isStart: moduleJson['isStart'],
//         progressValue: moduleJson['progressValue'],
//         submodules: (moduleJson['submodules'] as List<dynamic>).map((submoduleJson) {
//           return Submodule(
//             submoduleId: submoduleJson['submoduleId'],
//             title: submoduleJson['title'],
//             description: submoduleJson['description'],
//             buttonPosition: Map<String, dynamic>.from(submoduleJson['buttonPosition']),
//             iconPath: submoduleJson['iconPath'],
//             numberOfQuizzes: submoduleJson['numberOfQuizzes'],
//             titleAlignment: submoduleJson['titleAlignment'],
//             features: (submoduleJson['features'] as List<dynamic>).map((featureJson) {
//               return Feature(
//                 title: featureJson['title'],
//                 featureType: featureJson['featureType'],
//                 isCompleted: featureJson['isCompleted'],
//                 duration: featureJson['duration'],
//                 relatedData: featureJson['relatedData'],
//               );
//             }).toList(),
//           );
//         }).toList(),
//       );
//     }).toList(),
//   )).toList();
// }
