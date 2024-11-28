import 'package:mela/data/network/apis/topics/topic_api.dart';
import 'package:mela/domain/entity/topic/topic_list.dart';
import 'package:mela/domain/repository/topic/topic_repository.dart';

import '../../../domain/entity/topic/topic.dart';

class TopicRepositoryImpl extends TopicRepository {
  TopicApi _topicApi;
  TopicRepositoryImpl(this._topicApi);

  @override
  Future<TopicList> getTopics() async {
    // TopicList topicList = TopicList(topics: [
    //   Topic(
    //       topicId: "0",
    //       topicName: "Số học",
    //       imageTopicPath: "assets/images/topics/sohoc.png",),
    //   Topic(
    //       topicId: "1",
    //       topicName: "Đại số",
    //       imageTopicPath: "assets/images/topics/daiso.png"),
    //   Topic(
    //       topicId: "2",
    //       topicName: "Hình học",
    //       imageTopicPath: "assets/images/topics/hinhhoc.png"),
    //   Topic(
    //       topicId: "3",
    //       topicName: "Xác suất và thống kê",
    //       imageTopicPath: "assets/images/topics/xstk.png"),
    //   Topic(
    //       topicId: "4",
    //       topicName: "Tổ hợp",
    //       imageTopicPath: "assets/images/topics/tohop.png"),
    //   Topic(
    //       topicId: "5",
    //       topicName: "Tư duy",
    //       imageTopicPath: "assets/images/topics/tuduy.png"),
    // ]);
    // await Future.delayed(const Duration(seconds: 2));
    // //throw "Error in topic repository";
    //return topicList;

    return _topicApi.getTopics();
  }

  @override
  Future<Topic> findTopicById(int id) async {
    TopicList topicList = await getTopics() as TopicList;
    return topicList.topics.firstWhere((topic) => topic.topicId == id);
  }
}
