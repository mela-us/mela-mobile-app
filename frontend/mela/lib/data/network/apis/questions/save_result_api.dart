import 'package:dio/dio.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/params/question/submit_result_params.dart';

class SaveResultApi {
  final DioClient _dioClient;

  SaveResultApi(this._dioClient);
  Future<int> saveResult(SubmitResultParams param, String endpoint) async {
    try {
      await _dioClient.post(
        endpoint,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
        data: param.toJson(),
      );
      return 200;
    } catch (e) {
      print(e);
      return 401;
    }
  }
}
