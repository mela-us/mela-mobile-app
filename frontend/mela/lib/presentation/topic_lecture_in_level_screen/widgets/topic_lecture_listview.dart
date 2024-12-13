import 'package:flutter/material.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/widgets/lectures_in_topic.dart';

class TopicLectureListview extends StatelessWidget {
  final TopicLectureStore topicLectureStore = getIt<TopicLectureStore>();
  TopicLectureListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // shrinkWrap: true,
      itemCount: topicLectureStore
          .topicLectureInLevelList!.topicLectureInLevelList.length,
      itemBuilder: (context, index) {
        return LecturesInTopic(
            topicName: topicLectureStore.topicLectureInLevelList!
                .topicLectureInLevelList[index].topicName,
            lectureList: topicLectureStore.topicLectureInLevelList!
                .topicLectureInLevelList[index].lectureList);
      },
    );
  }
}
