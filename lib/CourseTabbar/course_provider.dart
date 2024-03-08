import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Database/database_helper.dart';
import '../course_models/courses_models.dart';

class CoursesProvider with ChangeNotifier {
  List<Course> _courses = [];
  Course? _lastVisitedCourse;
  bool _isLoading = true;

  List<Course> get courses => _courses;
  Course? get lastVisitedCourse => _lastVisitedCourse;
  bool get isLoading => _isLoading;

  CoursesProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await loadCoursesFromDatabase();
    await _loadLastVisitedCourse();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadCoursesFromDatabase() async {
    _courses = await DatabaseHelper.instance.fetchCourses();
    notifyListeners();
  }

  Future<void> _loadLastVisitedCourse() async {
    final prefs = await SharedPreferences.getInstance();
    final lastVisitedCourseId = prefs.getInt('lastVisitedCourseId');

    // Attempt to load the last visited course from the stored ID
    if (lastVisitedCourseId != null) {
      _lastVisitedCourse =
          await DatabaseHelper.instance.getCourseById(lastVisitedCourseId);
    }

    // If no last visited course is found and there are courses available, set the first course as the last visited one.
    if (_lastVisitedCourse == null && _courses.isNotEmpty) {
      _lastVisitedCourse = _courses.first;
      // Optionally, save this as the new last visited course
      await prefs.setInt('lastVisitedCourseId', _lastVisitedCourse!.courseId);
    }
    notifyListeners();
  }

  void setLastVisitedCourse(Course course) async {
    _lastVisitedCourse = course;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastVisitedCourseId', course.courseId);
    notifyListeners();
  }

  List<Course> get ongoingCourses => _courses
      .where((course) => !course.isCompleted && course.isStart)
      .toList();
  List<Course> get completedCourses =>
      _courses.where((course) => course.isCompleted).toList();

  Course? findCourseById(int courseId) {
    try {
      return _courses.firstWhere((course) => course.courseId == courseId);
    } catch (e) {
      return null; // If no course matches the ID, return null
    }
  }

  Module? findModuleById(int moduleId) {
    for (var course in _courses) {
      for (var module in course.modules) {
        if (module.moduleId == moduleId) {
          return module;
        }
      }
    }
    return null; // Return null if the module isn't found
  }

  Future<void> updateCourseData(int courseId) async {
    Course? updatedCourse =
        await DatabaseHelper.instance.getCourseById(courseId);
    if (updatedCourse != null) {
      int index = _courses.indexWhere((course) => course.courseId == courseId);
      if (index != -1) {
        _courses[index] = updatedCourse;
        notifyListeners(); // This will trigger UI components to rebuild with the updated data
      }
    }
  }

  Future<void> updateCourseProgress(int courseId) async {
    await DatabaseHelper.instance.calculateAndUpdateCourseProgress(courseId);
    await loadCoursesFromDatabase(); // Re-fetch all courses to get the updated progress
    notifyListeners(); // Notify all listeners to rebuild their UI with updated data
  }

  void updateYourModuleListWith(Module updatedModule) {
    int index = _courses.indexWhere((course) => course.modules
        .any((module) => module.moduleId == updatedModule.moduleId));
    if (index != -1) {
      int moduleIndex = _courses[index]
          .modules
          .indexWhere((mod) => mod.moduleId == updatedModule.moduleId);
      if (moduleIndex != -1) {
        _courses[index].modules[moduleIndex] = updatedModule;
      }
    }
  }

  Future<void> updateModuleProgress(int moduleId) async {
    // Step 1: Update progress in the database
    await DatabaseHelper.instance.calculateAndUpdateModuleProgress(moduleId);

    // Step 2: Fetch the updated module data
    Module? updatedModule =
        await DatabaseHelper.instance.getModuleById(moduleId);

    // Step 3: Update the provider's state with the updated module
    if (updatedModule != null) {
      int index = _courses.indexWhere((course) => course.modules
          .any((module) => module.moduleId == updatedModule.moduleId));
      if (index != -1) {
        int moduleIndex = _courses[index]
            .modules
            .indexWhere((mod) => mod.moduleId == updatedModule.moduleId);
        if (moduleIndex != -1) {
          _courses[index].modules[moduleIndex] = updatedModule;
        }
      }
      notifyListeners();
    }
  }



  Future<void> markFeatureAsCompletedAndUpdateProgress(
      int courseId, int moduleId, int featureId) async {
    await DatabaseHelper.instance.markFeatureAsCompleted(featureId);
    await updateModuleProgress(moduleId);
    await updateCourseProgress(courseId);
    await updateCourseData(courseId);
    notifyListeners();
  }

  Future<void> fetchFeatures(int submoduleId) async {
    await DatabaseHelper.instance.fetchFeatures(submoduleId);
    notifyListeners();
  }

  Map<int, double> _moduleProgress = {};

  Future<void> fetchAllModulesProgress(int courseId) async {
    _moduleProgress =
        await DatabaseHelper.instance.fetchAllModuleProgress(courseId);
    notifyListeners();
  }

  double getModuleProgress(int moduleId) {
    return _moduleProgress[moduleId] ?? 0.0;
  }
}
