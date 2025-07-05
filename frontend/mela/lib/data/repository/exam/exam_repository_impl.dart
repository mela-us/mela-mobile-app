import 'package:mela/data/network/apis/exam/exam_api.dart';
import 'package:mela/domain/entity/exam/exam.dart';
import 'package:mela/domain/repository/exam/exam_repository.dart';

class ExamRepositoryImpl extends ExamRepository {
  final ExamApi _examApi;

  ExamRepositoryImpl(this._examApi);
  @override
  Future<ExamModel> getExam() async {
    try {
      ExamModel exam = await _examApi.getExam();
      return exam;
    } catch (e) {
      rethrow;
    }
  }
}
