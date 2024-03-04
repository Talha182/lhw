import 'dart:convert';

import 'package:flutter/services.dart';

import '../course_models/courses_models.dart';
import '../models/user_model.dart';
import 'database_helper.dart';

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

  static Future<void> insertUsersFromJson() async {
    final String response = await rootBundle.loadString('assets/data/usersData.json');
    final data = json.decode(response);
    final usersList = data["usersData"] as List;

    for (var userJson in usersList) {
      User user = User.fromJson(userJson);
      await DatabaseHelper.instance.insertUser(user);
      print('Inserted user: ${user.name}');
    }
  }

}
