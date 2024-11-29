import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/level/level_list.dart';

class LectureApi {
  DioClient _dioClient;
  LectureApi(this._dioClient);

  Future<LevelList> getLevels() async {
    final responseData = await _dioClient.get(EndpointsConst.getLevels);
    return LevelList.fromJson(responseData['data']);
  }

  Future<LectureList> getLectures(String topicId) async {
    final responseData = await _dioClient
        .get(EndpointsConst.getLectures, queryParameters: {'topicId': topicId});
    print(responseData);
    return LectureList.fromJson(responseData['data']);
  }

  Future<LectureList> getLecturesAreLearning() async {
    final responseData = await _dioClient.get(
        EndpointsConst.getLecturesAreLearning,
        queryParameters: {'size': 3});
    return LectureList.fromJson(responseData['data']);
  }
}
