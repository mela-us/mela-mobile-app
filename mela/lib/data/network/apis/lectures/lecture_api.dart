import 'package:dio/dio.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture_list.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/suggestion/suggestion.dart';
import 'package:mela/domain/usecase/suggestion/update_suggestion_usecase.dart';

class LectureApi {
  DioClient _dioClient;
  LectureApi(this._dioClient);

  Future<LectureList> getLectures(String topicId) async {
    print("================================ở getLectures API");
    final responseData = await _dioClient
        .get(EndpointsConst.getLectures, queryParameters: {'topicId': topicId});
    //print(responseData);
    return LectureList.fromJson(responseData['data']);
  }

  Future<DividedLectureList> getDividedLectures(String lectureId) async {
    print("================================ở getDividedLectured API");
    final url =
        EndpointsConst.getDividedLectures.replaceAll(':lectureId', lectureId);
    final responseData = await _dioClient.get(url);

    //convert data
    List<dynamic> json = responseData['data'];
    json.forEach((dividedLecture) {
      dividedLecture['lectureId'] = lectureId;
      dividedLecture['topicId'] = responseData["lecture"]["topicId"];
      dividedLecture['levelId'] = responseData["lecture"]["levelId"];
    });
    // print("================================ResponseData LectureApi=====================with lectureId= $lectureId");
    // print("responseData: ${json}");

    return DividedLectureList.fromJson(json);
  }

  // Future<LectureList> getLecturesAreLearning() async {
  //   // print("================================ở getLectureAreLearning API");
  //   final responseData = await _dioClient.get(
  //       EndpointsConst.getLecturesAreLearning,
  //       queryParameters: {'size': 3});
  //   return LectureList.fromJson(responseData['data']);
  // }

  Future<ListSuggestion> getProposedNewSuggestion() async {
    // print("================================ở getLectureAreLearning API");
    final responseData = await _dioClient.get(
      EndpointsConst.getProposedNewSuggestion,
    );
    return ListSuggestion.fromJson(responseData);
  }

  Future<void> updateSuggestion(UpdateSuggestionParams params) async {
    print(
        "Sa4 ===> Updating suggestion in API: ${params.suggestionId}, ${params.lectureId}, ${params.ordinalNumber}, ${params.isDone}");
    await _dioClient.post(
      EndpointsConst.updateSuggestion
          .replaceAll(":suggestionId", params.suggestionId),
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: params.toMap(),
    );
  }
}
