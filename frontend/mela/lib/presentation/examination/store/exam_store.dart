import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/exam/exam.dart';
import 'package:mela/domain/entity/question/exercise_result.dart';
import 'package:mela/domain/params/question/submit_result_params.dart';
import 'package:mela/domain/usecase/exam/get_exam_usecase.dart';
import 'package:mela/domain/usecase/exam/submit_exam_usecase.dart';
import 'package:mela/domain/usecase/exam/upload_image_exam_usecase.dart';

import 'package:mela/domain/usecase/question/upload_images_usecase.dart';
import 'package:mela/presentation/examination/store/single_exam_store.dart';
import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';

import '../../../utils/dio/dio_error_util.dart';
part 'exam_store.g.dart';

class ExamStore = _ExamStore with _$ExamStore;

abstract class _ExamStore with Store {
  //Constructor:----------------------------------------------------------------
  _ExamStore(this._getExamUsecase, this._errorStore, this._singleExamStore,
      this._uploadImagesUsecase, this._submitExamUsecase);

  //UseCase:--------------------------------------------------------------------
  final GetExamUsecase _getExamUsecase;
  final UploadImageExamUsecase _uploadImagesUsecase;
  final SubmitExamUsecase _submitExamUsecase;

  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;
  final SingleExamStore _singleExamStore;
  // store variables:-----------------------------------------------------------

  @observable
  ObservableFuture<ExamModel?> fetchQuestionsFuture =
      ObservableFuture<ExamModel?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<int?> saveUserResult =
      ObservableFuture<int?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<ExerciseResult> fetchExerciseAnswerFuture =
      ObservableFuture<ExerciseResult>(
          ObservableFuture.value(ExerciseResult(message: '', answers: [])));

  @observable
  ObservableFuture<List<List<String>?>> uploadImagesFuture =
      ObservableFuture<List<List<String>?>>(Future.value([]));

  @observable
  ExamModel? exam;

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
  Future getExam() async {
    print(questionsUid);
    final future = _getExamUsecase.call(params: questionsUid);
    fetchQuestionsFuture = ObservableFuture(future);

    future.then((exam) {
      this.exam = exam;
      //Default set
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
      exam = ExamModel(total: 0, questions: []);
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

  // @action
  // Future submitAnswer(int correct, DateTime start, DateTime end) async {
  //   exam ??= ExamModel(message: '', size: 0, questions: []);
  //   final future = _submitResultUseCase.call(
  //       params: SubmitResultParams(
  //           exerciseId: questionsUid, startAt: start, endAt: end, answers: []));
  //   fetchExerciseAnswerFuture = ObservableFuture(future);
  //   future.then((statusCode) {
  //     if (statusCode == 200) {
  //       print('Saving done');
  //     }
  //   }).catchError((error) {
  //     print("Store: $error");
  //     _errorStore.errorMessage = DioExceptionUtil.handleError(error);
  //   });
  // }

  @action
  Future updateProgress(DateTime start, DateTime end) async {
    isUploadingImages = true;
    List<List<String>?> imageUrls =
        await _uploadImagesUsecase.call(params: _singleExamStore.userImage);

    isUploadingImages = false;

    List<AnswerParams> exerciseAnswers = [];
    for (int i = 0; i < exam!.total; i++) {
      print("IN LOOP $i OF UPDATE PROGRESS");
      print(_singleExamStore.userAnswers[i]);
      // Check if the quesiton is a multiple choice
      if (exam!.questions![i].questionType == "MULTIPLE_CHOICE") {
        AnswerParams answer = AnswerParams(
          selectedOption: _singleExamStore.userAnswers[i].isNotEmpty
              ? convertLetterToNumber(_singleExamStore.userAnswers[i])
              : null,
          blankAnswer: "",
          questionId: exam!.questions![i].questionId!,
          imageUrls: [],
        );
        exerciseAnswers.add(answer);
        print("Multiple choice $i ${_singleExamStore.userAnswers[i]}");
      }
      //Check if the question is a subjective question
      else if (exam!.questions![i].questionType == "ESSAY") {
        AnswerParams answer = AnswerParams(
          selectedOption: null,
          blankAnswer: _singleExamStore.userAnswers[i],
          questionId: exam!.questions![i].questionId!,
          imageUrls: imageUrls[i],
        );
        exerciseAnswers.add(answer);
        print("Essay $i ");
      }
      // Check if the question is a fill in the blank
      else {
        AnswerParams answer = AnswerParams(
          selectedOption: null,
          blankAnswer: _singleExamStore.userAnswers[i],
          questionId: exam!.questions![i].questionId!,
          imageUrls: null,
        );
        exerciseAnswers.add(answer);
        print("Fill blank $i ${_singleExamStore.userAnswers[i]}");
      }
    }

    final params = SubmitResultParams(
      startAt: start,
      endAt: end,
      answers: exerciseAnswers,
      exerciseId: questionsUid,
    );

    final future = _submitExamUsecase.call(params: params);
    fetchExerciseAnswerFuture = ObservableFuture(future);
    future.then((result) {
      exerciseResult = result;
      print('Exercise result: ${exerciseResult?.message}');
    }).catchError((error) {
      print("Store: $error");
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
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

  int convertLetterToNumber(String letter) {
    switch (letter.toUpperCase()) {
      case 'A':
        return 1;
      case 'B':
        return 2;
      case 'C':
        return 3;
      case 'D':
        return 4;
      default:
        return 0;
    }
  }
}
