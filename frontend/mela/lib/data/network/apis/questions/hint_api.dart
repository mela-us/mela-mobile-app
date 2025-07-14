import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';

class HintApi{
  final DioClient _dioClient;

  HintApi(this._dioClient);

  Future<String> generateGuide(String questionId) async {
    final res = await _dioClient.dio.post(
        EndpointsConst.generateGuide(questionId)
    );

    if (res.statusCode == 200) {
      print("====API GUIDE=====");
      String guide = res.data["body"];
      return guide;

    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<String> generateTerm(String questionId) async{
    final res = await _dioClient.dio.post(
      EndpointsConst.generateTerm(questionId)
    );

    if (res.statusCode == 200) {
      String term = res.data["body"];
      return term;

    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Unknown error");
    }
  }
}