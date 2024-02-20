import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:lhw/courses_test/test_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesProvider with ChangeNotifier {
  List<TestCourseModel> _courses = [];
  TestCourseModel? _lastVisitedCourse;
  bool _isLoading = true;

  List<TestCourseModel> get courses => _courses;
  TestCourseModel? get lastVisitedCourse => _lastVisitedCourse;
  bool get isLoading => _isLoading;

  CoursesProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await loadCourses();
    await _loadLastVisitedCourse();
    _isLoading = false;
    notifyListeners();
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

  Future<void> loadCourses() async {
    final String response =
        await rootBundle.loadString('assets/data/courses.json');
    final data = await json.decode(response);
    _courses = (data['courses'] as List)
        .map((i) => TestCourseModel.fromJson(i))
        .toList();
  }

  Future<void> _loadLastVisitedCourse() async {
    final prefs = await SharedPreferences.getInstance();
    final lastVisitedCourseId = prefs.getInt('lastVisitedCourseId');

    if (lastVisitedCourseId != null) {
      _lastVisitedCourse = _courses.firstWhere(
          (course) => course.courseId == lastVisitedCourseId,
          orElse: () => null!);
    } else {
      if (_courses.isNotEmpty) {
        _lastVisitedCourse = _courses.first;
        await prefs.setInt('lastVisitedCourseId', _courses.first.courseId);
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  void setLastVisitedCourse(TestCourseModel course) async {
    _lastVisitedCourse = course;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastVisitedCourseId', course.courseId);
    notifyListeners();
  }

  TestCourseModel? getCourseById(int courseId) {
    return _courses.firstWhereOrNull((course) => course.courseId == courseId);
  }

  void updateProgress() {
    _courses.forEach((course) {
      course.updateCourseCompletionProgress();
    });
    notifyListeners();
  }

  void updateCourseCompletionStatus() {
    _courses.forEach((course) {
      bool allFeaturesCompleted = course.modules.every((module) {
        return module.submodules.every((submodule) {
          return submodule.features.every((feature) => feature.isCompleted);
        });
      });
      course.isCompleted = allFeaturesCompleted;
    });
    notifyListeners();
  }



  // Method to check if a course is completed and mark it accordingly
  void checkAndUpdateCourseCompletion() {
    _courses.forEach((course) {
      if (course.isStart && !course.isCompleted) {
        bool allModulesCompleted =
            course.modules.every((module) => module.isCompleted);
        if (allModulesCompleted) {
          course.isCompleted = true;
        }
      }
    });
    notifyListeners();
  }
}
