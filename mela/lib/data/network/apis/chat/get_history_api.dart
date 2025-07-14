import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/chat/history_item.dart';

class GetHistoryApi {
  DioClient _dioClient;
  GetHistoryApi(this._dioClient);

  Future<List<HistoryItem>> getHistoryChat() async {
    final response = await _dioClient.get(EndpointsConst.getChatHistory);

    if (response.statusCode == 200) {
      print("--API GET HISTORY--");
      print(response.data);
      List<dynamic> dataList = response.data["data"];
      List<HistoryItem> temp =
          dataList.map((item) => HistoryItem.fromJson(item)).toList();
      return temp;
    }

    return [];
  }
}
