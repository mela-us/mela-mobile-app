class SubmitResultParams {
  final String exerciseId;
  final List<AnswerParams> answers;
  final DateTime startAt;
  final DateTime endAt;

  // Constructor
  SubmitResultParams({
    required this.exerciseId,
    required this.answers,
    required this.startAt,
    required this.endAt,
  });

  // To JSON (optional if you need it)
  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'startedAt': startAt.toIso8601String(),
      'completedAt': endAt.toIso8601String(),
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}

class AnswerParams {
  String questionId;
  String blankAnswer;
  int? selectedOption;
  List<String>? imageUrls;
  AnswerParams({
    required this.questionId,
    required this.blankAnswer,
    required this.selectedOption,
    required this.imageUrls,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'blankAnswer': blankAnswer,
      'selectedOption': selectedOption,
      'images': imageUrls,
    };
  }
}
