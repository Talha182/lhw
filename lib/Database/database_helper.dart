import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import '../course_models/courses_models.dart';

class DatabaseHelper extends ChangeNotifier {
  static const _databaseName = "lhw_db.db";
  static const _databaseVersion = 1;
  static const coursesTable = 'courses_table';
  static const modulesTable = 'modules_table';
  static const submodulesTable = 'submodules_table';
  static const featuresTable = 'features_table';

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
        features TEXT,
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
    int courseId = await db.insert(
      coursesTable,
      course.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Course inserted with ID: $courseId, Title: ${course.title}");

    for (Module module in course.modules) {
      await insertModule(module, courseId);
    }
  }

  Future<void> insertModule(Module module, int courseId) async {
    final db = await database;
    int moduleId = await db.insert(
      modulesTable,
      module.toMapWithCourseId(courseId),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Module inserted with ID: $moduleId, Title: ${module.title}");

    // Insert associated submodules
    for (Submodule submodule in module.submodules) {
      await insertSubmodule(submodule, moduleId);
    }
  }

  Future<List<Module>> fetchModulesByCourseId(int courseId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      modulesTable,
      where: 'courseId = ?',
      whereArgs: [courseId],
    );

    return List.generate(maps.length, (i) {
      return Module.fromMap(maps[i]);
    });
  }

