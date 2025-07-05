import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/exam/exam.dart';

class ExamApi {
  final DioClient _dioClient;
  ExamApi(this._dioClient);

  Future<ExamModel> getExam() async {
    final res = await _dioClient.dio.get(
      EndpointsConst.getExam,
    );
    if (res.statusCode == 200) {
      return ExamModel.fromJson(res.data);
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Unknown error");
    }
  }
}
