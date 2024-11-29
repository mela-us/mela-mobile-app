import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/content_in_divided_lecture_screen/content_in_divided_lecture_screen.dart';
import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';

import '../../../domain/entity/divided_lecture/divided_lecture.dart';

class DividedLectureItem extends StatelessWidget {
  final DividedLecture currentDividedLecture;
  final TopicStore _topicStore = getIt<TopicStore>();
  final LectureStore _lectureStore = getIt<LectureStore>();

  DividedLectureItem({
    required this.currentDividedLecture,
  });

  @override
  Widget build(BuildContext context) {
    final topicName = _topicStore.getTopicNameById(
        _lectureStore.getTopicId(currentDividedLecture.lectureId));
    //hoặc thay currentExercise.lectureId bằng _exerciseStore.currentLecture.lectureId
    final levelName = _lectureStore.getLevelName(
        _lectureStore.getLevelId(currentDividedLecture.lectureId));
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContentInDividedLectureScreen(
                currentDividedLecture: currentDividedLecture),
          ));
        },
        child: Row(
          children: [
            // Image + completed questions/total questions
            Expanded(
              flex: 1,
              child: Image.asset('assets/images/pdf_image.png',
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
                    '$topicName - $levelName',
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
