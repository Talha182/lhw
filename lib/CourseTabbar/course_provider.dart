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

  // New method to mark a module or submodule as completed
  void markModuleOrSubmoduleAsCompleted(int courseId, int moduleId,
      {int? submoduleId}) {
    var course = getCourseById(courseId);
    if (course != null) {
      var module =
          course.modules.firstWhereOrNull((m) => m.moduleId == moduleId);
      if (module != null) {
        if (submoduleId != null) {
          var submodule = module.submodules
              .firstWhereOrNull((s) => s.submoduleId == submoduleId);
          if (submodule != null) {
            submodule.isCompleted = true;
          }
        } else {
          module.isCompleted = true;
        }
        updateCoursesProgress(
            course); // Call this method to update the course's overall progress
      }
    }
    notifyListeners();
  }

  void updateModuleProgress(int courseId, int moduleId, double progress) {
    TestCourseModel? course =
        _courses.firstWhereOrNull((c) => c.courseId == courseId);
    Module? module =
        course?.modules.firstWhereOrNull((m) => m.moduleId == moduleId);
    if (module != null) {
      module.progressValue = progress; // Update progress here
      notifyListeners(); // Notify all listeners of change
    }
  }

  // Method to update the course's overall progress based on modules/submodules completion
  void updateCoursesProgress(TestCourseModel course) {
    int completedModules = course.modules.where((m) => m.isCompleted).length;
    if (completedModules == course.modules.length) {
      course.isCompleted = true;
    } else {
      course.isCompleted = false;
    }
    notifyListeners();
  }

  TestCourseModel? getCourseById(int courseId) {
    return _courses.firstWhereOrNull((course) => course.courseId == courseId);
  }

  void updateProgressValue(int courseId, int moduleId, double progress,
      {int? submoduleId}) {
    // Find the course by ID
    TestCourseModel? course =
        _courses.firstWhereOrNull((c) => c.courseId == courseId);
    if (course != null) {
      // Find the module by ID within the course
      Module? module =
          course.modules.firstWhereOrNull((m) => m.moduleId == moduleId);
      if (module != null) {
        // If a submodule ID is provided, update the submodule's progress
        if (submoduleId != null) {
          Submodule? submodule = module.submodules
              .firstWhereOrNull((s) => s.submoduleId == submoduleId);
        } else {
          // If no submodule ID is provided, update the module's progress
          module.progressValue = progress;
        }
        notifyListeners(); // Notify all listeners of the change
      }
    }
  }

// Additional getters and methods as needed...
}
