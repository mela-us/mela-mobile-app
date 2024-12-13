import 'package:flutter/material.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';

import 'lecture_item.dart';

class LecturesInTopic extends StatelessWidget {
  final topicName;
  final LectureList lectureList;

  LecturesInTopic(
      {super.key, required this.topicName, required this.lectureList});

  @override
  Widget build(BuildContext context) {
    if (lectureList.lectures.isEmpty) {
      return const Center(child: Text("Không có bài giảng"));
    }
    return Container(
      color: const Color.fromARGB(255, 241, 241, 160),
      child: ExpansionTile(
        //mainAxisSize: MainAxisSize.min,
        leading: const Icon(Icons.menu_book),
        title: Text(topicName),
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
    );
  }
}
