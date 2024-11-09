import 'package:mela/domain/entity/topic/topic_list.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/usecase/topic/get_topics_usecase.dart';
// Include generated file
part 'topic_store.g.dart';

// This is the class used by rest of your codebase
class TopicStore = _TopicStore with _$TopicStore;

abstract class _TopicStore with Store {
  final GetTopicsUsecase _getTopicsUsecase;

  @observable
  TopicList? topicList;

  @computed
  bool get loading => fetchTopicsFuture.status == FutureStatus.pending;

  //Constructor
  _TopicStore(this._getTopicsUsecase);

  @observable
  ObservableFuture<TopicList?> fetchTopicsFuture =
      ObservableFuture<TopicList?>(ObservableFuture.value(null));

  @action
  Future getTopics() async {
    final future = _getTopicsUsecase.call(params: null);
    fetchTopicsFuture = ObservableFuture(future);

    future.then((topicList) {
      this.topicList = topicList;
    });
  }
}
