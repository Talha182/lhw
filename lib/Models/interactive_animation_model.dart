import '../Branching/LessonOption24.dart';

class InteractiveAnimationVideoModel {
  final String videoPath;
  final List<Question> questions;
  final List<Duration> questionDurations;

  InteractiveAnimationVideoModel(
      {required this.videoPath,
        required this.questions,
        required this.questionDurations});
}
