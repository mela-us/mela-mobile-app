// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http_mock_adapter/http_mock_adapter.dart';
// import 'package:mela/core/data/network/constants/network_constants.dart';
// import 'package:mela/core/data/network/dio/configs/dio_configs.dart';
// import 'package:mela/data/network/apis/questions/save_result_api.dart';
// import 'package:mela/data/network/constants/endpoints_const.dart';
// import 'package:mela/data/network/dio_client.dart';
// import 'package:mela/domain/params/question/submit_result_params.dart';
//
// void main() {
//   late DioAdapter dioAdapter;
//   late SaveResultApi saveResultApi;
//
//   setUp(() {
//     final dio = Dio(BaseOptions(baseUrl: NetworkConstants.mockUrl));
//     dioAdapter = DioAdapter(dio: dio);
//     saveResultApi = SaveResultApi(
//         DioClient(
//             dioConfigs: const DioConfigs(baseUrl: NetworkConstants.mockUrl)));
//   });
//
//   group("[<--Save result POST/api/exercises/save-->]", () {
//     const apiUrl = EndpointsConst.saveResult;
//     test('Success => Return 200', () async {
//       final SubmitResultParams submitResultParams = SubmitResultParams(
//           exerciseId: "uuid-exercise-01",
//           totalCorrectAnswers: 2,
//           totalAnswers: 2,
//           startAt: DateTime.parse("2024-11-26T20:16:32.1122264"),
//           endAt: DateTime.parse("2024-11-26T20:16:32.1122264")
//       );
//
//       final responsePayload = {
//         "message": "Result saved successfully.",
//       };
//
//       dioAdapter.onGet(
//         "$apiUrl?status=200",
//             (server) => server.reply(200, responsePayload),
//       );
//
//       final result = await saveResultApi.saveResult(submitResultParams, "${EndpointsConst.saveResult}?status=200");
//       expect(result, 200);
//     });
//
//     test('Unauthorized => Return 401', () async {
//       final SubmitResultParams submitResultParams = SubmitResultParams(
//           exerciseId: "uuid-exercise-01",
//           totalCorrectAnswers: 2,
//           totalAnswers: 2,
//           startAt: DateTime.parse("2024-11-26T20:16:32.1122264"),
//           endAt: DateTime.parse("2024-11-26T20:16:32.1122264")
//       );
//
//       const responsePayload = "Unauthorized";
//
//       dioAdapter.onGet(
//         "$apiUrl?status=401",
//             (server) => server.reply(401, responsePayload),
//       );
//
//       final result = await saveResultApi.saveResult(submitResultParams, "${EndpointsConst.saveResult}?status=401");
//       expect(result, 401);
//     });
//   });
// }