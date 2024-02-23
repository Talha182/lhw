import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert'; // For json encoding/decoding

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert'; // For json encoding/decoding

class DatabaseHelper {
  static final _databaseName = "lhw_db.db";
  static final _databaseVersion = 1;
  static final coursesTable = 'courses_table';
  static final modulesTable = 'modules_table';
  static final submodulesTable = 'submodules_table';

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
  }

  Future<void> insertCourse(TestCourseModel course) async {
    final db = await database;
    await db.insert(
      coursesTable,
      course.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TestCourseModel>> courses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(coursesTable);

    return List.generate(maps.length, (i) {
      return TestCourseModel.fromMap(maps[i]);
    });
  }
}

class TestCourseModel {
  final int courseId;
  final String title;
  final int quizCount;
  final int moduleCount;
  final String imagePath;
  bool isStart;
  bool isCompleted;
  double progress;
  final String arrowText;
  final List<TestModuleModel> modules;

  TestCourseModel({
    required this.courseId,
    required this.title,
    required this.quizCount,
    required this.moduleCount,
    required this.imagePath,
    this.isStart = false,
    this.isCompleted = false,
    this.progress = 0.0,
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
      'modules': jsonEncode(modules.map((module) => module.toMap()).toList()),
    };
  }

  static TestCourseModel fromMap(Map<String, dynamic> map) {
    return TestCourseModel(
      courseId: map['courseId'],
      title: map['title'],
      quizCount: map['quizCount'],
      moduleCount: map['moduleCount'],
      imagePath: map['imagePath'],
      isStart: map['isStart'] == 1,
      isCompleted: map['isCompleted'] == 1,
      progress: map['progress'],
      arrowText: map['arrowText'],
      modules: (jsonDecode(map['modules']) as List<dynamic>)
          .map((moduleJson) => TestModuleModel.fromMap(moduleJson))
          .toList(),
    );
  }
}

class TestModuleModel {
  final int moduleId;
  final int courseId;
  final String title;
  final String imagePath;
  final int submoduleCount;
  bool isStart;
  bool isCompleted;
  double progressValue;
  final List<Submodule> submodules; // Add list of submodules

  TestModuleModel({
    required this.moduleId,
    required this.courseId,
    required this.title,
    required this.imagePath,
    required this.submoduleCount,
    this.isStart = false,
    this.isCompleted = false,
    this.progressValue = 0.0,
    required this.submodules, // Initialize list of submodules
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

  static TestModuleModel fromMap(Map<String, dynamic> map) {
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

    return TestModuleModel(
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
}

class Submodule {
  final int submoduleId;
  final int moduleId;
  final String title;
  final String description;
  final String iconPath;
  final int numberOfQuizzes;
  bool isCompleted;

  Submodule({
    required this.submoduleId,
    required this.moduleId,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.numberOfQuizzes,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'submoduleId': submoduleId,
      'moduleId': moduleId,
      'title': title,
      'description': description,
      'iconPath': iconPath,
      'numberOfQuizzes': numberOfQuizzes,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  static Submodule fromMap(Map<String, dynamic> map) {
    return Submodule(
      submoduleId: map['submoduleId'],
      moduleId: map['moduleId'],
      title: map['title'],
      description: map['description'],
      iconPath: map['iconPath'],
      numberOfQuizzes: map['numberOfQuizzes'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}

class DataManager {
  static Future<void> insertCoursesFromJson() async {
    final String response =
        await rootBundle.loadString('assets/data/test_data.json');
    final data = json.decode(response);
    final coursesList = data["courses"] as List;

    for (var courseJson in coursesList) {
      List<TestModuleModel> modules = (courseJson['modules'] as List)
          .map((moduleJson) => TestModuleModel.fromMap(moduleJson))
          .toList();
      TestCourseModel course = TestCourseModel(
        courseId: courseJson['courseId'],
        title: courseJson['title'],
        quizCount: courseJson['quizCount'],
        moduleCount: courseJson['moduleCount'],
        imagePath: courseJson['imagePath'],
        isStart: courseJson['isStart'] ?? false,
        isCompleted: courseJson['isCompleted'] ?? false,
        progress: courseJson['progress'] ?? 0.0,
        arrowText: courseJson['arrowText'],
        modules: modules,
      );
      await DatabaseHelper.instance.insertCourse(course);
    }
  }
}

class Feature {
  final int featureId;
  final String featureName;

  Feature({required this.featureId, required this.featureName});
}
