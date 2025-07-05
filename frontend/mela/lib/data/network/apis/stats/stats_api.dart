import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/stat/progress_list.dart';

import '../../../../domain/entity/stat/detailed_stat_list.dart';

class StatsApi {
  final DioClient _dioClient;
  StatsApi(this._dioClient);
  Future<ProgressList> getProgress(String level) async {
    final url = '${EndpointsConst.getProgress}/$level?type=ALL';
    print("================================ở getProgress API");
    final responseData = await _dioClient.get(
      url,
    );
    print(responseData);
    return ProgressList.fromJson(responseData);
  }

  Future<DetailedStatList> getDetailedStat()async {
    const url = EndpointsConst.getDetailedStats;
    print("================================ở getDetailedStats API");
    final responseData = await _dioClient.get(
      url,
    );
    print(responseData);
    return DetailedStatList.fromJson(responseData);
  }
}
