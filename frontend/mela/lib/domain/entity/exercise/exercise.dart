class Exercise {
  String exerciseId;
  String exerciseName;
  String lectureId;
  String topicId;
  String levelId;
  int ordinalNumber;
  int totalQuestions;
  BestResult? bestResult;
  Exercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.lectureId,
    required this.ordinalNumber,
    required this.totalQuestions,
    required this.topicId,
    required this.levelId,
    this.bestResult,
  });
  get exerciseUid => exerciseId;
  get imageExercisePath => "assets/images/homework.png";
  get statusExercise => bestResult!.status == "PASS";
  get typeQuestion => "Trắc nghiệm";
  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        exerciseId: json["exerciseId"],
        exerciseName: json["exerciseName"],
        lectureId: json["lectureId"],
        ordinalNumber: json["ordinalNumber"],
        totalQuestions: json["totalQuestions"],
        topicId: json["topicId"] ?? "206eb409-4078-40b1-9024-185b2c360645",// Default topicId
        levelId: json["levelId"] ?? "b1d0d171-d4f2-4768-a66c-3104840c94b4",// Default levelId
        bestResult: json["bestResult"] != null
            ? BestResult.fromJson(json["bestResult"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "exerciseId": exerciseId,
        "exerciseName": exerciseName,
        "lectureId": lectureId,
        "ordinalNumber": ordinalNumber,
        "totalQuestions": totalQuestions,
        "topicId": topicId,
        "levelId": levelId,
        "bestResult": bestResult?.toJson(),
      };
}

class BestResult {
  int totalCorrectAnswers;
  int totalAnswers;
  String status;
  BestResult({
    required this.totalCorrectAnswers,
    required this.totalAnswers,
    required this.status,
  });
  factory BestResult.fromJson(Map<String, dynamic> json) => BestResult(
        totalCorrectAnswers: json["totalCorrectAnswers"],
        totalAnswers: json["totalAnswers"],
        status: json["status"],
      );
  Map<String, dynamic> toJson() => {
        "totalCorrectAnswers": totalCorrectAnswers,
        "totalAnswers": totalAnswers,
        "status": status,
      };
}
