  import 'presentation_question_model.dart';
  class PresentationModel {
    final List<String> assetImages;
    final List<Question> questions;
    final List<bool> showQuestionDialog; // New list to indicate whether to show dialog

    PresentationModel({
      required this.assetImages,
      required this.questions,
      required this.showQuestionDialog, // Ensure this is included in constructor
    });
  }
