import 'package:dio/dio.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/question/exercise_result.dart';
import 'package:mela/domain/entity/revise/revise.dart';
import 'package:mela/domain/params/question/submit_result_params.dart';

class SaveResultApi {
  final DioClient _dioClient;

  SaveResultApi(this._dioClient);
  Future<ExerciseResult> saveResult(
      SubmitResultParams param, String endpoint) async {
    print("SaveResultApi: $endpoint");
    try {
      var res = await _dioClient.post(
        endpoint,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: param.toJson(),
      );
      return ExerciseResult.fromJson(res);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
