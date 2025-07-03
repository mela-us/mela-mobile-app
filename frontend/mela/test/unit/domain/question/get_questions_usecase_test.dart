import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/repository/question/question_repository.dart';
import 'package:mela/domain/usecase/question/get_questions_usecase.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_questions_usecase_test.mocks.dart';

@GenerateMocks([QuestionRepository, RefreshAccessTokenUsecase, LogoutUseCase])
void main(){
  late GetQuestionsUseCase getQuestionsUseCase;
  late MockQuestionRepository mockQuestionRepository;
  late MockRefreshAccessTokenUsecase mockRefreshAccessTokenUsecase;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockQuestionRepository = MockQuestionRepository();
    mockRefreshAccessTokenUsecase = MockRefreshAccessTokenUsecase();
    mockLogoutUseCase = MockLogoutUseCase();

    getQuestionsUseCase = GetQuestionsUseCase(
      mockQuestionRepository,
      mockRefreshAccessTokenUsecase,
      mockLogoutUseCase,
    );
  });

  tearDown(() {
    reset(mockQuestionRepository);
    reset(mockRefreshAccessTokenUsecase);
    reset(mockLogoutUseCase);
  });


  const String params = "test_param";
  final QuestionList mockQuestionList = QuestionList(message: "test", size: 1, questions: []);

  //----------------------------------------------------------------------------
  test("GetQuestionsUseCase should return QuestionList", () async {
    when(mockQuestionRepository.getQuestions(params)).thenAnswer((_)
      async => mockQuestionList);

    final result = await getQuestionsUseCase.call(params: params);

    expect(result, mockQuestionList);
    verify(mockQuestionRepository.getQuestions(params)).called(1);
    verifyNoMoreInteractions(mockQuestionRepository);
  });

  //----------------------------------------------------------------------------
  test('Should refresh token and retry when receiving 401 error', () async {
    // Arrange
    bool firstCall = true;

    when(mockQuestionRepository.getQuestions(any))
        .thenAnswer((_) async {
      if (firstCall) {
        firstCall = false; // Đánh dấu lần đầu đã chạy xong
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(statusCode: 401, requestOptions: RequestOptions(path: '')),
        );
      }
      return mockQuestionList; // Lần 2 sẽ return mockQuestionList
    });

    when(mockRefreshAccessTokenUsecase.call(params: null))
        .thenAnswer((_) async{
      return true;
    });
    // when(mockQuestionRepository.getQuestions(any))
    //     .thenAnswer((_) async => mockQuestionList);

    // Act
    final result = await getQuestionsUseCase.call(params: params);
    // Assert
    expect(result, mockQuestionList);
    verify(mockRefreshAccessTokenUsecase.call(params: isNull)).called(1);
    verify(mockQuestionRepository.getQuestions(params)).called(2);
  });

  //----------------------------------------------------------------------------
  test('Should logout when refresh token fails after 401 error', () async {
    // Arrange
    when(mockQuestionRepository.getQuestions(any))
        .thenThrow(DioException(
      requestOptions: RequestOptions(path: '/questions'),
      response: Response(
        statusCode: 401,
        requestOptions: RequestOptions(path: '/questions'),
        data: "Unauthorized",
      ),
    ));
    when(mockRefreshAccessTokenUsecase.call(params: null))
        .thenAnswer((_) async => false);

    when(mockLogoutUseCase.call(params: null)).thenAnswer((_) async {
      print("Called");
      return true;
    });

    // Act
    expect(() async => getQuestionsUseCase.call(params: params),
    throwsException
    );
    // Assert
    verify(mockRefreshAccessTokenUsecase.call(params: null)).called(1);
  });

  //----------------------------------------------------------------------------
  test('Should return null when API throws other exceptions', () async {
    // Arrange
    when(mockQuestionRepository.getQuestions(any))
        .thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      response: Response(statusCode: 500, requestOptions: RequestOptions(path: '')),
    ));

    // Act
    final result = await getQuestionsUseCase.call(params: params);

    // Assert
    expect(result, null);
    verify(mockQuestionRepository.getQuestions(params)).called(1);
  });


}