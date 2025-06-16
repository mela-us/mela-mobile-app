import 'package:flutter_test/flutter_test.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/stores/error/error_store.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/usecase/history/update_excercise_progress_usecase.dart';
import 'package:mela/domain/usecase/question/get_questions_usecase.dart';
import 'package:mela/domain/usecase/question/submit_result_usecase.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'question_store_test.mocks.dart';

@GenerateMocks([GetQuestionsUseCase, SubmitResultUseCase, ErrorStore, UpdateExcerciseProgressUsecase])
void main(){
  late MockGetQuestionsUseCase mockGetQuestionsUseCase;
  late MockSubmitResultUseCase mockSubmitResultUseCase;
  late MockUpdateExcerciseProgressUsecase mockUpdateExcerciseProgressUsecase;
  late MockErrorStore mockErrorStore;
  late QuestionStore questionStore;

  setUp(() {
    mockGetQuestionsUseCase = MockGetQuestionsUseCase();
    mockSubmitResultUseCase = MockSubmitResultUseCase();
    mockUpdateExcerciseProgressUsecase = MockUpdateExcerciseProgressUsecase();
    mockErrorStore = MockErrorStore();
    questionStore =
        QuestionStore(
            mockGetQuestionsUseCase, mockErrorStore, mockSubmitResultUseCase, mockUpdateExcerciseProgressUsecase);
  });

  group('QuestionStore - Success Cases [=>', () {
    test('Should fetch questions successfully', () async {
      // Arrange
      final mockQuestionList = QuestionList(
          message: "Success", size: 5, questions: []);
      when(mockGetQuestionsUseCase.call(params: anyNamed("params")))
          .thenAnswer((_) async => mockQuestionList);

      // Act
      await questionStore.getQuestions();

      // Assert
      expect(questionStore.questionList, mockQuestionList);
      verify(mockGetQuestionsUseCase.call(params: anyNamed("params"))).called(1);
    });

    test('Should submit results successfully', () async {
      // Arrange
      when(mockSubmitResultUseCase.call(
          params: anyNamed("params"))).thenAnswer((_) async {
            print("Called this");
            return 200;
      });

      // Act
      await questionStore.submitAnswer(3, DateTime.now(), DateTime.now());

      // Assert
      verify(mockSubmitResultUseCase.call(params: anyNamed("params"))).called(1);
    });


    test('Should update questionsUid correctly', () {
      // Act
      questionStore.setQuestionsUid("new-uid");

      // Assert
      expect(questionStore.questionsUid, "new-uid");
    });

    test('Should update isQuit status correctly', () {
      // Act
      questionStore.setQuit(QuitOverlayResponse.quit);

      // Assert
      expect(questionStore.isQuit, QuitOverlayResponse.quit);
    });
  });
}

