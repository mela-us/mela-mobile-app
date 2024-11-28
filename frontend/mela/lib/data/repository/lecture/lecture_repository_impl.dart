import 'package:mela/domain/entity/lecture/lecture.dart';

import 'package:mela/domain/entity/lecture/lecture_list.dart';

import '../../../domain/repository/lecture/lecture_repository.dart';

class LectureRepositoryImpl extends LectureRepository {
  @override
  Future<Lecture> getLectureById(int id) async {
    await Future.delayed(Duration(seconds: 3));
    return Lecture(
        lectureId: "0",
        levelId: "0",
        topicId: "0",
        lectureName: "Lý thuyết đồng dư",
        lectureDescription: "Mô tả bài học chi tiết",
        lectureContent: "Nội dung bài học");
  }

  @override
  Future<LectureList> getLectures(String topicId) async {
    //get all leure in topic and level and filter in UI to show
    LectureList temp = LectureList(lectures: []);
    temp = LectureList(lectures: [
      Lecture(
          lectureId: "10",
          levelId: "0",
          topicId: topicId,
          lectureName: "Lý thuyết đồng dư",
          lectureDescription: "Mô tả bài học chi tiết",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: "11",
          levelId: "1",
          topicId: topicId,
          lectureName: "Hàm Euler, hàm số học",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
    
    ]);

    await Future.delayed(Duration(seconds: 2));
    //throw "Error in lecture repository";
    return temp;
  }
  
  @override
  Future<LectureList> getLecturesAreLearning() async {
    LectureList temp = LectureList(lectures: []);
    String topicId = "0";
    // temp = LectureList(lectures: [
    //   Lecture(
    //       lectureId: "70",
    //       levelId: "0",
    //       topicId: topicId,
    //       lectureName: "Đang học 1",
    //       lectureDescription: "Mô tả bài học chi tiết",
    //       lectureContent: "Nội dung bài học"),
    //   Lecture(
    //       lectureId: 71,
    //       levelId: 1,
    //       topicId: topicId,
    //       lectureName: "Đang học 2",
    //       lectureDescription: "Mô tả bài học",
    //       lectureContent: "Nội dung bài học"),
    //   Lecture(
    //       lectureId: 72,
    //       levelId: 2,
    //       topicId: topicId,
    //       lectureName: "Tổ hợp 3",
    //       lectureDescription: "Mô tả bài học",
    //       lectureContent: "Nội dung bài học"),
    //   Lecture(
    //       lectureId: 73,
    //       levelId: 1,
    //       topicId: topicId,
    //       lectureName: "Tích phân 4",
    //       lectureDescription: "Mô tả bài học",
    //       lectureContent: "Nội dung bài học"),
    // ]);
    // // if(DateTime.now().minute%2==0){
    //   temp.lectures.add(Lecture(
    //       lectureId: 74,
    //       levelId: 1,
    //       topicId: topicId,
    //       lectureName: "Tích phân 5",
    //       lectureDescription: "Mô tả bài học",
    //       lectureContent: "Nội dung bài học"));
    // }
    await Future.delayed(Duration(seconds: 4));
    //throw "Error in lecture repository";
    return temp;
  }
}
