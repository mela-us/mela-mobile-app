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
    LectureList temp = LectureList(lectures: []);
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
          lectureName: "Tổ hợp",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 13,
          levelId: 1,
          topicId: topicId,
          lectureName: "Tích phân",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 14,
          levelId: 1,
          topicId: topicId,
          lectureName: "Hình học",
          lectureDescription: "Mô tả bài học chi tiết",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 15,
          levelId: 2,
          topicId: topicId,
          lectureName: "Số cơ bản",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 16,
          levelId: 2,
          topicId: topicId,
          lectureName: "Số dư",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 17,
          levelId: 1,
          topicId: topicId,
          lectureName: "Số chia",
          lectureDescription: "Mô tả bài học chi tiết",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 18,
          levelId: 0,
          topicId: topicId,
          lectureName: "Cộng trừ nâng cao",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 19,
          levelId: 2,
          topicId: topicId,
          lectureName: "Cộng trừ cơ bản",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
    ]);

    await Future.delayed(Duration(seconds: 2));
    //throw "Error in lecture repository";
    return temp;
  }
}
