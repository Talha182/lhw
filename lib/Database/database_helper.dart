import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhw/courses_test/test_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert'; // For json encoding/decoding

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

import '../BranchingScenarios/ImageBranchingScenario.dart';
import '../BranchingScenarios/TextBranchingScenario.dart';
import '../ComicStrip/comic_strip.dart';
import '../Infographics/infographics.dart';
import '../InteractiveAnimationVideo/interactive_animation_video.dart';
import '../Presentation/presentation_model.dart';
import '../models/flash_cards_screen_model.dart';
import '../models/image_hotspot_model.dart';
import '../models/interactive_images_model.dart'; // For json encoding/decoding

class DatabaseHelper {
  static final _databaseName = "lhw_db.db";
  static final _databaseVersion = 1;
  static final coursesTable = 'courses_table';
  static final modulesTable = 'modules_table';
  static final submodulesTable = 'submodules_table';
  static final featuresTable = 'features_table';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $coursesTable (
        courseId INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        quizCount INTEGER NOT NULL,
        moduleCount INTEGER NOT NULL,
        imagePath TEXT NOT NULL,
        isStart INTEGER NOT NULL,
        isCompleted INTEGER NOT NULL,
        progress REAL NOT NULL,
        arrowText TEXT NOT NULL,
        gradient TEXT,
        modules TEXT
      )
      ''');

    await db.execute('''
      CREATE TABLE $modulesTable (
        moduleId INTEGER PRIMARY KEY,
        courseId INTEGER NOT NULL,
        title TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        submoduleCount INTEGER NOT NULL,
        isStart INTEGER NOT NULL,
        isCompleted INTEGER NOT NULL,
        progressValue REAL NOT NULL,
        subModules TEXT,
        
        FOREIGN KEY (courseId) REFERENCES $coursesTable(courseId)
      )
      ''');
    await db.execute('''
CREATE TABLE $submodulesTable (
  submoduleId INTEGER PRIMARY KEY,
  moduleId INTEGER NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  iconPath TEXT NOT NULL,
  numberOfQuizzes INTEGER NOT NULL,
  isCompleted INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY (moduleId) REFERENCES $modulesTable(moduleId)
)
''');
    await db.execute('''
CREATE TABLE $featuresTable (
  featureId INTEGER PRIMARY KEY,
  submoduleId INTEGER NOT NULL,
  title TEXT NOT NULL,
  featureType INTEGER NOT NULL,
  isCompleted INTEGER NOT NULL DEFAULT 0,
  duration TEXT NOT NULL,
  relatedData TEXT,
  FOREIGN KEY (submoduleId) REFERENCES $submodulesTable(submoduleId)
)
''');
  }

  Future<void> insertCourse(Course course) async {
    final db = await database;
    await db.insert(
      coursesTable,
      course.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertFeature(Feature feature) async {
    final db = await database;
    await db.insert(
      'featuresTable',
      feature.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Course>> courses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(coursesTable);

    return List.generate(maps.length, (i) {
      return Course.fromMap(maps[i]);
    });
  }
}
//
// class TestCourseModel {
//   final int courseId;
//   final String title;
//   final List<String> gradient;
//   final int quizCount;
//   final int moduleCount;
//   final String imagePath;
//   bool isStart;
//   bool isCompleted;
//   double progress;
//   final String arrowText;
//   final List<TestModuleModel> modules;
//
//   TestCourseModel({
//     required this.courseId,
//     required this.title,
//     required this.gradient,
//     required this.quizCount,
//     required this.moduleCount,
//     required this.imagePath,
//     this.isStart = false,
//     this.isCompleted = false,
//     this.progress = 0.0,
//     required this.arrowText,
//     required this.modules,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'courseId': courseId,
//       'title': title,
//       'quizCount': quizCount,
//       'moduleCount': moduleCount,
//       'imagePath': imagePath,
//       'isStart': isStart ? 1 : 0,
//       'isCompleted': isCompleted ? 1 : 0,
//       'progress': progress,
//       'arrowText': arrowText,
//       'gradient': jsonEncode(gradient),
//       'modules': jsonEncode(modules.map((module) => module.toMap()).toList()),
//     };
//   }
//
//   static TestCourseModel fromMap(Map<String, dynamic> map) {
//     return TestCourseModel(
//       courseId: map['courseId'],
//       title: map['title'],
//       quizCount: map['quizCount'],
//       moduleCount: map['moduleCount'],
//       imagePath: map['imagePath'],
//       isStart: map['isStart'] == 1,
//       isCompleted: map['isCompleted'] == 1,
//       progress: map['progress'],
//       arrowText: map['arrowText'],
//       gradient: (jsonDecode(map['gradient']) as List<dynamic>)
//           .map((color) => color.toString())
//           .toList(),
//       modules: (jsonDecode(map['modules']) as List<dynamic>)
//           .map((moduleJson) => TestModuleModel.fromMap(moduleJson))
//           .toList(),
//     );
//   }
// }
//
// class TestModuleModel {
//   final int moduleId;
//   final int courseId;
//   final String title;
//   final String imagePath;
//   final int submoduleCount;
//   bool isStart;
//   bool isCompleted;
//   double progressValue;
//   final List<Submodule> submodules; // Add list of submodules
//
//   TestModuleModel({
//     required this.moduleId,
//     required this.courseId,
//     required this.title,
//     required this.imagePath,
//     required this.submoduleCount,
//     this.isStart = false,
//     this.isCompleted = false,
//     this.progressValue = 0.0,
//     required this.submodules, // Initialize list of submodules
//   });
//   Map<String, dynamic> toMap() {
//     return {
//       'moduleId': moduleId,
//       'courseId': courseId,
//       'title': title,
//       'imagePath': imagePath,
//       'submoduleCount': submoduleCount,
//       'isStart': isStart ? 1 : 0,
//       'isCompleted': isCompleted ? 1 : 0,
//       'progressValue': progressValue,
//       'submodules':
//           jsonEncode(submodules.map((submodule) => submodule.toMap()).toList()),
//     };
//   }
//
//   static TestModuleModel fromMap(Map<String, dynamic> map) {
//     // This variable will hold the decoded submodules list
//     List<Submodule> decodedSubmodules = [];
//
//     // Check if 'submodules' is a string (encoded as JSON)
//     if (map['submodules'] is String) {
//       // If it's a string, decode it
//       List<dynamic> jsonList = jsonDecode(map['submodules']);
//       decodedSubmodules =
//           jsonList.map((json) => Submodule.fromMap(json)).toList();
//     } else if (map['submodules'] is List) {
//       // If it's already a List, use it directly
//       decodedSubmodules = (map['submodules'] as List)
//           .map((submoduleMap) => Submodule.fromMap(submoduleMap))
//           .toList();
//     } else {
//       print("Unexpected type for 'submodules', neither String nor List");
//     }
//
//     return TestModuleModel(
//       moduleId: map['moduleId'],
//       courseId: map['courseId'],
//       title: map['title'],
//       imagePath: map['imagePath'],
//       submoduleCount: map['submoduleCount'],
//       isStart: map['isStart'] == 1,
//       isCompleted: map['isCompleted'] == 1,
//       progressValue: map['progressValue'],
//       submodules: decodedSubmodules,
//     );
//   }
// }
//
// class Submodule {
//   final int submoduleId;
//   final int moduleId;
//   final String title;
//   final String description;
//   final String iconPath;
//   final int numberOfQuizzes;
//   bool isCompleted;
//   final List<Feature> features;
//
//   Submodule({
//     required this.submoduleId,
//     required this.moduleId,
//     required this.title,
//     required this.description,
//     required this.iconPath,
//     required this.numberOfQuizzes,
//     this.isCompleted = false,
//     required this.features,
//   });
//
//   Map<String, dynamic> toMap() {
//     // Convert features list to a JSON string before saving to the database
//     var featuresMap = features.map((feature) => feature.toMap()).toList();
//     return {
//       'submoduleId': submoduleId,
//       'moduleId': moduleId,
//       'title': title,
//       'description': description,
//       'iconPath': iconPath,
//       'numberOfQuizzes': numberOfQuizzes,
//       'isCompleted': isCompleted ? 1 : 0,
//       'features':
//           jsonEncode(featuresMap), // Encoding the features list to a string
//     };
//   }
//
//   static Submodule fromMap(Map<String, dynamic> map) {
//     // Handling the features either as a JSON-encoded string or as a direct list
//     List<Feature> decodedFeatures = [];
//     var featuresData = map['features'];
//     if (featuresData is String) {
//       // Decode if it's a string
//       List<dynamic> featuresList = jsonDecode(featuresData);
//       decodedFeatures = featuresList.map((f) => Feature.fromMap(f)).toList();
//     } else if (featuresData is List) {
//       // Directly use it if it's already a List
//       decodedFeatures = featuresData.map((f) => Feature.fromMap(f)).toList();
//     }
//
//     return Submodule(
//       submoduleId: map['submoduleId'],
//       moduleId: map['moduleId'],
//       title: map['title'],
//       description: map['description'],
//       iconPath: map['iconPath'],
//       numberOfQuizzes: map['numberOfQuizzes'],
//       isCompleted: map['isCompleted'] == 1,
//       features: decodedFeatures,
//     );
//   }
// }
//
// enum FeatureType {
//   video,
//   presentation,
//   quiz,
//   comicStrips,
//   flashCards,
//   infographics,
//   interactiveAnimationVideo,
//   interactiveImage,
//   imageHotspot,
//   textBranchingScenario,
//   imageBranchingScenario,
//   animationVideo,
//   unknown
// }
//
// class Feature {
//   final int featureId;
//   final String title;
//   final FeatureType featureType;
//   bool isCompleted;
//   final int submoduleId;
//   final String duration;
//   final dynamic relatedData; // Optional field to hold related data
//
//   Feature({
//     required this.featureId,
//     required this.title,
//     required this.featureType,
//     this.isCompleted = false,
//     required this.submoduleId,
//     required this.duration,
//     this.relatedData,
//   });
//
//   // Convert string to FeatureType enum
//   static FeatureType _featureTypeFromString(String typeString) {
//     return FeatureType.values.firstWhere(
//         (type) => type.toString().split('.').last == typeString,
//         orElse: () => FeatureType.video); // Default to video if not found
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'featureId': featureId,
//       'title': title,
//       'featureType':
//           featureType.toString().split('.').last, // Convert enum to string
//       'isCompleted': isCompleted ? 1 : 0,
//       'submoduleId': submoduleId,
//       'duration': duration,
//       'relatedData':
//           relatedData != null ? jsonEncode(relatedData) : jsonEncode({}),
//     };
//   }
//
//   static Feature fromMap(Map<String, dynamic> map) {
//     return Feature(
//       featureId: map['featureId'],
//       title: map['title'],
//       featureType: _featureTypeFromString(map['featureType']),
//       isCompleted: map['isCompleted'] == 1,
//       submoduleId: map['submoduleId'],
//       duration: map['duration'],
//       relatedData:
//           map['relatedData'] != null ? jsonDecode(map['relatedData']) : null,
//     );
//   }
//
//   factory Feature.fromJson(Map<String, dynamic> json) {
//     final int featureId = json['featureId'] as int? ?? 0;
//     final String title = json['title'] as String? ?? 'Unknown Feature';
//     final String duration =
//         json['duration'] as String? ?? '0min'; // Default value if null
//     final featureType = _parseFeatureType(json['featureType'] as String? ?? '');
//     var relatedData = json['relatedData'] != null
//         ? jsonDecode(json['relatedData'] as String)
//         : <String, dynamic>{}; // Safe parsing with default
//
//     if (featureType == FeatureType.presentation &&
//         json.containsKey('presentationModel')) {
//       relatedData = PresentationModel.fromJson(json['presentationModel']);
//     }
//     // Correction in Feature.fromJson for handling comic strips
//     if (json.containsKey('comicStrips')) {
//       List<dynamic> comicStripsJson = json['comicStrips'] as List;
//       relatedData = comicStripsJson
//           .map((csJson) =>
//               ComicStripModel.fromJson(csJson as Map<String, dynamic>))
//           .toList();
//     }
//
//     if (json.containsKey('flashCards')) {
//       List<dynamic> flashCardsJson = json['flashCards'] as List;
//       relatedData = flashCardsJson
//           .map((fcJson) => FlashCard.fromJson(fcJson as Map<String, dynamic>))
//           .toList();
//     }
//
//     if (featureType == FeatureType.infographics &&
//         json.containsKey('infographics')) {
//       var infographicsJson = json['infographics'] as List;
//       relatedData =
//           InfographicsModel.fromJson({'infographics': infographicsJson});
//     }
//
//     if (featureType == FeatureType.interactiveAnimationVideo &&
//         json.containsKey('videoPath')) {
//       relatedData = InteractiveAnimationVideoModel.fromJson(json);
//     }
//
//     if (featureType == FeatureType.interactiveImage &&
//         json.containsKey('interactiveImageModel')) {
//       List<dynamic> imagesInfoJson = json['interactiveImageModel'] as List;
//       relatedData = imagesInfoJson
//           .map((imageJson) => InteractiveImageModel.fromJson(imageJson))
//           .toList();
//     }
//     // Hotspot Image
//     if (featureType == FeatureType.imageHotspot &&
//         json.containsKey('imageHotspot')) {
//       relatedData = ImageHotspotModel.fromJson(json['imageHotspot']);
//     }
//     if (featureType == FeatureType.textBranchingScenario) {
//       relatedData = TextBranchingScenarioModel.fromJson(
//           json['textBranchingScenarioModel']);
//     }
//     if (featureType == FeatureType.imageBranchingScenario) {
//       relatedData = ImageBranchingScenarioModel.fromJson(
//           json['imageBranchingScenarioModel']);
//     }
//
//     return Feature(
//       title: title,
//       featureType: featureType, // Assuming this is parsed elsewhere
//       isCompleted: json['isCompleted'] == 1,
//       duration: duration,
//       submoduleId: json['submoduleId'] as int? ?? 0,
//       relatedData: relatedData, featureId: featureId,
//     );
//   }
//
//   IconData get icon {
//     if (isCompleted) {
//       return Icons.check_circle; // Green tick icon for completed features
//     } else {
//       switch (featureType) {
//         case FeatureType.video:
//           return Icons.play_arrow; // Example icon for video
//         case FeatureType.presentation:
//           return Icons.slideshow; // Example icon for presentation
//         case FeatureType.quiz:
//           return Icons.question_answer; // Example icon for quiz
//         case FeatureType.comicStrips:
//           return Icons.image; // Example icon for comic strips
//         case FeatureType.flashCards:
//           return Icons.flash_on; // Example icon for flash cards
//         case FeatureType.infographics:
//           return Icons.insert_chart; // Example icon for infographics
//         case FeatureType.interactiveAnimationVideo:
//           return Icons.videocam; // Example icon for interactive animation video
//         case FeatureType.interactiveImage:
//           return Icons.image_aspect_ratio; // Example icon for interactive image
//         case FeatureType.imageHotspot:
//           return Icons.image; // Example icon for hotspot image
//         case FeatureType.textBranchingScenario:
//           return Icons.text_fields; // Example icon for text branching scenario
//         case FeatureType.imageBranchingScenario:
//           return Icons.image; // Example icon for image branching scenario
//         default:
//           return Icons.help; // Default icon
//       }
//     }
//   }
//
//   Color get iconColor {
//     return isCompleted
//         ? const Color(0xff9AC9C2)
//         : const Color(0xff685F78); // Green for completed, purple for others
//   }
//
//   static FeatureType _parseFeatureType(String featureTypeStr) {
//     return FeatureType.values.firstWhere(
//       (e) => e.toString().split('.').last == featureTypeStr,
//       orElse: () => FeatureType.unknown,
//     );
//   }
// }

class DataManager {
  static Future<void> insertCoursesFromJson() async {
    final String response =
        await rootBundle.loadString('assets/data/test_data.json');
    final data = json.decode(response);
    final coursesList = data["courses"] as List;

    for (var courseJson in coursesList) {
      List<Module> modules = (courseJson['modules'] as List)
          .map((moduleJson) => Module.fromMap(moduleJson))
          .toList();
      Course course = Course(
        courseId: courseJson['courseId'],
        title: courseJson['title'],
        quizCount: courseJson['quizCount'],
        moduleCount: courseJson['moduleCount'],
        imagePath: courseJson['imagePath'],
        isStart: courseJson['isStart'] ?? false,
        isCompleted: courseJson['isCompleted'] ?? false,
        progress: courseJson['progress'] ?? 0.0,
        arrowText: courseJson['arrowText'],
        gradient:
            courseJson['gradient'].cast<String>(), // Add this lines
        modules: modules,
      );
      await DatabaseHelper.instance.insertCourse(course);
    }
  }
}
