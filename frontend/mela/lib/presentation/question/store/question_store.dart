import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/question/exercise_result.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/params/question/submit_result_params.dart';
import 'package:mela/domain/usecase/question/generate_hint_usecase.dart';
import 'package:mela/domain/usecase/question/generate_term_usecase.dart';
import 'package:mela/domain/usecase/question/submit_result_usecase.dart';
import 'package:mela/domain/usecase/question/upload_images_usecase.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/result/result.dart';
import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../domain/params/history/exercise_progress_params.dart';
import '../../../domain/usecase/history/update_excercise_progress_usecase.dart';
import '../../../domain/usecase/question/get_questions_usecase.dart';
import '../../../utils/dio/dio_error_util.dart';
part 'question_store.g.dart';

class QuestionStore = _QuestionStore with _$QuestionStore;

abstract class _QuestionStore with Store {
  //Constructor:----------------------------------------------------------------
  _QuestionStore(
      this._getQuestionsUseCase,
      this._errorStore,
      this._submitResultUseCase,
      this._updateExerciseProgressUseCase,
      this._singleQuestionStore,
      this._uploadImagesUsecase);

  //UseCase:--------------------------------------------------------------------
  final GetQuestionsUseCase _getQuestionsUseCase;
  final SubmitResultUseCase _submitResultUseCase;
  final UpdateExcerciseProgressUsecase _updateExerciseProgressUseCase;
  final UploadImagesUsecase _uploadImagesUsecase;

  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;
  final SingleQuestionStore _singleQuestionStore;
  // store variables:-----------------------------------------------------------
  static ObservableFuture<QuestionList?> emptyQuestionResponse =
      ObservableFuture.value(null);
  static ObservableFuture<int?> emptySaveResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<QuestionList?> fetchQuestionsFuture =
      ObservableFuture<QuestionList?>(emptyQuestionResponse);

  @observable
  ObservableFuture<int?> saveUserResult =
      ObservableFuture<int?>(emptySaveResponse);

  @observable
  ObservableFuture<ExerciseResult> fetchExerciseAnswerFuture =
      ObservableFuture<ExerciseResult>(
          ObservableFuture.value(ExerciseResult(message: '', answers: [])));

  @observable
  ObservableFuture<List<List<String>?>> uploadImagesFuture =
      ObservableFuture<List<List<String>?>>(Future.value([]));

  @observable
  QuestionList? questionList;

  @observable
  ExerciseResult? exerciseResult;

  @observable
  bool isUploadingImages = false;

  @observable
  bool success = false;

  @observable
  bool isAuthorized = true;

  @observable
  String questionsUid = "93869de4-5814-435e-834e-48013500eebe";

  @observable
  QuitOverlayResponse isQuit = QuitOverlayResponse.wait;

  @computed
  bool get loading => fetchQuestionsFuture.status == FutureStatus.pending;

  @computed
  bool get saving =>
      fetchExerciseAnswerFuture.status == FutureStatus.pending ||
      isUploadingImages;

  //action:---------------------------------------------------------------------
  @action
  Future getQuestions() async {
    print(questionsUid);
    final future = _getQuestionsUseCase.call(params: questionsUid);
    fetchQuestionsFuture = ObservableFuture(future);

    future.then((questions) {
      questionList = questions;
      //Default set
      questionList ??= QuestionList(message: '', size: 0, questions: []);
    }).catchError((error) {
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          isAuthorized = false;
          return;
        } else {}
      } else {
        if (error == 401) {
          isAuthorized = false;
          return;
        }
      }
      print("Error: $error");
      questionList = QuestionList(message: '', size: 0, questions: []);
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  ExerciseResult? getExerciseResult() {
    if (fetchExerciseAnswerFuture.status == FutureStatus.fulfilled) {
      return fetchExerciseAnswerFuture.value;
    } else {
      return null;
    }
  }

  @action
  Future submitAnswer(int correct, DateTime start, DateTime end) async {
    questionList ??= QuestionList(message: '', size: 0, questions: []);
    final future = _submitResultUseCase.call(
        params: SubmitResultParams(
            exerciseId: questionsUid, startAt: start, endAt: end, answers: []));
    fetchExerciseAnswerFuture = ObservableFuture(future);
    future.then((statusCode) {
      if (statusCode == 200) {
        print('Saving done');
      }
    }).catchError((error) {
      print("Store: $error");
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future updateProgress(DateTime start, DateTime end) async {
    isUploadingImages = true;
    List<List<String>?> imageUrls =
        await _uploadImagesUsecase.call(params: _singleQuestionStore.userImage);

    isUploadingImages = false;

    List<AnswerParams> exerciseAnswers = [];
    for (int i = 0; i < questionList!.questions!.length; i++) {
      // Check if the quesiton is a multiple choice
      if (questionList!.questions![i].questionType == "MULTIPLE_CHOICE") {
        AnswerParams answer = AnswerParams(
          selectedOption: _singleQuestionStore.userAnswers[i].isNotEmpty
              ? int.parse(_singleQuestionStore.userAnswers[i])
              : null,
          blankAnswer: "",
          questionId: questionList!.questions![i].questionId!,
          imageUrls: [],
        );
        exerciseAnswers.add(answer);
      }
      //Check if the question is a subjective question
      else if (questionList!.questions![i].questionType == "ESSAY") {
        AnswerParams answer = AnswerParams(
          selectedOption: null,
          blankAnswer: _singleQuestionStore.userAnswers[i],
          questionId: questionList!.questions![i].questionId!,
          imageUrls: imageUrls[i],
        );
        exerciseAnswers.add(answer);
      }
      // Check if the question is a fill in the blank
      else {
        AnswerParams answer = AnswerParams(
          selectedOption: null,
          blankAnswer: _singleQuestionStore.userAnswers[i],
          questionId: questionList!.questions![i].questionId!,
          imageUrls: null,
        );
        exerciseAnswers.add(answer);
      }
    }
    final future = _updateExerciseProgressUseCase.call(
        params: SubmitResultParams(
      startAt: start,
      endAt: end,
      answers: exerciseAnswers,
      exerciseId: questionsUid,
    ));
    fetchExerciseAnswerFuture = ObservableFuture(future);
    future.then((result) {
      exerciseResult = result;
      print('Exercise result: ${exerciseResult?.message}');
    }).catchError((error) {
      print("Store: $error");
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });

    // isUploadingImages = true;
    // exerciseResult = await _updateExerciseProgressUseCase.call(
    //   params: SubmitResultParams(
    //     startAt: start,
    //     endAt: end,
    //     answers: exerciseAnswers,
    //     exerciseId: questionsUid,
    //   ),
    // );

    // isUploadingImages = false;
  }

  //action
  @action
  void setQuit(QuitOverlayResponse value) {
    isQuit = value;
    //something
  }

  @action
  void setQuestionsUid(String uid) {
    questionsUid = uid;
  }

  @action
  void handleLogout() {}
}
