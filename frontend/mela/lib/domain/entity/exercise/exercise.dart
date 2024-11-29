class Exercise {
  int exerciseId;
  String exerciseName;
  int lectureId;
  Exercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.lectureId,
  });
  get exerciseUid => exerciseId;
  get imageExercisePath => "assets/images/homework.png";
  get topicName => "Số học";
  get levelName => "Trung học";
  get numberCompletedQuestions => 6;
  get numberQuestions => 10;
  get typeQuestion => "Trắc nghiệm";
  get statusExercise => true;
}
