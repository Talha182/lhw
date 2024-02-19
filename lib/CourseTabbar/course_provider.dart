import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:lhw/courses_test/test_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesProvider with ChangeNotifier {
  List<TestCourseModel> _courses = [];
  TestCourseModel? _lastVisitedCourse;
  bool _isLoading = true; // Initially, data is loading.

  List<TestCourseModel> get courses => _courses;
  TestCourseModel? get lastVisitedCourse => _lastVisitedCourse;
  bool get isLoading => _isLoading;

  CoursesProvider() {
    _initialize(); // Initialize loading of courses and last visited course.
  }

  Future<void> _initialize() async {
    await loadCourses(); // Load courses data.
    await _loadLastVisitedCourse(); // Load last visited course.
    _isLoading = false; // Update loading state.
    notifyListeners(); // Notify listeners to rebuild UI if necessary.
  }

  TestCourseModel? getCourseById(int courseId) {
    return _courses.firstWhereOrNull((course) => course.courseId == courseId);
  }

  Module? getModuleById(int courseId, int moduleId) {
    var course = getCourseById(courseId);
    return course?.modules
        .firstWhereOrNull((module) => module.moduleId == moduleId);
  }

  Submodule? getSubmoduleById(int courseId, int moduleId, int submoduleId) {
    var module = getModuleById(courseId, moduleId);
    return module?.submodules
        .firstWhereOrNull((submodule) => submodule.submoduleId == submoduleId);
  }

  // Getter to get ongoing courses
  List<TestCourseModel> get ongoingCourses {
    return _courses
        .where((course) => course.isStart && !course.isCompleted)
        .toList();
  }

  // Getter to get completed courses
  List<TestCourseModel> get completedCourses {
    return _courses.where((course) => course.isCompleted).toList();
  }
  void markCourseAsCompleted(int courseId) {
    // Logic to mark a course as completed
    // This might involve finding the course by its ID and updating its isCompleted status
    notifyListeners(); // Notify widgets listening to the provider to rebuild with new data
  }
  void updateCourseCompletionStatus(int courseId, bool isCompleted) {
    var course = _courses.firstWhere((c) => c.courseId == courseId);
    course.isCompleted = isCompleted;
    notifyListeners();
  }

  Future<void> loadCourses() async {
    final String response =
        await rootBundle.loadString('assets/data/courses.json');
    final data = await json.decode(response);
    _courses = (data['courses'] as List)
        .map((i) => TestCourseModel.fromJson(i))
        .toList();
    // No need to call notifyListeners() here as _initialize will handle it.
  }

  void setLastVisitedCourse(TestCourseModel course) async {
    _lastVisitedCourse = course;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastVisitedCourseId', course.courseId);
  }

  Future<void> _loadLastVisitedCourse() async {
    final prefs = await SharedPreferences.getInstance();
    final lastVisitedCourseId = prefs.getInt('lastVisitedCourseId');

    if (lastVisitedCourseId != null) {
      _lastVisitedCourse = _courses.firstWhere(
        (course) => course.courseId == lastVisitedCourseId,
        orElse: () => null!,
      );
    } else {
      if (_courses.isNotEmpty) {
        _lastVisitedCourse = _courses.first;
        await prefs.setInt('lastVisitedCourseId', _courses.first.courseId);
      }
    }
    _isLoading = false;
    notifyListeners();
  }
}

