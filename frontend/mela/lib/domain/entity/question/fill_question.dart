import 'package:mela/domain/entity/question/question.dart';

class FillQuestion extends Question{

  FillQuestion({
    super.id,
    super.content,
    super.answer,
    super.imageUrl
  });

  @override
  List<String>? getChoiceList() {
    // TODO: implement getChoiceList
    return null;
  }

  @override
  factory FillQuestion.fromMap(Map<String, dynamic> json) => FillQuestion(
    id: json["id"],
    content: json["content"],
    answer: json["answer"],
    imageUrl: List<String>.from(json["body"]??[]),
  );

}