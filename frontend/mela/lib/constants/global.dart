import 'package:flutter/material.dart';

import 'package:mela/domain/entity/stat/progress.dart';
import 'package:mela/domain/entity/stat/detailed_progress.dart';


class Global {
  static Color AppBackgroundColor = const Color(0xFFF5F9FF);
  static Color AppBarContentColor = const Color(0xFF202244);
  static double PracticeLeftPadding = 15;
  static double PracticeRightPadding = 34;

  static List<Progress> progressList = [
      Progress(id: '1', topicName: 'Số học', division: 'Trung học', current: 3, total: 10),
      Progress(id: '2', topicName: 'Đại số', division: 'Trung học', current: 3, total: 10),
      Progress(id: '3', topicName: 'Hình học', division: 'Tiểu học', current: 6, total: 10),
      Progress(id: '4', topicName: 'Lý thuyết số', division: 'Phổ thông', current: 6, total: 10),
      Progress(id: '5', topicName: 'Xác suất thống kê', division: 'Phổ thông', current: 6, total: 10),
      Progress(id: '6', topicName: 'Vị phần', division: 'Phổ thông', current: 5, total: 10),
      Progress(id: '7', topicName: 'Dãy số', division: 'Phổ thông', current: 5, total: 10),
  ];

  static List<DetailedProgress> detailedProgressList = [
    DetailedProgress(topicName: 'Số học', division: 'Trung học', date: '16/11/2024', count: 2),
    DetailedProgress(topicName: 'Số học', division: 'Trung học', date: '15/11/2024', count: 1),
    DetailedProgress(topicName: 'Số học', division: 'Trung học', date: '13/11/2024', count: 1),
    DetailedProgress(topicName: 'Số học', division: 'Trung học', date: '11/11/2024', count: 2),
  ];

}