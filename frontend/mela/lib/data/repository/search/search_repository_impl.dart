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
            levelId: 0,
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
            lectureName: "F",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 26,
            levelId: 0,
            topicId: topicId,
            lectureName: "G",
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
            levelId: 2,
            topicId: topicId,
            lectureName: "I",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
        Lecture(
            lectureId: 29,
            levelId: 0,
            topicId: topicId,
            lectureName: "J",
            lectureDescription: "Mô tả bài học",
            lectureContent: "Nội dung bài học"),
      ]);
    await Future.delayed(Duration(seconds: 2));
    //throw "Error  in search impl"; 
    return temp;
  }
}
