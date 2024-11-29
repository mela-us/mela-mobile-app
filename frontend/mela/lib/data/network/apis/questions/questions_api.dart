import 'dart:async';

//Data:-------------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:mela/core/data/network/dio/dio_client.dart';

//Domain:-----------------------------------------------------------------------
import 'package:mela/domain/entity/post/post_list.dart';
import 'package:mela/domain/entity/question/question_list.dart';

//Other:------------------------------------------------------------------------
import '../../constants/endpoints_const.dart';
import '../../dio_client.dart';

class QuestionsApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  QuestionsApi(this._dioClient);

  /// Returns list of post in response
  Future<QuestionList> getQuestions(String exerciseUid) async {
    try {
      final res = await _dioClient.dio.get(
        EndpointsConst.getQuestions + exerciseUid,
        options: Options(
          headers: {'Authorization' : 'Bearer :token'}
        ),
      );
      return QuestionList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }

  }
}
