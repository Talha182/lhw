import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/question_dao.dart';
import '../entities/question.dart';

part 'app_database.g.dart';  // the generated code will be there

@Database(version: 1, entities: [Question])
abstract class AppDatabase extends FloorDatabase {
  QuestionDao get questionDao;
}
