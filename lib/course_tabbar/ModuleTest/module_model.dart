import 'dart:ui';

class Module {
  final int moduleId;
  final String title;
  final String imagePath;
  final int submoduleCount;
  final bool isStart;
  final double progressValue;
  final VoidCallback onTap;

  Module({
    required this.moduleId,
    required this.title,
    required this.imagePath,
    required this.submoduleCount,
    this.isStart = false,
    this.progressValue = 0.0,
    required this.onTap,
  });
}
