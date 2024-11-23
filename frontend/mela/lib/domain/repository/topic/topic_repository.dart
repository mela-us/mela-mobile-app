import 'package:mela/domain/entity/topic/topic.dart';

import '../../entity/topic/topic_list.dart';

abstract class TopicRepository {
    Future<TopicList> getTopics();

    Future<Topic> findTopicById(int id);
}