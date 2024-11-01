import 'package:flutter/material.dart';
import 'package:mela/constants/global.dart';

import 'lecture_item.dart';

class LecturesInTopicAndLevel extends StatelessWidget {
  final int levelId;
  final int topicId;
  const LecturesInTopicAndLevel(
      {super.key, required this.levelId, required this.topicId});

  @override
  Widget build(BuildContext context) {
    var lecturesInTopicAndLevel= Global.getLecturesInTopicAndLevel(levelId, topicId);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: lecturesInTopicAndLevel.length,
        itemBuilder: (context, index) {
          return LectureItem(
            lecture: lecturesInTopicAndLevel[index],
          );
        },
      ),
    );
  }
}
