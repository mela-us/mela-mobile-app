import 'package:dio/dio.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';

import '../../../../domain/entity/user/token_model.dart';

class DeleteAccountApi {
  final DioClient _dioClient;
  DeleteAccountApi(this._dioClient);
  Future<bool> deleteAccount(TokenModel tokens) async {
    print("================================ ở delete account API");
    final responseData = await _dioClient.delete(
      EndpointsConst.deleteAccount,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: tokens.toJson(),
    );
    print(responseData);
    return true;
  }
}
