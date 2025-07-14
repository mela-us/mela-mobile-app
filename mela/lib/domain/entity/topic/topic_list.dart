import 'package:mela/domain/entity/topic/topic.dart';

class TopicList {
  final List<Topic> topics;
  TopicList({required this.topics});
  factory TopicList.fromJson(List<dynamic> json) {
    List<Topic> list = <Topic>[];
    list = json.map((topic) => Topic.fromJson(topic)).toList();
    return TopicList(topics: list);
  }
}
