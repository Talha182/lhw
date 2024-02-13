    import 'presentation_question_model.dart';
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
