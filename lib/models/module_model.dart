import 'dart:ui';

import 'package:lhw/models/submodule_model.dart';


class Module {
  final int moduleId;
  final String title;
  final String imagePath;
  final int submoduleCount;
  final bool isStart;
  final double progressValue;
  final List<Submodule> submodules;


  Module({
    required this.moduleId,
    required this.title,
    required this.imagePath,
    required this.submoduleCount,
    this.isStart = false,
    this.progressValue = 0.0,
    required this.submodules,

  });
}



