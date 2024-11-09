import 'package:mela/models/QuestionFamily/AQuestion.dart';

class FitbQuestion extends AQuestion{
  FitbQuestion({
    required super.id,
    required super.questionContent,
    required super.answer,
    required super.imageUrl});

  @override
  bool isCorrect(String userAnswer) {
    if (userAnswer.toLowerCase() == answer.toLowerCase()){
      return true;
    }
    return false;
    // TODO: implement isCorrect
    throw UnimplementedError();
  }

  @override
  int choiceSize() {
    return 0;
  }

  @override
  List<String>? getChoiceList() {
    return null;
  }
}