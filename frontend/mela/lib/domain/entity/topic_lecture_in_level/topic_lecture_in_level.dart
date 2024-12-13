import 'package:mela/domain/entity/lecture/lecture_list.dart';

class TopicLectureInLevel {
  String topicId;
  String topicName;
  LectureList lectureList;
  TopicLectureInLevel({
    required this.topicId,
    required this.topicName,
    required this.lectureList,
  });
  factory TopicLectureInLevel.fromJson(Map<String, dynamic> json) {
    return TopicLectureInLevel(
      topicId: json['topicId'],
      topicName: json['topicName'],
      lectureList: LectureList.fromJson(json['lectureList']),
    );
  }
}
