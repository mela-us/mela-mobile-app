import 'package:flutter/material.dart';
import 'package:mela/models/QuestionFamilly/AQuestion.dart';
import 'package:mela/models/QuestionFamilly/FitbQuestion.dart';

import '../models/lecture.dart';
import '../models/topic.dart';

class Global {
  static Color AppBackgroundColor = const Color(0xFFF5F9FF);
  static Color AppBarContentColor = const Color(0xFF202244);
  static double PracticeLeftPadding = 15;
  static double PracticeRightPadding = 34;
  //Login/sign up screen
  static Color backgroundTextFormColor = const Color(0xFFFFFFFF);
  static Color textColorInBackground1 = const Color(0xFF202244);
  static Color textColorInBackground2 = const Color(0xFF545454);
  static TextStyle subTitle=TextStyle(fontFamily: 'Mulish',fontSize: 14,fontWeight: FontWeight.bold,color: textColorInBackground2);
  static TextStyle normalText=TextStyle(fontFamily: 'Mulish',fontSize: 13,fontWeight: FontWeight.bold,color: textColorInBackground2);
  static Color buttonYesColor1 = const Color(0xFF0961F5);
  static Color buttonYesColor2 = const Color(0xFFFFFFFF);

  //Courses screen
  static List<Topic> getTopics(){
    return [
      Topic(topicId: 0, topicName: "Số học", imageTopicPath: "lib/assets/images/topics/sohoc.png"),
      Topic(topicId: 0, topicName: "Đại số", imageTopicPath: "lib/assets/images/topics/daiso.png"),
      Topic(topicId: 0, topicName: "Hình học", imageTopicPath: "lib/assets/images/topics/hinhhoc.png"),
      Topic(topicId: 0, topicName: "Xác suất và thống kê", imageTopicPath: "lib/assets/images/topics/xstk.png"),
      Topic(topicId: 0, topicName: "Tổ hợp", imageTopicPath: "lib/assets/images/topics/tohop.png"),
      Topic(topicId: 0, topicName: "Tư duy", imageTopicPath: "lib/assets/images/topics/tuduy.png"),
    ];
  }
  static List<Lecture> getLecturesIsLearning(){
    return [
      Lecture(lectureId: 0, levelId: 0, topicId: 0, lectureName: "Lý thuyết đồng dư", lectureDescription: "Mô tả bài học chi tiết", lectureContent: "Nội dung bài học"),
      Lecture(lectureId: 2, levelId: 0, topicId: 0, lectureName: "Hàm Euler, hàm số học", lectureDescription: "Mô tả bài học", lectureContent: "Nội dung bài học"),
      Lecture(lectureId: 5, levelId: 0, topicId: 0, lectureName: "Lý thuyết chia hết", lectureDescription: "Mô tả bài học", lectureContent: "Nội dung bài học"),
    ];
  }



  static List<AQuestion> questions = [
    FitbQuestion(
        id: 'FQ01',
        questionContent:
            'Trong một buổi tiệc, có 12 người tham gia. Mỗi người đều bắt tay với mỗi người còn lại một lần. Hỏi tổng số lần bắt tay diễn ra là bao nhiêu?',
        answer: 'true',
        imageUrl: null),
  ];
}