  Future<void> insertSubmodule(Submodule submodule, int moduleId) async {
    final db = await database;
    int submoduleId = await db.insert(
      submodulesTable,
      submodule.toMapWithModuleId(moduleId), // Adjusted to use the new method
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(
        "Submodule inserted with ID: $submoduleId, Title: ${submodule.title}");

    // Insert associated features
    for (Feature feature in submodule.features) {
      await insertFeature(feature.copyWith(submoduleId: submoduleId));
    }
  }

  Future<List<Feature>> fetchFeatures(int submoduleId) async {
    final db = await database; // Get a reference to the database.
    final List<Map<String, dynamic>> maps = await db.query(
      featuresTable,
      where: 'submoduleId = ?',
      whereArgs: [submoduleId],
    );

    return List.generate(maps.length, (i) {
      return Feature.fromMap(maps[i]);
    });
  }

  Future<Map<int, double>> fetchAllModuleProgress(int courseId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      modulesTable,
      columns: ['moduleId', 'progressValue'],
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
    Map<int, double> progressMap = {};
    for (var result in results) {
      progressMap[result['moduleId'] as int] = result['progressValue'] as double;
    }
    return progressMap;
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
        'isCompleted': feature.isCompleted.value ? 1 : 0,
        'duration': feature.duration,
        'data': jsonEncode(feature.data), // Convert data to JSON string
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Feature inserted: ${feature.title}");
  }

  Future<void> printAllCourseData() async {
    final db = await database;

    // Fetch all courses
    List<Map<String, dynamic>> courseMaps = await db.query(coursesTable);
    for (var courseMap in courseMaps) {
      Course course = Course.fromMap(courseMap);
      print('Course: ${course.title}');

      // Fetch modules for this course
      List<Map<String, dynamic>> moduleMaps = await db.query(
        modulesTable,
        where: 'courseId = ?',
        whereArgs: [course.courseId],
      );
      for (var moduleMap in moduleMaps) {
        Module module = Module.fromMap(moduleMap);
        print('\tModule: ${module.title}');

        // Fetch submodules for this module
        List<Map<String, dynamic>> submoduleMaps = await db.query(
          submodulesTable,
          where: 'moduleId = ?',
          whereArgs: [module.moduleId],
        );
        for (var submoduleMap in submoduleMaps) {
          Submodule submodule = Submodule.fromMap(submoduleMap);
          print('\t\tSubmodule: ${submodule.title}');

          // Directly parse features from submodule's features column (JSON string)
          List<Feature> features =
              (jsonDecode(submoduleMap['features']) as List)
                  .map((f) => Feature.fromMap(f))
                  .toList();
          for (var feature in features) {
            print('\t\t\tFeature: ${feature.title}');
          }
        }
      }
    }
  }

  Future<bool> toggleFeatureCompletion(int featureId) async {
    final db = await database; // Assuming this gets your Database instance
    final feature = await db.query(
      featuresTable, // Use the actual name of your features table
      where: 'featureId = ?',
      whereArgs: [featureId],
    );

    if (feature.isNotEmpty) {
      final isCompleted = feature.first['isCompleted'] == 1 ? 0 : 1; // Toggle status
      await db.update(
        featuresTable, // Use the actual name of your features table
        {'isCompleted': isCompleted},
        where: 'featureId = ?',
        whereArgs: [featureId],
      );
      return true;
    }
    return false;
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


  Future<Module?> getModuleById(int moduleId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      modulesTable,
      where: "moduleId = ?",
      whereArgs: [moduleId],
    );

    if (maps.isNotEmpty) {
      // Assuming you have a fromMap method in Module class that creates an instance from a Map
      return Module.fromMap(maps.first);
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

  Future<List<Course>> fetchCourses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(coursesTable);
    print('Total courses found in the database: ${maps.length}');
    return List.generate(maps.length, (i) => Course.fromMap(maps[i]));
  }

  Future<void> markCourseAsCompleted(int courseId, int isCompleted) async {
    final db = await database;
    await db.update(
      coursesTable,
      {'isCompleted': isCompleted},
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
  }

  Future<void> markFeatureAsCompleted(int featureId) async {
    final db = await database;
    await db.update(
      featuresTable,
      {'isCompleted': 1},
      where: 'featureId = ?',
      whereArgs: [featureId],
    );
    notifyListeners();
  }

  Future<void> calculateAndUpdateCourseProgress(int courseId) async {
    final db = await database;

    // Fetch all modules of the course
    final List<Map<String, dynamic>> moduleMaps = await db.query(
      modulesTable,
      where: 'courseId = ?',
      whereArgs: [courseId],
    );

    int totalFeatures = 0;
    int completedFeatures = 0;

    // Iterate over all modules to calculate total and completed features
    for (var moduleMap in moduleMaps) {
      int moduleId = moduleMap['moduleId'];

      // Fetch all submodules of the module
      final List<Map<String, dynamic>> submoduleMaps = await db.query(
        submodulesTable,
        where: 'moduleId = ?',
        whereArgs: [moduleId],
      );

      // Iterate over all submodules to count features
      for (var submoduleMap in submoduleMaps) {
        int submoduleId = submoduleMap['submoduleId'];
        final List<Map<String, dynamic>> featureMaps = await db.query(
          featuresTable,
          where: 'submoduleId = ?',
          whereArgs: [submoduleId],
        );

        totalFeatures += featureMaps.length;
        completedFeatures +=
            featureMaps.where((map) => map['isCompleted'] == 1).length;
      }
    }

    // Compute the course progress
    double progress = 0;
    if (totalFeatures > 0) {
      progress = completedFeatures / totalFeatures;
    }

    // Update the course progress in the database
    await db.update(
      coursesTable,
      {'progress': progress},
      where: 'courseId = ?',
      whereArgs: [courseId],
    );

    print("Course progress updated: $progress");
    print("Total features: $totalFeatures");
    print("Completed features: $completedFeatures");
    notifyListeners();
  }

  Future<void> calculateAndUpdateModuleProgress(int moduleId) async {
    final db = await database;

    // Fetch all submodules of the module
    final List<Map<String, dynamic>> submoduleMaps = await db.query(
      submodulesTable,
      where: 'moduleId = ?',
      whereArgs: [moduleId],
    );

    int totalFeatures = 0;
    int completedFeatures = 0;

    // Iterate over all submodules to count features
    for (var submoduleMap in submoduleMaps) {
      int submoduleId = submoduleMap['submoduleId'];
      final List<Map<String, dynamic>> featureMaps = await db.query(
        featuresTable,
        where: 'submoduleId = ?',
        whereArgs: [submoduleId],
      );

      totalFeatures += featureMaps.length;
      completedFeatures += featureMaps.where((map) => map['isCompleted'] == 1).length;
    }

    // Compute the module progress
    double progress = 0;
    if (totalFeatures > 0) {
      progress = completedFeatures / totalFeatures;
    }

    // Update the module progress in the database
    await db.update(
      modulesTable,
      {'progressValue': progress},
      where: 'moduleId = ?',
      whereArgs: [moduleId],
    );

    print("Module progress updated: $progress for moduleId: $moduleId");
    print("Total features in module: $totalFeatures");
    print("Completed features in module: $completedFeatures");
    notifyListeners();
  }
}

