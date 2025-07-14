import 'dart:convert'; // Import this for jsonDecode/jsonEncode

class ExamModel {
  final int total;
  final List<ExamQuestionModel> questions;

  ExamModel({
    required this.total,
    required this.questions,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      total: json['total'] as int,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => ExamQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }
}

class ExamQuestionModel {
  final String questionId;
  final int ordinalNumber;
  final String content;
  final String questionType;
  final List<QuizOptionModel> options;
  final String blankAnswer;
  final String solution;
  final dynamic terms; // Can be null, or a specific type if known
  final dynamic guide; // Can be null, or a specific type if known

  ExamQuestionModel({
    required this.questionId,
    required this.ordinalNumber,
    required this.content,
    required this.questionType,
    required this.options,
    required this.blankAnswer,
    required this.solution,
    this.terms,
    this.guide,
  });

  factory ExamQuestionModel.fromJson(Map<String, dynamic> json) {
    return ExamQuestionModel(
      questionId: json['questionId'] as String,
      ordinalNumber: json['ordinalNumber'] as int,
      content: json['content'] as String,
      questionType: json['questionType'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => QuizOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      blankAnswer: json['blankAnswer'] as String,
      solution: json['solution'] as String,
      terms: json['terms'], // Directly assign, let Dart handle null
      guide: json['guide'], // Directly assign, let Dart handle null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'ordinalNumber': ordinalNumber,
      'content': content,
      'questionType': questionType,
      'options': options.map((e) => e.toJson()).toList(),
      'blankAnswer': blankAnswer,
      'solution': solution,
      'terms': terms,
      'guide': guide,
    };
  }

  bool isCorrect(String userAnswer) {
    if (options.isEmpty) {
      if (userAnswer == blankAnswer) return true;
      return false;
    }
    //option not empty
    if (userAnswer.length == 1) {
      int answerOrd = charToNumber(userAnswer);
      if (options.elementAt(answerOrd - 1).isCorrect) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  int charToNumber(String char) {
    if (char.length == 1 &&
        char.codeUnitAt(0) >= 'A'.codeUnitAt(0) &&
        char.codeUnitAt(0) <= 'Z'.codeUnitAt(0)) {
      return char.codeUnitAt(0) - 'A'.codeUnitAt(0) + 1;
    } else {
      return 0;
    }
  }

  String numberToChar(int number) {
    if (number >= 1 && number <= 26) {
      return String.fromCharCode('A'.codeUnitAt(0) + number - 1);
    } else {
      return '';
    }
  }

  String correctQuizKey() {
    for (QuizOptionModel o in options) {
      if (o.isCorrect) {
        return numberToChar(o.ordinalNumber);
      }
    }
    return '';
  }
}

class QuizOptionModel {
  final int ordinalNumber;
  final String content;
  final bool isCorrect;

  QuizOptionModel({
    required this.ordinalNumber,
    required this.content,
    required this.isCorrect,
  });

  factory QuizOptionModel.fromJson(Map<String, dynamic> json) {
    return QuizOptionModel(
      ordinalNumber: json['ordinalNumber'] as int,
      content: json['content'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ordinalNumber': ordinalNumber,
      'content': content,
      'isCorrect': isCorrect,
    };
  }
}
