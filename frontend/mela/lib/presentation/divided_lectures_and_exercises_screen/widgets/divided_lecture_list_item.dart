import 'package:flutter/material.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';

import '../../../di/service_locator.dart';
import '../../../domain/entity/divided_lecture/divided_lecture.dart';
import '../../../domain/entity/divided_lecture/divided_lecture_list.dart';
import 'divided_lecture_item.dart';

class DividedLectureListItem extends StatelessWidget {
  final ExerciseStore _exerciseStore = getIt<ExerciseStore>();
  DividedLectureListItem();
  DividedLectureList fromJson(String str) {
    DividedLectureList dividedLectures = DividedLectureList(dividedLectures: [
      DividedLecture(
        imageDividedLecturePath: 'assets/images/pdf_image.png',
        pages: '10',
        dividedLectureName: 'Lý thuyết đồng dư 1',
        origin: 'NXB Hà Nội',
        lectureId: 1,
        contentInDividedLecture: "Nội dung bài học \n Lí thuyết 1 \n Lí thuyết 2",
      ),
      DividedLecture(
        imageDividedLecturePath: 'assets/images/opened_book.png',
        pages: '15',
        dividedLectureName: 'Lý thuyết đồng dư 2',
        origin: 'NXB Hà Nội',
        lectureId: 1,
        contentInDividedLecture: "Nội dung bài học \n Lí thuyết 1 \n Lí thuyết 2",
      ),
      DividedLecture(
        imageDividedLecturePath: 'assets/images/pdf_image.png',
        pages: '20',
        dividedLectureName: 'Lý thuyết đồng dư 3',
        origin: 'NXB Hà Nội',
        lectureId: 1,
        contentInDividedLecture: "Nội dung bài học \n Lí thuyết 1 \n Lí thuyết 3",
      ),
    ]);
    return dividedLectures;
  }


  @override
  Widget build(BuildContext context) {
    //String currentContentLectures = _exerciseStore.currentLecture!.lectureContent;
    String currentContentLectures = "ACB";
    DividedLectureList dividedLectures = fromJson(currentContentLectures);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dividedLectures.dividedLectures.length,
      itemBuilder: (context, index) {
        return DividedLectureItem(
          currentDividedLecture: dividedLectures.dividedLectures[index],
        );
      },
    );
  }
}
