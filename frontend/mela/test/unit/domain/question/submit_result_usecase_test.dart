import 'package:flutter_test/flutter_test.dart';
import 'package:mela/domain/params/question/submit_result_params.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:mela/domain/usecase/question/submit_result_usecase.dart';
import 'package:mela/data/network/apis/questions/save_result_api.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

import 'submit_result_usecase_test.mocks.dart';

@GenerateMocks([SaveResultApi, RefreshAccessTokenUsecase, LogoutUseCase])
void main() {
  late SubmitResultUseCase submitResultUseCase;
  late MockSaveResultApi mockSaveApi;
  late MockRefreshAccessTokenUsecase mockRefreshAccessTokenUsecase;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockSaveApi = MockSaveResultApi();
    mockRefreshAccessTokenUsecase = MockRefreshAccessTokenUsecase();
    mockLogoutUseCase = MockLogoutUseCase();
    submitResultUseCase = SubmitResultUseCase(
        mockSaveApi, mockRefreshAccessTokenUsecase, mockLogoutUseCase);
  });

  var params = SubmitResultParams(
      exerciseId: "exerciseId",
      totalCorrectAnswers: 2,
      totalAnswers: 2,
      startAt: DateTime.now(),
      endAt: DateTime.now()
  );

  test('Should return result code on success', () async {
    when(mockSaveApi.saveResult(any, any))
        .thenAnswer((_) async => 200);

    final result = await submitResultUseCase.call(params: params);

    expect(result, 200);
    verify(mockSaveApi.saveResult(params, any)).called(1);
    verifyNoMoreInteractions(mockSaveApi);
  });

  test('Should refresh token and retry when receiving 401 error', () async {
    bool firstCall = true;

    when(mockSaveApi.saveResult(any, any)).thenAnswer((_) async {
      if (firstCall) {
        firstCall = false;
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
              statusCode: 401, requestOptions: RequestOptions(path: '')),
        );
      }
      return 200;
    });

    when(mockRefreshAccessTokenUsecase.call(params: null))
        .thenAnswer((_) async => true);

    final result = await submitResultUseCase.call(params: params);

    expect(result, 200);
    verify(mockRefreshAccessTokenUsecase.call(params: null)).called(1);
    verify(mockSaveApi.saveResult(params, any)).called(2);
  });

  test('Should logout when refresh token fails after 401 error', () async {
    when(mockSaveApi.saveResult(any, any)).thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(statusCode: 401, requestOptions: RequestOptions(path: '')),
    ));

    when(mockRefreshAccessTokenUsecase.call(params: null))
        .thenAnswer((_) async => false);

    when(mockLogoutUseCase.call(params: null)).thenAnswer((_) async => true);

    expect(
            () async => await submitResultUseCase.call(params: params),
        throwsA(isA<DioException>()));

    verify(mockRefreshAccessTokenUsecase.call(params: null)).called(1);
  });

  test('Should return -1 when other errors occur', () async {
    when(mockSaveApi.saveResult(any, any)).thenThrow(Exception("Some error"));

    final result = await submitResultUseCase.call(params: params);

    expect(result, -1);
  });
}
