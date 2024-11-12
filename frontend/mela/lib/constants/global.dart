import 'package:flutter/material.dart';
import 'package:mela/domain/entity/question/fill_question.dart';
import 'package:mela/domain/entity/question/question.dart';
import 'package:mela/domain/entity/question/quiz_question.dart';


class Global {
  static Color AppBackgroundColor = const Color(0xFFF5F9FF);
  static Color AppBarContentColor = const Color(0xFF202244);
  static double PracticeLeftPadding = 15;
  static double PracticeRightPadding = 34;

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

}