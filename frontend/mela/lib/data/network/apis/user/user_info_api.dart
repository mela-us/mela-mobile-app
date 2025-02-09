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

  Future<String> updateName(String name) async {
    print("================================ở updateUser API");
    var body = {
      "name": name,
    };

    final responseData = await _dioClient.put(
      EndpointsConst.updateUser,
      data: body,
    );
    print(responseData);
    return responseData;
  }

  Future<String> updateBirthday(String birthday) async {
    var body = {
      "birthday": birthday,
    };
    print("================================ở updateUser API");
    final responseData = await _dioClient.put(
      EndpointsConst.updateUser,
      data: body,
    );
    print(responseData);
    return responseData;
  }

  Future<String> updateImage(String image) async {
    var body = {
      "imageUrl": image,
    };
    print("================================ở updateUser API");
    final responseData = await _dioClient.put(
      EndpointsConst.updateUser,
      data: body,
    );
    print(responseData);
    return responseData;
  }
}
