import 'package:mela/domain/entity/lecture/lecture.dart';

import 'package:mela/domain/entity/lecture/lecture_list.dart';

import '../../../domain/repository/lecture/lecture_repository.dart';

class LectureRepositoryImpl extends LectureRepository {
  @override
  Future<Lecture> getLectureById(int id) async {
    await Future.delayed(Duration(seconds: 3));
    return Lecture(
        lectureId: 0,
        levelId: 0,
        topicId: 0,
        lectureName: "Lý thuyết đồng dư",
        lectureDescription: "Mô tả bài học chi tiết",
        lectureContent: "Nội dung bài học");
  }

  @override
  Future<LectureList> getLectures(int topicId) async {
    //get all leure in topic and level and filter in UI to show
    DateTime now = DateTime.now();
    int minutes = now.minute;
    LectureList temp=LectureList(lectures: []);
    if (minutes % 2 == 0) {
      temp = LectureList(lectures: [
        Lecture(
            lectureId: 0,
            levelId: 0,
            topicId: 0,
            lectureName: "Lý thuyết đồng dư",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 1,
            levelId: 1,
            topicId: 0,
            lectureName: "Hàm Euler, hàm số học",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 1,
            levelId: 2,
            topicId: 0,
            lectureName: "Hàm Euler, hàm số học",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 2,
            levelId: 1,
            topicId: 0,
            lectureName: "Lý thuyết chia hết",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 3,
            levelId: 1,
            topicId: 0,
            lectureName: "Lý thuyết đồng dư",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 4,
            levelId: 2,
            topicId: 0,
            lectureName: "Hàm Euler, hàm số học",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 5,
            levelId: 2,
            topicId: 0,
            lectureName: "Lý thuyết chia hết",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 6,
            levelId: 1,
            topicId: 0,
            lectureName: "Lý thuyết đồng dư",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 7,
            levelId: 0,
            topicId: 0,
            lectureName: "Hàm Euler, hàm số học",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 8,
            levelId: 2,
            topicId: 0,
            lectureName: "Lý thuyết chia hết",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
      ]);
    } else {
      temp = LectureList(lectures: [
        Lecture(
            lectureId: 0,
            levelId: 0,
            topicId: 0,
            lectureName: "A",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 1,
            levelId: 1,
            topicId: 0,
            lectureName: "B",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 1,
            levelId: 2,
            topicId: 0,
            lectureName: "C",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 2,
            levelId: 1,
            topicId: 0,
            lectureName: "D",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 3,
            levelId: 1,
            topicId: 0,
            lectureName: "E",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 4,
            levelId: 2,
            topicId: 0,
            lectureName: "G",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 5,
            levelId: 2,
            topicId: 0,
            lectureName: "F",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 6,
            levelId: 1,
            topicId: 0,
            lectureName: "H",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 7,
            levelId: 0,
            topicId: 0,
            lectureName: "I",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 8,
            levelId: 2,
            topicId: 0,
            lectureName: "J",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
      ]);
    }
    await Future.delayed(Duration(seconds: 2));
    return temp;
  }
}
