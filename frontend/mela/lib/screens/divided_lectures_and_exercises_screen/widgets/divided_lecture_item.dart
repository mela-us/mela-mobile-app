import 'package:flutter/material.dart';
import 'package:mela/models/lecture.dart';

import '../../../models/divided_lecture.dart';
import '../../../themes/default/text_styles.dart';

class DividedLectureItem extends StatelessWidget {
  final DividedLecture currentDividedLecture;

  DividedLectureItem({
    required this.currentDividedLecture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Image + completed questions/total questions
          Expanded(
            flex: 1,
            child: Image.asset(currentDividedLecture.imageDividedLecturePath,
                width: 60, height: 60),
          ),
          SizedBox(width: 10),

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Topic name + level name
                TextStandard.SubTitle(
                  '${currentDividedLecture.topicName} - ${currentDividedLecture.levelName}',
                  Colors.orange,
                ),
                SizedBox(height: 4),
                // Divided Lecture name
                TextStandard.SubHeading(
                  currentDividedLecture.dividedLectureName,
                  Colors.black,
                ),
                SizedBox(height: 8),
                // pages + origin
                TextStandard.Normal(
                  '${currentDividedLecture.pages} trang | ${currentDividedLecture.origin}',
                  Colors.black,
                ),

                SizedBox(width: 16),
              ],
            ),
          ),
          SizedBox(width: 6),
        ],
      ),
    );
  }
}
