import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/widgets/lectures_in_topic.dart';

class TopicLectureListview extends StatelessWidget {
  final TopicLectureStore topicLectureStore = getIt<TopicLectureStore>();
  TopicLectureListview({super.key});

  @override
  Widget build(BuildContext context) {
    if (topicLectureStore
        .topicLectureInLevelList!.topicLectureInLevelList.isEmpty) {
      return Center(
        child: Text(
          "Hiện tại chưa có dữ liệu cho khối lớp này",
          style: Theme.of(context)
              .textTheme
              .subTitle
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      );
    }
    return ListView.builder(
      // shrinkWrap: true,
      itemCount: topicLectureStore
          .topicLectureInLevelList!.topicLectureInLevelList.length,
      itemBuilder: (context, index) {
        return LecturesInTopic(
            topicId: topicLectureStore.topicLectureInLevelList!
                .topicLectureInLevelList[index].topicId,
            topicName: topicLectureStore.topicLectureInLevelList!
                .topicLectureInLevelList[index].topicName,
            lectureList: topicLectureStore.topicLectureInLevelList!
                .topicLectureInLevelList[index].lectureList);
      },
    );
  }
}
