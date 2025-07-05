import 'dart:io';

import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/user/user.dart';

class UserInfoApi {
  final DioClient _dioClient;
  UserInfoApi(this._dioClient);
  Future<User> getUser() async {
    // print("================================ở getUsers API");
    final responseData = await _dioClient.get(
      EndpointsConst.getUser,
    );
    User user = User.fromMap(responseData);
    return user;
  }

  Future<String> updateName(String name) async {
    // print("================================ở updateUser API");
    var body = {
      "fullname": name,
    };

    final responseData = await _dioClient.put(
      EndpointsConst.updateUser,
      data: body,
    );
    print(responseData);
    return responseData["message"];
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
    return responseData["message"];
  }

  Future<String> updateImage(File imageFile, String uploadUrl) async {
    var body = {
    "imageUrl" : uploadUrl,
    };
    print("================================ở updateUser API");
    final responseData = await _dioClient.put(
      EndpointsConst.updateUser,
      data: body,
    );
    print(responseData);
    return responseData["message"];
  }

  Future<String> getImageUpdatePresign() async {
    print("================================ở getImageUpdatePresign API");
    final responseData = await _dioClient.get(
      EndpointsConst.getImageUpdatePresign,
    );
    print(responseData);
    return "${responseData["preSignedUrl"]} ${responseData["imageUrl"]}";
  }

  Future<String> updateLevel(String level) async {
    print("================================ở updateUser API");
    var body = {
      "levelTitle": level,
    };

    final responseData = await _dioClient.put(
      EndpointsConst.updateUser,
      data: body,
    );
    print(responseData);
    return responseData["message"];
  }
}
