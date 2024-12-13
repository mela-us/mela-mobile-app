import 'package:flutter/material.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';

import 'lecture_item.dart';

class LecturesInTopic extends StatelessWidget {
  final topicId;
  final topicName;
  final LectureList lectureList;
  final LevelStore _levelStore = getIt<LevelStore>();
  LecturesInTopic(
      {super.key,
      required this.topicId,
      required this.topicName,
      required this.lectureList});

  String getIconTopicPath() {
    for (var topic in _levelStore.topicList!.topics) {
      if (topic.topicId == topicId && topic.imageTopicPath != "") {
        return topic.imageTopicPath;
      }
    }
    return "assets/images/topics/default_topic.png";
  }

  @override
  Widget build(BuildContext context) {
    if (lectureList.lectures.isEmpty) {
      return const Center(child: Text("Không có bài giảng"));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius:
                  BorderRadius.circular(20) // Removes border or divider effect
              ),
          //mainAxisSize: MainAxisSize.min,
          leading: Image.asset(
            getIconTopicPath(),
            width: 40,
            height: 40,
          ),
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          childrenPadding: const EdgeInsets.only(bottom: 6),
          title: Text(
            topicName,
            style: Theme.of(context).textTheme.subTitle.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16),
          ),
          children: [
            Column(
              children: lectureList.lectures.map((lecture) {
                return LectureItem(
                  lecture: lecture,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
