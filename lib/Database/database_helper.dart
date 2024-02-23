import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('courses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE courses (
  courseId $idType,
  title $textType,
  gradient TEXT NOT NULL,
  quizCount INTEGER NOT NULL,
  moduleCount INTEGER NOT NULL,
  imagePath TEXT NOT NULL,
  isStart INTEGER NOT NULL,
  isCompleted INTEGER NOT NULL,
  progress REAL NOT NULL,
  arrowText TEXT NOT NULL
)
''');


    await db.execute('''
CREATE TABLE modules (
  moduleId $idType,
  courseId INTEGER NOT NULL,
  moduleName $textType,
  FOREIGN KEY (courseId) REFERENCES courses(courseId) ON DELETE CASCADE
)
''');

    await db.execute('''
CREATE TABLE submodules (
  submoduleId $idType,
  moduleId INTEGER NOT NULL,
  submoduleName $textType,
  FOREIGN KEY (moduleId) REFERENCES modules(moduleId) ON DELETE CASCADE
)
''');

    await db.execute('''
CREATE TABLE features (
  featureId $idType,
  submoduleId INTEGER NOT NULL,
  featureName $textType,
  FOREIGN KEY (submoduleId) REFERENCES submodules(submoduleId) ON DELETE CASCADE
)
''');
  }

  // Methods to insert data into tables
  Future<int> addCourse(String title) async {
    final db = await instance.database;

    // Check if the course already exists
    final List<Map<String, dynamic>> existingCourse = await db.query(
      'courses',
      where: 'title = ?',
      whereArgs: [title],
    );

    if (existingCourse.isNotEmpty) {
      // Course already exists, return the existing course ID
      return existingCourse.first['courseId'] as int;
    } else {
      // Course doesn't exist, add it and return the new course ID
      return await db.insert('courses', {'title': title});
    }
  }
  Future<int> addModule(int courseId, String moduleName) async {
    final db = await instance.database;

    // Check if the module already exists for the given course
    final List<Map<String, dynamic>> existingModules = await db.query(
      'modules',
      where: 'courseId = ? AND moduleName = ?',
      whereArgs: [courseId, moduleName],
    );

    if (existingModules.isNotEmpty) {
      // Module already exists, return the existing module ID
      return existingModules.first['moduleId'] as int;
    } else {
      // Module doesn't exist, add it and return the new module ID
      return await db.insert('modules', {'courseId': courseId, 'moduleName': moduleName});
    }
  }

  Future<int> addSubmodule(int moduleId, String submoduleName) async {
    final db = await instance.database;

    // Check if the submodule already exists for the given module
    final List<Map<String, dynamic>> existingSubmodules = await db.query(
      'submodules',
      where: 'moduleId = ? AND submoduleName = ?',
      whereArgs: [moduleId, submoduleName],
    );

    if (existingSubmodules.isNotEmpty) {
      // Submodule already exists, return the existing submodule ID
      return existingSubmodules.first['submoduleId'] as int;
    } else {
      // Submodule doesn't exist, add it and return the new submodule ID
      return await db.insert('submodules', {'moduleId': moduleId, 'submoduleName': submoduleName});
    }
  }

  Future<int> addFeature(int submoduleId, String featureName) async {
    final db = await instance.database;

    // Check if the feature already exists for the given submodule
    final List<Map<String, dynamic>> existingFeatures = await db.query(
      'features',
      where: 'submoduleId = ? AND featureName = ?',
      whereArgs: [submoduleId, featureName],
    );

    if (existingFeatures.isNotEmpty) {
      // Feature already exists, return the existing feature ID
      return existingFeatures.first['featureId'] as int;
    } else {
      // Feature doesn't exist, add it and return the new feature ID
      return await db.insert('features', {'submoduleId': submoduleId, 'featureName': featureName});
    }
  }

  // Method to retrieve courses with their modules, submodules, and features
  // This is a basic example. You might need more complex queries to fetch nested data.
  Future<List<Map<String, dynamic>>> getCourseDetails(int courseId) async {
    final db = await instance.database;
    final modules = await db.query(
      'modules',
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
    return modules;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> setupDatabase() async {
    final dbHelper = DatabaseHelper.instance;

    // Step 1: Add a course
    final int courseId = await dbHelper.addCourse("Flutter Development");

    // Step 2: Add two modules to the course
    final int moduleId1 =
        await dbHelper.addModule(courseId, "Introduction to Flutter");
    final int moduleId2 =
        await dbHelper.addModule(courseId, "Advanced Flutter Concepts");

    // Step 3: Add three submodules to each module
    // For Module 1
    final int submoduleId1_1 =
        await dbHelper.addSubmodule(moduleId1, "Setting Up for Flutter");
    final int submoduleId1_2 =
        await dbHelper.addSubmodule(moduleId1, "Dart Basics");
    final int submoduleId1_3 =
        await dbHelper.addSubmodule(moduleId1, "Flutter Widgets 101");

    // For Module 2
    final int submoduleId2_1 =
        await dbHelper.addSubmodule(moduleId2, "State Management");
    final int submoduleId2_2 =
        await dbHelper.addSubmodule(moduleId2, "Animations in Flutter");
    final int submoduleId2_3 =
        await dbHelper.addSubmodule(moduleId2, "Networking & Persistence");

    // Step 4: Add one feature to each submodule
    // For Submodules in Module 1
    await dbHelper.addFeature(submoduleId1_1, "Installation Guides");
    await dbHelper.addFeature(
        submoduleId1_2, "Variables, Types, and Collections");
    await dbHelper.addFeature(
        submoduleId1_3, "Introduction to Layouts and Common Widgets");

    // For Submodules in Module 2
    await dbHelper.addFeature(submoduleId2_1, "Provider and Riverpod");
    await dbHelper.addFeature(submoduleId2_2, "Creating Custom Animations");
    await dbHelper.addFeature(
        submoduleId2_3, "Using HTTP and Storing Data Locally");
  }

  Future<List<Course>> getFullCourseDetails() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> courseMaps = await db.query('courses');

    List<Course> courses = [];
    for (var courseMap in courseMaps) {
      final List<Map<String, dynamic>> moduleMaps = await db.query(
        'modules',
        where: 'courseId = ?',
        whereArgs: [courseMap['courseId']],
      );

      List<Module> modules = [];
      for (var moduleMap in moduleMaps) {
        final List<Map<String, dynamic>> submoduleMaps = await db.query(
          'submodules',
          where: 'moduleId = ?',
          whereArgs: [moduleMap['moduleId']],
        );

        List<Submodule> submodules = [];
        for (var submoduleMap in submoduleMaps) {
          final List<Map<String, dynamic>> featureMaps = await db.query(
            'features',
            where: 'submoduleId = ?',
            whereArgs: [submoduleMap['submoduleId']],
          );

          List<Feature> features = featureMaps
              .map((m) => Feature(
                  featureId: m['featureId'], featureName: m['featureName']))
              .toList();
          submodules.add(Submodule(
              submoduleId: submoduleMap['submoduleId'],
              submoduleName: submoduleMap['submoduleName'],
              features: features));
        }

        modules.add(Module(
            moduleId: moduleMap['moduleId'],
            moduleName: moduleMap['moduleName'],
            submodules: submodules));
      }

      courses.add(Course(
          courseId: courseMap['courseId'],
          title: courseMap['title'],
          modules: modules));
    }

    return courses;
  }
}

class Course {
  final int courseId;
  final String title;
  final List<Module> modules;

  Course({required this.courseId, required this.title, required this.modules});
}

class Module {
  final int moduleId;
  final String moduleName;
  final List<Submodule> submodules;

  Module(
      {required this.moduleId,
      required this.moduleName,
      required this.submodules});
}

class Submodule {
  final int submoduleId;
  final String submoduleName;
  final List<Feature> features;

  Submodule(
      {required this.submoduleId,
      required this.submoduleName,
      required this.features});
}

class Feature {
  final int featureId;
  final String featureName;

  Feature({required this.featureId, required this.featureName});
}
