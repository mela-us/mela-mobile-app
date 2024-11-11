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
            lectureId: 10,
            levelId: 0,
            topicId: topicId,
            lectureName: "Lý thuyết đồng dư",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 11,
            levelId: 1,
            topicId: topicId,
            lectureName: "Hàm Euler, hàm số học",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 12,
            levelId: 2,
            topicId: topicId,
            lectureName: "Hàm Euler, hàm số học",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 13,
            levelId: 1,
            topicId: topicId,
            lectureName: "Lý thuyết chia hết",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 14,
            levelId: 1,
            topicId: topicId,
            lectureName: "Lý thuyết đồng dư",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 15,
            levelId: 2,
            topicId: topicId,
            lectureName: "Hàm Euler, hàm số học",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 16,
            levelId: 2,
            topicId: topicId,
            lectureName: "Lý thuyết chia hết",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 17,
            levelId: 1,
            topicId: topicId,
            lectureName: "Lý thuyết đồng dư",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 18,
            levelId: 0,
            topicId: topicId,
            lectureName: "Hàm Euler, hàm số học",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 19,
            levelId: 2,
            topicId: topicId,
            lectureName: "Lý thuyết chia hết",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
      ]);
    } else {
      temp = LectureList(lectures: [
        Lecture(
            lectureId: 20,
            levelId: 0,
            topicId: topicId,
            lectureName: "A",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 21,
            levelId: 1,
            topicId: topicId,
            lectureName: "B",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 22,
            levelId: 2,
            topicId: topicId,
            lectureName: "C",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 23,
            levelId: 1,
            topicId: topicId,
            lectureName: "D",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 24,
            levelId: 1,
            topicId: topicId,
            lectureName: "E",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 25,
            levelId: 2,
            topicId: topicId,
            lectureName: "G",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 26,
            levelId: 2,
            topicId: 0,
            lectureName: "F",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 27,
            levelId: 1,
            topicId: topicId,
            lectureName: "H",
            lectureDescription: "Mô tả bài học chi tiết",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 28,
            levelId: 0,
            topicId: topicId,
            lectureName: "I",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 29,
            levelId: 2,
            topicId: topicId,
            lectureName: "J",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
      ]);
    }
    await Future.delayed(Duration(seconds: 2));
    return temp;
  }
}
