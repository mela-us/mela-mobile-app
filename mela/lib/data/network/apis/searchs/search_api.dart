import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';

class SearchApi {
  DioClient _dioClient;
  SearchApi(this._dioClient);
  Future<LectureList> searchLecturesByText(String searchingText)async {
    final responseData = await _dioClient.get(
      EndpointsConst.getLecturesSearch,
      queryParameters: {"q": searchingText},
    );
    return LectureList.fromJson(responseData['data']);
  }
}