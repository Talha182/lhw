import 'package:lhw/entities/question.dart';
import 'package:lhw/dao/question_dao.dart';

Future<void> addSampleQuestions(QuestionDao questionDao) async {
  final question1 = Question(
    id: 1,
    questionText: 'آپ ڈیلیوری کے بعد کتنے دن میں ماں سے ملنے جاتے ہیں؟',
    option1: '1 دن',
    option2: '2 دن',
    option3: '3 دن',
    option4: '4 دن',
    correctAnswer: '4 دن',
    correctExplanation: 'صحیح جواب کی وضاحت',
    incorrectExplanation: 'غلط جواب کی وضاحت',
  );

  final question2 = Question(
    id: 2,
    questionText: 'آپ ڈیلیوری کے بعد کتنے دن بعد بھوک محسوس کرتے ہیں؟',
    option1: '1 دن',
    option2: '2 دن',
    option3: '3 دن',
    option4: '4 دن',
    correctAnswer: '3 دن',
    correctExplanation: 'صحیح جواب کی وض',
    incorrectExplanation: 'Nothing',);
}