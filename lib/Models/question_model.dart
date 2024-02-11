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
}
