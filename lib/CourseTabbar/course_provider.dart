import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:lhw/courses_test/test_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Database/database_helper.dart';

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
    if (lastVisitedCourseId != null) {
      _lastVisitedCourse = await DatabaseHelper.instance.getCourseById(lastVisitedCourseId);
    }
    notifyListeners();
  }

  void setLastVisitedCourse(Course course) async {
    _lastVisitedCourse = course;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastVisitedCourseId', course.courseId);
    notifyListeners();
  }

  Future<void> updateCourseCompletionStatus(int courseId, bool isCompleted) async {
    await DatabaseHelper.instance.markCourseAsCompleted(courseId, isCompleted ? 1 : 0);
    await loadCoursesFromDatabase(); // Refresh courses from the database
  }

  List<Course> get ongoingCourses => _courses.where((course) => !course.isCompleted && course.isStart).toList();
  List<Course> get completedCourses => _courses.where((course) => course.isCompleted).toList();

  Future<void> checkAndUpdateCourseCompletion() async {
    // This method needs to be adapted based on your database schema and how you track module/submodule completion.
    // The following is a pseudo-implementation assuming each course's completion can be directly determined.

    for (var course in _courses) {
      // Let's assume a direct query to the database can update the completion status
      // This would ideally be replaced with actual logic to check module/submodule completion
      if (!course.isCompleted && course.isStart) {
        // Dummy condition, replace with actual check
        bool isCompleted = course.progress >= 1.0; // Assuming 100% progress means completion
        if (isCompleted) {
          await updateCourseCompletionStatus(course.courseId, true);
        }
      }
    }
  }
}