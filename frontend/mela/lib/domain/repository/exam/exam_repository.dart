import 'package:mela/data/network/apis/exam/exam_api.dart';
import 'package:mela/domain/entity/exam/exam.dart';

abstract class ExamRepository {
  Future<ExamModel> getExam();
}
