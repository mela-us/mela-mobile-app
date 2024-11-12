import 'package:mela/domain/entity/question/question.dart';

class QuizQuestion extends Question{
  List<String>? choiceList;

  QuizQuestion({
    this.choiceList,
    super.id,
    super.content,
    super.answer,
    super.imageUrl
  });

  @override
  List<String>? getChoiceList() {
    // TODO: implement getChoiceList
    return choiceList;
    throw UnimplementedError();
  }

  @override
  factory QuizQuestion.fromMap(Map<String, dynamic> json) => QuizQuestion(
    id: json["id"],
    content: json["content"],
    answer: json["answer"],
    imageUrl: List<String>.from(json["body"]??[]),
    choiceList: List<String>.from(json["choices"]??[]),
  );
  
}