//Package:----------------------------------------------------------------------
import 'package:flutter/material.dart';

//Domain:-----------------------------------------------------------------------
import '../domain/entity/exercise/exercise.dart';
import '../domain/entity/lecture/lecture.dart';
import '../domain/entity/topic/topic.dart';
import 'package:mela/domain/entity/question/question.dart';

class Global {
  static Color AppBackgroundColor = const Color(0xFFF5F9FF);
  static Color AppBarContentColor = const Color(0xFF202244);
  static double PracticeLeftPadding = 15;
  static double PracticeRightPadding = 34;

  //Course:---------------------------------------------------------------------
  static List<Topic> getTopics() {
    return [
      Topic(
          topicId: 0,
          topicName: "Số học",
          imageTopicPath: "assets/images/topics/sohoc.png"),
      Topic(
          topicId: 0,
          topicName: "Đại số",
          imageTopicPath: "assets/images/topics/daiso.png"),
      Topic(
          topicId: 0,
          topicName: "Hình học",
          imageTopicPath: "assets/images/topics/hinhhoc.png"),
      Topic(
          topicId: 0,
          topicName: "Xác suất và thống kê",
          imageTopicPath: "assets/images/topics/xstk.png"),
      Topic(
          topicId: 0,
          topicName: "Tổ hợp",
          imageTopicPath: "assets/images/topics/tohop.png"),
      Topic(
          topicId: 0,
          topicName: "Tư duy",
          imageTopicPath: "assets/images/topics/tuduy.png"),
    ];
  }

  //Questions:------------------------------------------------------------------
  static List<Question> questions = [
    Question(
      id: 'QQ01',
      content: 'Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu? Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu?',
      answer: 'true',
      imageUrl: null,
      choiceList: [],
    ),

    Question(
        choiceList: ['12', '14', '16', '18'],
        id: 'QQ02',
        content: 'Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu? Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu?',
        answer: 'B',
        imageUrl: null
    ),

    Question(
      choiceList: ['12', '14', '16', '18'],
      id: 'QQ02',
      content: 'Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu? Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu?',
      answer: 'B',
      imageUrl: null,
    ),
    Question(
        choiceList: ['12', '14', '16', '18'],
        id: 'QQ02',
        content: 'Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu? Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu?',
        answer: 'B',
        imageUrl: null
    ),
    Question(
        id: 'QQ01',
        content: 'Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu? Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu?',
        answer: 'true',
        imageUrl: null
    ),
  ];


  static List<Question> questionsSub = [
    Question(
        id: 'QQ01',
        content: 'Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu? Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu?',
        answer: 'true',
        imageUrl: null
    ),

    Question(
        choiceList: ['12', '14', '16', '18'],
        id: 'QQ02',
        content: 'Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu? Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu?',
        answer: 'B',
        imageUrl: null
    ),

  ];

  //Topic:----------------------------------------------------------------------
  static List<Lecture> getLecturesIsLearning() {
    return [
      Lecture(
          lectureId: 0,
          levelId: 0,
          topicId: 0,
          lectureName: "Lý thuyết đồng dư",
          lectureDescription: "Mô tả bài học chi tiết",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 2,
          levelId: 0,
          topicId: 0,
          lectureName: "Hàm Euler, hàm số học",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 5,
          levelId: 0,
          topicId: 0,
          lectureName: "Lý thuyết chia hết",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
    ];
  }

  //Topic:----------------------------------------------------------------------
  static List<Lecture> getLecturesInTopicAndLevel(levelId, topicId) {
    return [
      Lecture(
          lectureId: 0,
          levelId: 0,
          topicId: 0,
          lectureName: "Lý thuyết đồng dư",
          lectureDescription: "Mô tả bài học chi tiết",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 1,
          levelId: 0,
          topicId: 0,
          lectureName: "Hàm Euler, hàm số học",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 2,
          levelId: 0,
          topicId: 0,
          lectureName: "Lý thuyết chia hết",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 3,
          levelId: 0,
          topicId: 0,
          lectureName: "Lý thuyết đồng dư",
          lectureDescription: "Mô tả bài học chi tiết",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 4,
          levelId: 0,
          topicId: 0,
          lectureName: "Hàm Euler, hàm số học",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 5,
          levelId: 0,
          topicId: 0,
          lectureName: "Lý thuyết chia hết",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
      Lecture(
          lectureId: 6,
          levelId: 0,
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
          levelId: 0,
          topicId: 0,
          lectureName: "Lý thuyết chia hết",
          lectureDescription: "Mô tả bài học",
          lectureContent: "Nội dung bài học"),
    ];
  }

  static List<Exercise> getExercisesInLecture(lectureId) {
    return [
      Exercise(
        exerciseId: 0,
        lectureId: 0,
        exerciseName: "Bài tập 1",
      ),
      Exercise(
        exerciseId: 1,
        lectureId: 0,
        exerciseName: "Bài tập 2",
      ),
      Exercise(
        exerciseId: 2,
        lectureId: 0,
        exerciseName: "Bài tập 3",
      ),
    ];
  }
}
