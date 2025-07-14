import 'package:mela/domain/entity/topic_lecture_in_level/topic_lecture_in_level.dart';

class TopicLectureInLevelList {
  final List<TopicLectureInLevel> topicLectureInLevelList;

  TopicLectureInLevelList({required this.topicLectureInLevelList});

  factory TopicLectureInLevelList.fromJson(List<dynamic> json) {
    List<TopicLectureInLevel> topicLectureInLevelList = [];
    topicLectureInLevelList =
        json.map((i) => TopicLectureInLevel.fromJson(i)).toList();

    return TopicLectureInLevelList(
      topicLectureInLevelList: topicLectureInLevelList,
    );
  }
}
