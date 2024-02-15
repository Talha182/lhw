    class PresentationModel {
      final List<String> assetImages;
      final List<Question> questions;
      final List<bool> showQuestionDialog;

      PresentationModel({
        required this.assetImages,
        required this.questions,
        required this.showQuestionDialog,
      });

      factory PresentationModel.fromJson(Map<String, dynamic> json) {
        return PresentationModel(
          assetImages: List<String>.from(json['assetImages']),
          questions: List<Question>.from(json['questions'].map((x) => Question.fromJson(x))),
          showQuestionDialog: List<bool>.from(json['showQuestionDialog']),
        );
      }
    }
    class Question {
      final String question;
      final List<String> options;
      final String correctAnswer;
      final String correctExplanation; // Correct explanation
      final String incorrectExplanation; // Incorrect explanation

      Question({
        required this.question,
        required this.options,
        required this.correctAnswer,
        required this.correctExplanation,
        required this.incorrectExplanation,
      });

      factory Question.fromJson(Map<String, dynamic> json) {
        return Question(
          question: json['question'],
          options: List<String>.from(json['options']),
          correctAnswer: json['correctAnswer'],
          correctExplanation: json['correctExplanation'],
          incorrectExplanation: json['incorrectExplanation'],
        );
      }
    }
