import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import '../course_models/courses_models.dart';
import '../models/user_model.dart';

class DatabaseHelper extends ChangeNotifier {
  static const _databaseName = "lhw_db.db";
  static const _databaseVersion = 1;
  static const coursesTable = 'courses_table';
  static const modulesTable = 'modules_table';
  static const submodulesTable = 'submodules_table';
  static const featuresTable = 'features_table';
  static const usersTable = 'users_table';

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
  CREATE TABLE user_progress (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userId INTEGER NOT NULL,
    courseId INTEGER,
    moduleId INTEGER,
    featureId INTEGER,
    startTime TEXT,
    FOREIGN KEY (userId) REFERENCES $usersTable(id),
    FOREIGN KEY (courseId) REFERENCES $coursesTable(courseId),
    FOREIGN KEY (moduleId) REFERENCES $modulesTable(moduleId),
    FOREIGN KEY (featureId) REFERENCES $featuresTable(featureId)
  )
''');

    await db.execute('''
  CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    nic TEXT NOT NULL,
    id_no TEXT NOT NULL,
    dob TEXT NOT NULL,
    village TEXT NOT NULL,
    uc_name TEXT NOT NULL,
    years_experience INTEGER NOT NULL,
    email_verified_at TEXT,
    password TEXT NOT NULL,
    image TEXT NOT NULL,
    role_id INTEGER,
    status TEXT NOT NULL,
    remember_token TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
  )
''');

    await db.execute('''
      CREATE TABLE $usersTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT,
        nic TEXT,
        idNo TEXT,
        dob TEXT,
        village TEXT,
        ucName TEXT,
        yearsExperience INTEGER,
        password TEXT NOT NULL,
        image TEXT,
        status TEXT,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');
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

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to fetch a user by email
  Future<User?> loginUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      // Assuming email and password combination is unique and returns only one user
      return User.fromJson(maps.first);
    } else {
      // No user found
      return null;
    }
  }

  Future<User?> getUserByEmail(String email) async {
    final db =
        await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps
          .first);
    } else {
      return null; // No user found with the given email
    }
  }
  Future<void> updateUserProgress(int userId, int courseId, int moduleId, int featureId, String startTime) async {
    final db = await database;
    print('Updating user progress for userId: $userId, courseId: $courseId, moduleId: $moduleId, featureId: $featureId, startTime: $startTime');
    final existingProgress = await db.query(
      'user_progress',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    Map<String, dynamic> progressData = {
      'userId': userId,
      'courseId': courseId,
      'moduleId': moduleId,
      'featureId': featureId,
      'startTime': startTime,
    };

    if (existingProgress.isNotEmpty) {
      // Update existing progress
      await db.update(
        'user_progress',
        progressData,
        where: 'userId = ?',
        whereArgs: [userId],
      );
      print('User progress updated successfully for userId: $userId');
      print("Updated user progress: $progressData");
    } else {
      // Insert new progress
      await db.insert('user_progress', progressData);
      print("Inserted new user progress: $progressData");
    }
  }

  Future<Map<String, dynamic>?> fetchUserLastProgress(int userId) async {
    final db = await database;
    final result = await db.query(
      'user_progress',
      where: 'userId = ?',
      whereArgs: [userId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }


  Future<void> insertCourse(Course course) async {
    final db = await database;
    int courseId = await db.insert(
      coursesTable,
      course.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

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
      progressMap[result['moduleId'] as int] =
          result['progressValue'] as double;
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
  }


  Future<bool> toggleFeatureCompletion(int featureId) async {
    final db = await database;
    final feature = await db.query(
      featuresTable,
      where: 'featureId = ?',
      whereArgs: [featureId],
    );

    if (feature.isNotEmpty) {
      final isCompleted =
          feature.first['isCompleted'] == 1 ? 0 : 1;
      await db.update(
        featuresTable,
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
      return Course.fromMap(maps.first);
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

    double progress = 0;
    if (totalFeatures > 0) {
      progress = completedFeatures / totalFeatures;
    }

    await db.update(
      coursesTable,
      {'progress': progress},
      where: 'courseId = ?',
      whereArgs: [courseId],
    );

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

    // Compute the module progress
    double progress = 0;
    if (totalFeatures > 0) {
      progress = completedFeatures / totalFeatures;
    }

    await db.update(
      modulesTable,
      {'progressValue': progress},
      where: 'moduleId = ?',
      whereArgs: [moduleId],
    );

    notifyListeners();
  }
}
