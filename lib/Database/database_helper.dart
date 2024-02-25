import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhw/courses_test/test_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert'; // For json encoding/decoding

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
    print("Initializing database...");
    String path = join(await getDatabasesPath(), _databaseName);
    print("Database path: $path");
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
  data TEXT,
  FOREIGN KEY (submoduleId) REFERENCES $submodulesTable(submoduleId)
)
''');
  }

  Future<void> insertCourse(Course course) async {
    final db = await database;
    int id = await db.insert(
      coursesTable,
      course.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Course inserted with ID: $id, Title: ${course.title}");
  }

  Future<void> insertFeature(Feature feature) async {
    final db = await database;
    await db.insert(
      featuresTable,
      {
        'featureId': feature.featureId,
        'submoduleId': feature.submoduleId,
        'title': feature.title,
        'featureType': feature.featureType.toString().split('.').last,
        'isCompleted': feature.isCompleted ? 1 : 0,
        'duration': feature.duration,
        'data': jsonEncode(feature.data), // Convert data to JSON string
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Feature inserted: ${feature.title}");
  }

  Future<Course?> getCourseById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      coursesTable,
      where: "courseId = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Course.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Course?> fetchCourseById(int courseId) async {
    final db = await database;
    final maps = await db.query(
      'coursesTable',
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
    if (maps.isNotEmpty) {
      return Course.fromMap(maps.first); // Assuming a fromMap constructor
    }
    return null;
  }

  Future<List<Course>> courses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(coursesTable);

    return List.generate(maps.length, (i) {
      return Course.fromMap(maps[i]);
    });
  }

  // Fetch all courses from the database
  Future<List<Course>> fetchCourses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(coursesTable);
    print('Total courses found in the database: ${maps.length}');
    return List.generate(maps.length, (i) => Course.fromMap(maps[i]));
  }

  // Mark a course as completed in the database
  Future<void> markCourseAsCompleted(int courseId, int isCompleted) async {
    final db = await database;
    await db.update(
      coursesTable,
      {'isCompleted': isCompleted},
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
  }
}

class DataManager {
  static Future<void> insertCoursesFromJson() async {
    final String response =
        await rootBundle.loadString('assets/data/courses.json');
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
        gradient: courseJson['gradient'].cast<String>(), // Add this lines
        modules: modules,
      );
      await DatabaseHelper.instance.insertCourse(course);
      print('Inserted course: ${course.title}');
    }
  }
}
