import 'option.dart';

class Question{
  final String? questionId;
  final int ordinalNumber;
  final String content;
  final String questionType;
  final List<Option> options;
  final String blankAnswer;
  final String guide;



  Question({
    required this.questionId,
    required this.ordinalNumber,
    required this.content,
    required this.questionType,
    required this.options,
    required this.blankAnswer,
    required this.guide,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['questionId'],
      ordinalNumber: json['ordinalNumber'] ?? 0,
      content: json['content'] ?? "",
      questionType: json['questionType'] ?? "",
      options: (json['options'] as List<dynamic>)
          .map((o) => Option.fromJson(o))
          .toList(),
      blankAnswer: json['blankAnswer'],
      guide: json['guide'],
    );
  }

  bool isCorrect(String userAnswer){
    if (options.isEmpty) {
      if (userAnswer == blankAnswer) return true;
      return false;
    }
    //option not empty
    if (userAnswer.length == 1) {
      int answerOrd = charToNumber(userAnswer);
      print ("answer Ord: $answerOrd");
      if (options.elementAt(answerOrd-1).isCorrect) {
        return true;
      }
      else {
        return false;
      }
    }
    return false;
  }

  int charToNumber(String char) {
    if (char.length == 1 && char.codeUnitAt(0) >= 'A'.codeUnitAt(0) &&
        char.codeUnitAt(0) <= 'Z'.codeUnitAt(0)) {
      return char.codeUnitAt(0) - 'A'.codeUnitAt(0) + 1;
    } else {
      return 0;
    }
  }

  String numberToChar(int number) {
    // Đảm bảo số đầu vào nằm trong khoảng từ 1 đến 26
    if (number >= 1 && number <= 26) {
      return String.fromCharCode('A'.codeUnitAt(0) + number - 1);
    } else {
      return '';
    }
  }


  String correctQuizKey(){
    for (Option o in options){
      if (o.isCorrect) {
        return numberToChar(o.ordinalNumber);
      }
    }
    return '';
  }
}

