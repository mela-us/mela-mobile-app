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
        topicId: json["topicId"],// Default topicId
        levelId: json["levelId"],// Default levelId
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
