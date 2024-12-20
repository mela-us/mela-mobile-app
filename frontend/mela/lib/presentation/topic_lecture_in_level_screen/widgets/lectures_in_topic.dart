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

  Widget getIconTopic() {
    for (var topic in _levelStore.topicList!.topics) {
      if (topic.topicId == topicId && topic.imageTopicPath != "") {
        print("+++++++++++++++++++++++++++++");
        print(topic.imageTopicPath);
        return Image(
          image: NetworkImage(topic.imageTopicPath),
          width: 28,
          height: 28,
          fit: BoxFit.contain,
        );
      }
    }
    return const Image(
      image: AssetImage("assets/images/topics/default_topic.png"),
      width: 28,
      height: 28,
      fit: BoxFit.contain,
    );
  }

  int numberCompletedLectures() {
    int count = 0;
    for (var lecture in lectureList.lectures) {
      if (lecture.totalExercises == lecture.totalPassExercises &&
          lecture.totalExercises != 0) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    if (lectureList.lectures.isEmpty) {
      return const Center(child: Text("Không có bài giảng"));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 6,bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius:
                  BorderRadius.circular(10) // Removes border or divider effect
              ),
          //mainAxisSize: MainAxisSize.min,
          leading: getIconTopic(),
          backgroundColor: const Color.fromARGB(255, 238, 237, 237),
          childrenPadding: const EdgeInsets.only(bottom: 6),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  "$topicName",
                  style: Theme.of(context).textTheme.subTitle.copyWith(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16),
                ),
              ),
              Text(
                "${numberCompletedLectures().toString()}/${lectureList.lectures.length} bài học",
                style: Theme.of(context).textTheme.subTitle.copyWith(
                    color: Theme.of(context).colorScheme.primary, fontSize: 12),
              ),
            ],
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
