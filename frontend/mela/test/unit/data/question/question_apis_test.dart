
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mela/core/data/network/constants/network_constants.dart';
import 'package:mela/core/data/network/dio/configs/dio_configs.dart';
import 'package:mela/data/network/apis/questions/questions_api.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/question/question.dart';
import 'package:mela/domain/entity/question/question_list.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late DioClient dioClient;
  late DioConfigs dioConfigs;
  late QuestionsApi questionsApi;

  Response<dynamic> response;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: NetworkConstants.mockUrl));
    dioClient = DioClient(
        dioConfigs: const DioConfigs(baseUrl: NetworkConstants.mockUrl));
    dioAdapter = DioAdapter(dio: dio);
    questionsApi = QuestionsApi(
        DioClient(
            dioConfigs: const DioConfigs(baseUrl: NetworkConstants.mockUrl)));
  });

  group('[<--Get question list GET/api/exercises/ex_id-->]', () {
    const exerciseUid = "uuid-exercise-01";
    const apiUrl = "${EndpointsConst.getQuestions}$exerciseUid";
    test('Success => Return questionList', () async {
      final responsePayload =
      {
        "message": "Exercise ID uuid-exercise-01 found successfully.",
        "total": 2,
        "questions": [
          {
            "questionId": "uuid-question-01",
            "ordinalNumber": 1,
            "content": "<div>Chọn đáp án chinh xác của 2<sup>3</sup></div>",
            "questionType": "MULTIPLE_CHOICES",
            "options": [
              {
                "ordinalNumber": 1,
                "content": "3",
                "isCorrect": false
              },
              {
                "ordinalNumber": 2,
                "content": "8",
                "isCorrect": true
              },
              {
                "ordinalNumber": 3,
                "content": "1",
                "isCorrect": false
              },
              {
                "ordinalNumber": 4,
                "content": "5",
                "isCorrect": false
              }
            ],
            "blank_answer": "",
            "guide": "/<div>2<sup>3</sup> = 2 * 2 * 2</div>"
          },
          {
            "questionId": "uuid-question-02",
            "ordinalNumber": 2,
            "content": "<div>Điền đáp án chinh xác của 5<sup>3</sup></div>",
            "questionType": "FILL_IN",
            "options": [],
            "blankAnswer": "125",
            "guide": "<div>5<sup>3</sup> = 5 * 5 * 5</div>"
          }
        ]
      };

      dioAdapter.onGet(
        "$apiUrl?status=200",
            (server) => server.reply(200, responsePayload),
      );

      final result = await questionsApi.getQuestions(exerciseUid);
      expect(result, isA<QuestionList>());
    });

    test('Failed 400 => Throw Exception', () async {
      dioAdapter.onGet("$apiUrl?status=400",
            (server) => server.reply(400, "Bad Request"),);
      expect(() async => questionsApi.getQuestions("$exerciseUid?status=400"),
        throwsException,
      );
    });

    test('Failed 401 => Throw Exception', () async {
      dioAdapter.onGet("$apiUrl?status=401",
              (server) => server.reply(401, "Unauthorized"));
      expect(() async => questionsApi.getQuestions("$exerciseUid?status=401"),
          throwsException
      );
    });
  });
}
