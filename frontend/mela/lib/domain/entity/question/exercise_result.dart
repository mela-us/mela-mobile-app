class ExerciseResult {
  final String message;
  final List<Answer> answers;

  ExerciseResult({
    required this.message,
    required this.answers,
  });

  factory ExerciseResult.fromJson(Map<String, dynamic> json) {
    return ExerciseResult(
      message: json['message'] as String,
      answers: (json['answers'] as List)
          .map((i) => Answer.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'answers': answers.map((e) => e.toJson()).toList(),
    };
  }
}

class Answer {
  final String questionId;
  final bool isCorrect;
  final String feedback;

  Answer({
    required this.questionId,
    required this.isCorrect,
    required this.feedback,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      questionId: json['questionId'] as String,
      isCorrect: json['isCorrect'] as bool,
      feedback: json['feedback'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'isCorrect': isCorrect,
      'feedback': feedback,
    };
  }
}
