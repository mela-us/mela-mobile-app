import 'package:mela/data/network/apis/topic_lecture/topic_lecture_api.dart';
import 'package:mela/domain/entity/topic_lecture_in_level/topic_lecture_in_level_list.dart';
import 'package:mela/domain/repository/topic_lecture/topic_lecture_repository.dart';


class TopicLectureRepositoryImpl extends TopicLectureRepository {
  TopicLectureApi _topicLectureApi;
  TopicLectureRepositoryImpl(this._topicLectureApi);

  @override
  Future<TopicLectureInLevelList> getTopicLectureList(String levelId) {
    return _topicLectureApi.getTopicLecture(levelId);
  }
}
