class UserProgress {
  final int userId;
  final Map<int, CourseProgress> coursesProgress; // key: courseId, value: CourseProgress

  UserProgress({
    required this.userId,
    required this.coursesProgress,
  });

  void updateModuleProgress(int courseId, int moduleId, double progress) {
    coursesProgress[courseId]?.modulesProgress[moduleId]?.progress = progress;
  }

  void markModuleAsCompleted(int courseId, int moduleId) {
    coursesProgress[courseId]?.modulesProgress[moduleId]?.isCompleted = true;
  }

// Add methods as needed to update progress and completion status
}

class CourseProgress {
  bool isCompleted;
  double progress;
  final Map<int, ModuleProgress> modulesProgress; // key: moduleId, value: ModuleProgress

  CourseProgress({
    this.isCompleted = false,
    this.progress = 0.0,
    required this.modulesProgress,
  });
}

class ModuleProgress {
  bool isCompleted;
  double progress;
  // You can add submodule progress if needed

  ModuleProgress({
    this.isCompleted = false,
    this.progress = 0.0,
  });
}
