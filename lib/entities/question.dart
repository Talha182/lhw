import 'package:floor/floor.dart';

@Entity(tableName: 'questions')
class Question {
  @primaryKey
  final int id;

  final String questionText;

  final String option1;
  final String option2;
  final String option3;
  final String option4;

  final String correctAnswer;

  final String correctExplanation;
  final String incorrectExplanation;

  Question({
    required this.id,
    required this.questionText,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
  });
}
