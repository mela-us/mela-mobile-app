class Lecture {
  final String lectureId;
  final String levelId;
  final String topicId;
  final String lectureName;
  final String lectureDescription;
  final int totalExercises;
  final int totalPassExercises;

  Lecture({
    required this.lectureId,
    required this.levelId,
    required this.topicId,
    required this.lectureName,
    required this.lectureDescription,
    required this.totalExercises,
    required this.totalPassExercises,
  });
  double get progress => totalPassExercises / totalExercises;

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      lectureId: json['lectureId'],
      levelId: json['levelId'],
      topicId: json['topicId'],
      lectureName: json['name'],
      lectureDescription: json['description'],
      totalExercises: json['totalExercises'],
      totalPassExercises: json['totalPassExercises'],
    );
  }
}
