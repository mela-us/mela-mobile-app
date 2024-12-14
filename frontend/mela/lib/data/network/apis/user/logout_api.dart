import 'package:dio/dio.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/user/token_model.dart';

class LogoutApi {
  final DioClient _dioClient;
  LogoutApi(this._dioClient);
  Future<bool> logout(TokenModel tokens) async {
    print("================================ ở login API");
    final responseData = await _dioClient.post(
      EndpointsConst.logout,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: tokens.toJson(),
    );
    print(responseData);
    return true;
  }
}
