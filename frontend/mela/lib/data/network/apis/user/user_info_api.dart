import 'package:dio/dio.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/user/user.dart';

class UserInfoApi {
  final DioClient _dioClient;
  UserInfoApi(this._dioClient);
  Future<User> getUser() async {
    print("================================ở getUsers API");
    final responseData = await _dioClient.get(
      EndpointsConst.getUser,
    );
    print(responseData);
    return User.fromMap(responseData);
  }
}
