import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/stat/progress_list.dart';

class StatsApi {
  final DioClient _dioClient;
  StatsApi(this._dioClient);
  Future<ProgressList> getStats(String level) async {
    print("================================ở getStats API");
    final responseData = await _dioClient.get(
      EndpointsConst.getStats,
    );
    print(responseData);
    return ProgressList.fromJson(responseData);
  }
}
