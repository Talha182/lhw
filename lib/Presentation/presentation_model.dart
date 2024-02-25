class PresentationModel {
  final List<String> assetImages;
  final List<PresentationQuestion> questions;
  final List<bool> showQuestionDialog;

  PresentationModel({
    required this.assetImages,
    required this.questions,
    required this.showQuestionDialog,
  });

  factory PresentationModel.fromJson(Map<String, dynamic> json) {
    List<String> assetImages = List<String>.from(json['assetImages']);
    List<PresentationQuestion> questions = (json['questions'] as List)
        .map((questionJson) =>
            PresentationQuestion.fromJson(questionJson as Map<String, dynamic>))
        .toList();
    List<bool> showQuestionDialog = List<bool>.from(json['showQuestionDialog']);

    return PresentationModel(
      assetImages: assetImages,
      questions: questions,
      showQuestionDialog: showQuestionDialog,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'presentationData': {
        'assetImages': assetImages,
        'questions': questions.map((e) => e.toJson()).toList(),
        'showQuestionDialog': showQuestionDialog,
      }
    };
  }

  factory PresentationModel.fromMap(Map<String, dynamic> map) {
    return PresentationModel(
      assetImages: List<String>.from(map['presentationData']['assetImages']),
      questions: (map['presentationData']['questions'] as List)
          .map((e) => PresentationQuestion.fromMap(e))
          .toList(),
      showQuestionDialog:
          List<bool>.from(map['presentationData']['showQuestionDialog']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'presentationData': {
        'assetImages': assetImages,
        'questions': questions.map((e) => e.toMap()).toList(),
        'showQuestionDialog': showQuestionDialog,
      }
    };
  }
}

class PresentationQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String correctExplanation;
  final String incorrectExplanation;

  PresentationQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
  });

  factory PresentationQuestion.fromJson(Map<String, dynamic> json) {
    return PresentationQuestion(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      correctExplanation: json['correctExplanation'],
      incorrectExplanation: json['incorrectExplanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'correctExplanation': correctExplanation,
      'incorrectExplanation': incorrectExplanation,
    };
  }

  factory PresentationQuestion.fromMap(Map<String, dynamic> map) {
    return PresentationQuestion(
      question: map['question'],
      options: List<String>.from(map['options']),
      correctAnswer: map['correctAnswer'],
      correctExplanation: map['correctExplanation'],
      incorrectExplanation: map['incorrectExplanation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'correctExplanation': correctExplanation,
      'incorrectExplanation': incorrectExplanation,
    };
  }
}
