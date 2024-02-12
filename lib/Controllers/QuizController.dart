import 'package:get/get.dart';

class ResultsController extends GetxController {
  // Observable list to hold questions and user answers
  var questionsAndAnswers = <Question>[].obs;

  // Method to add a question and user's answer to the list
  void addQuestionAnswer(Question question) {
    questionsAndAnswers.add(question);
  }

  // Calculate score or any other logic you need for the results
  int calculateScore() {
    int score = 0;
    for (var question in questionsAndAnswers) {
      if (question.userAnswer == question.correctAnswer) {
        score++;
      }
    }
    return score;
  }
}
