import 'dart:io';

import 'package:mela/domain/entity/exam/exam.dart';

abstract class ExamRepository {
  Future<ExamModel> getExam();

  Future<List<List<String>?>> uploadImages(List<List<File>> images);

  Future<int> submitQuestion(
      String exerciseUid, String questionText, List<String> imageUrls);
}
