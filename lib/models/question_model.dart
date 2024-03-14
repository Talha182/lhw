class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final List<String> optionImages; // Add this line

  String userAnswer; // To store user's selected answer
  final String correctExplanation; // Correct explanation
  final String incorrectExplanation; // Incorrect explanation

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
    required this.optionImages, // Add this

    this.userAnswer = '', // Initialize with an empty string or as needed
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      optionImages: json['optionImages'] != null
          ? List<String>.from(json['optionImages'])
          : [
            "assets/images/quiz1.png",
            "assets/images/quiz2.png",
            "assets/images/quiz3.png",
      ], // If optionImages is null, assign an empty list
      correctAnswer: json['correctAnswer'],
      correctExplanation: json['correctExplanation'],
      incorrectExplanation: json['incorrectExplanation'],
      userAnswer: '',
    );
  }

}
