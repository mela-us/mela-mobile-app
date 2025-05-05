import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';

import '../../../../domain/entity/streak/streak.dart';

class StreakApi {
  final DioClient _dioClient;
  StreakApi(this._dioClient);
  final String url = EndpointsConst.streak;

  Future<Streak> getStreak() async {
    print("================================ở getStreak API");
    final responseData = await _dioClient.get(
      url,
    );
    print(responseData);
    return Streak.fromJson(responseData);
  }

  Future<bool> updateStreak() async {
    print("================================ở updateStreak API");
    final responseData = await _dioClient.post(
      url,
    );
    String message = responseData["message"];
    return message.contains("successfully");
  }
}
