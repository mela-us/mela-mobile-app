import 'package:dio/dio.dart';
import 'package:mela/core/extensions/response_status.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';

class RefreshAccessTokenApi {
  final DioClient _dioClient;
  RefreshAccessTokenApi(this._dioClient);
  Future<String> refreshAccessToken(String? refreshToken) async {
    try {
      final responseData = await _dioClient.post(
        EndpointsConst.refreshAccessToken,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {'refreshToken': refreshToken},
      );
      if (responseData['status'] == 'UNAUTHORIZED') {
        throw ResponseStatus.UNAUTHORIZED;
      }

      return responseData['accessToken'];
    } catch (e) {
      rethrow;
    }
  }
}
