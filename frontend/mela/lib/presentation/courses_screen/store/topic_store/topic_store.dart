import 'package:mela/domain/entity/lecture/lecture.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/topic/topic_list.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';
import 'package:mobx/mobx.dart';

import '../../../../di/service_locator.dart';
import '../../../../domain/usecase/topic/get_topics_usecase.dart';
// Include generated file
part 'topic_store.g.dart';

// This is the class used by rest of your codebase
class TopicStore = _TopicStore with _$TopicStore;

abstract class _TopicStore with Store {
  final GetTopicsUsecase _getTopicsUsecase;

  @observable
  TopicList? topicList;

  @observable
  LectureList? lecturesAreLearningList;

  LectureStore _lectureStore = getIt<LectureStore>();

  @observable
  String errorString = '';

  @computed
  bool get loading =>
      fetchTopicsFuture.status == FutureStatus.pending ||
      fetchLecturesAreLearningFuture.status == FutureStatus.pending;

  late final ReactionDisposer _topicItemReactionDisposer;
  //Constructor
  _TopicStore(this._getTopicsUsecase);

  @observable
  ObservableFuture<TopicList?> fetchTopicsFuture =
      ObservableFuture<TopicList?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<LectureList?> fetchLecturesAreLearningFuture =
      ObservableFuture<LectureList?>(ObservableFuture.value(null));

  @action
  Future getTopics() async {
    final future = _getTopicsUsecase.call(params: null);
    fetchTopicsFuture = ObservableFuture(future);

    try {
      final topicList = await future;
      this.topicList = topicList;
      this.errorString = '';
    } catch (onError) {
      this.topicList = null;
      this.errorString = onError.toString();
    }
  }

  @action
  Future getAreLearningLectures() async {
    final future =
        _lectureStore.getLecturesAreLearningUsecase.call(params: null);
    fetchLecturesAreLearningFuture = ObservableFuture(future);
    try {
      final lecturesAreLearningList = await future;
      this.lecturesAreLearningList = lecturesAreLearningList;
      this.errorString = '';
    } catch (onError) {
      this.lecturesAreLearningList = null;
      this.errorString = onError.toString();
    }
  }

  @action
  void resetErrorString() {
    errorString = '';
  }
}
