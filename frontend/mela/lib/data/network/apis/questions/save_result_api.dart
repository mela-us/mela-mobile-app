import 'package:dio/dio.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/params/question/submit_result_params.dart';

class SaveResultApi{
  final DioClient _dioClient;

  SaveResultApi(this._dioClient);
  Future<int> saveResult(SubmitResultParams param) async{
    try {
      final response = await _dioClient.post(
        EndpointsConst.saveResult,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer token',
        }),
        data: param.toJson(),
      );
      return 200;
    }
    catch (e){
      print(e);
      return 401;
    }

  }
}