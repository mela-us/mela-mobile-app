
import 'package:mela/domain/entity/topic_lecture_in_level/topic_lecture_in_level_list.dart';

abstract class TopicLectureRepository {
    Future<TopicLectureInLevelList> getTopicLectureList(String levelId);
}