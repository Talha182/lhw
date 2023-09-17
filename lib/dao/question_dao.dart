import 'package:floor/floor.dart';
import 'package:lhw/entities/question.dart';
@dao
abstract class QuestionDao {
  @Query('SELECT * FROM questions')
  Future<List<Question>> findAllQuestions();


  @insert
  Future<void> insertQuestion(Question question);
}
