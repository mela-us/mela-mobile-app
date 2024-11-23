import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/content_in_divided_lecture_screen/content_in_divided_lecture_screen.dart';

import '../../../domain/entity/divided_lecture/divided_lecture.dart';

class DividedLectureItem extends StatelessWidget {
  final DividedLecture currentDividedLecture;

  DividedLectureItem({
    required this.currentDividedLecture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContentInDividedLectureScreen(currentDividedLecture: currentDividedLecture),
          ));
        },
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
                  Text(
                    '${currentDividedLecture.topicName} - ${currentDividedLecture.levelName}',
                    style: Theme.of(context)
                        .textTheme
                        .subTitle
                        .copyWith(color: Colors.orange),
                  ),
            
                  const SizedBox(height: 4),
                  // Divided Lecture name
                  Text(
                    currentDividedLecture.dividedLectureName,
                    style: Theme.of(context)
                        .textTheme
                        .subHeading
                        .copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  // pages + origin
                  Text(
                    '${currentDividedLecture.pages} trang | ${currentDividedLecture.origin}',
                    style: Theme.of(context)
                        .textTheme
                        .normal
                        .copyWith(color: Colors.black),
                  ),
            
                  const SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
