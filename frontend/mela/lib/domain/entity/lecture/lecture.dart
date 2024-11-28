class Lecture {
  final String lectureId;
  final String levelId;
  final String topicId;
  final String lectureName;
  final String lectureDescription;
  final String lectureContent;

  Lecture({
    required this.lectureId,
    required this.levelId,
    required this.topicId,
    required this.lectureName,
    required this.lectureContent,
    required this.lectureDescription,

  });
  double get progress => 0.7;
}