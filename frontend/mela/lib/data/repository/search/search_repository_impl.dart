import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/repository/search/search_repository.dart';

import '../../../domain/entity/lecture/lecture.dart';

class SearchRepositoryImpl extends SearchRepository {
  @override
  Future<List<String>> getHistorySearchList() async {
    List<String> historySearchList = ['Lich su 1 Lich su 4 Lich su 4 Lich su 4 Lich su 4 Lich su 4 Lich su 4 ', 'Lich su 2', 'Lich su 3'];
    await Future.delayed(const Duration(seconds: 2));
    return historySearchList;
  }

  @override
  Future<LectureList> getSearchLecturesResult(String searchText) async {
    int topicId = 0;
    LectureList temp=LectureList(lectures: []);
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
            levelId: 0,
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
            levelId: 0,
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
            levelId: 2,
            topicId: topicId,
            lectureName: "Hàm Euler, hàm số học",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 19,
            levelId: 0,
            topicId: topicId,
            lectureName: "Lý thuyết chia hết",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
      ]);
    await Future.delayed(Duration(seconds: 2));
    return temp;
  }
}
