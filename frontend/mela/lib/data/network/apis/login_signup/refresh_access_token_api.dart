import 'package:dio/dio.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';

class RefreshAccessTokenApi {
  final DioClient _dioClient;
  RefreshAccessTokenApi(this._dioClient);
  Future<String> refreshAccessToken(String refreshToken) async {
    print("================================ở refresh API");
    final responseData = await _dioClient.post(
      EndpointsConst.refreshAccessToken,
      data: {'refreshToken': refreshToken},
    );

    return responseData['accessToken'];
  }
}
