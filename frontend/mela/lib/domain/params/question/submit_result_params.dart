class SubmitResultParams{
  final String exerciseId;
  final int totalCorrectAnswers;
  final int totalAnswers;
  final DateTime startAt;
  final DateTime endAt;

  // Constructor
  SubmitResultParams({
    required this.exerciseId,
    required this.totalCorrectAnswers,
    required this.totalAnswers,
    required this.startAt,
    required this.endAt,
  });

  // To JSON (optional if you need it)
  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'totalCorrectAnswers': totalCorrectAnswers,
      'totalAnswers': totalAnswers,
      'startAt': startAt.toIso8601String(),
      'endAt': endAt.toIso8601String(),
    };
  }
}