class ExerciseAnswer {
  final String questionId;
  final bool isCorrect;
  final String? blankAnswer;
  final int? selectedOption;

  ExerciseAnswer({
    required this.questionId,
    required this.isCorrect,
    this.blankAnswer,
    this.selectedOption,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'isCorrect': isCorrect,
      'blankAnswer': blankAnswer,
      'selectedOption': selectedOption,
    };
  }
}

class ExerciseProgressParams {
  final String exerciseId;
  final DateTime startedAt;
  final DateTime completedAt;
  final List<ExerciseAnswer> answers;

  ExerciseProgressParams({
    required this.exerciseId,
    required this.startedAt,
    required this.completedAt,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'startedAt': startedAt.toIso8601String(),
      'completedAt': completedAt.toIso8601String(),
      'answers': answers.map((a) => a.toJson()).toList(),
    };
  }
}
