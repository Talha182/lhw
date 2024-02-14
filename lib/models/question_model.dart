class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;
  String userAnswer; // To store user's selected answer
  final String correctExplanation; // Correct explanation
  final String incorrectExplanation; // Incorrect explanation

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
    this.userAnswer = '', // Initialize with an empty string or as needed
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'],
      correctExplanation: json['correctExplanation'],
      incorrectExplanation: json['incorrectExplanation'],
      userAnswer: '', // Optionally, initialize userAnswer if needed
    );
  }
}
