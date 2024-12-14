import 'dart:async';

//Data:-------------------------------------------------------------------------

//Domain:-----------------------------------------------------------------------
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
    final res = await _dioClient.dio.get(
      EndpointsConst.getQuestions + exerciseUid,
    );

    QuestionList list = QuestionList.fromJson(res.data);
    return list;
  }
}
