import 'dart:async';

import 'package:mela/core/domain/usecase/use_case.dart';

import '../../entity/topic/topic.dart';
import '../../repository/topic/topic_repository.dart';

class FindTopicByIdUsecase extends UseCase<Topic, int> {
  final TopicRepository _topicRepository;
  FindTopicByIdUsecase(this._topicRepository);

  @override
  FutureOr<Topic> call({required int params}) {
    return _topicRepository.findTopicById(params);
  }


}