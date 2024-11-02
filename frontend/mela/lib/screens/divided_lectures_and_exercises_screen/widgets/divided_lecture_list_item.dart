import 'package:flutter/material.dart';
import 'package:mela/models/lecture.dart';

import '../../../constants/global.dart';
import '../../../models/divided_lecture.dart';
import 'divided_lecture_item.dart';

class DividedLectureListItem extends StatelessWidget {
  Lecture currentLecture;
  DividedLectureListItem({
    required this.currentLecture,
  });
  @override
  Widget build(BuildContext context) {
    var dividedLectures = Global.getDividedLectures(currentLecture.lectureId);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dividedLectures.length,
      itemBuilder: (context, index) {
        return DividedLectureItem(
          currentDividedLecture: dividedLectures[index],
        );
      },
    );
  }
}
