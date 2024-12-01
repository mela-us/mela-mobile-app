import 'dart:async';

//Data:-------------------------------------------------------------------------
import 'package:dio/dio.dart';

//Domain:-----------------------------------------------------------------------
import 'package:mela/domain/entity/question/question_list.dart';

//Other:------------------------------------------------------------------------
import '../../constants/endpoints_const.dart';
import '../../dio_client.dart';

class QuestionsApi {
  // dio instance
  final DioClient _dioClient;
  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5YWU1YmU0Mi1mMzU2LTQwMmItOWQ0ZS01MDRjMzM5MGI4M2EiLCJpc3MiOiJtZWxhLmxvZ2luIiwidXNlcm5hbWUiOiJubm5uQGdtYWlsLmNvbSIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNzMzMDIyMjk2LCJleHAiOjE3MzMwMjIzMjZ9.l1liSyQ8Qs3KYsHRyS6ehjbU-4KGf31P6wgz7JCc2IQ";
  // injecting dio instance
  QuestionsApi(this._dioClient);

  /// Returns list of post in response
  Future<QuestionList> getQuestions(String exerciseUid) async {
    final res = await _dioClient.dio.get(
      EndpointsConst.getQuestions + exerciseUid,
      options: Options(
          headers: {"Authorization" : "Bearer $token"}
      ),
    );
    print("Resp: $exerciseUid");

    return QuestionList.fromJson(res.data);
  }
}
