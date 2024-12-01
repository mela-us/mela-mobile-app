import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/params/question/submit_result_params.dart';
import 'package:mela/domain/usecase/question/submit_result_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../domain/usecase/question/get_questions_usecase.dart';
import '../../../utils/dio/dio_error_util.dart';
part 'question_store.g.dart';

class QuestionStore = _QuestionStore with _$QuestionStore;

abstract class _QuestionStore with Store{
  //Constructor:----------------------------------------------------------------
  _QuestionStore(
      this._getQuestionsUseCase,
      this._errorStore,
      this._submitResultUseCase);

  //UseCase:--------------------------------------------------------------------
  final GetQuestionsUseCase _getQuestionsUseCase;
  final SubmitResultUseCase _submitResultUseCase;
  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;

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
  QuestionList? questionList;

  @observable
  bool success = false;

  @observable
  bool isAuthorized = true;

  @observable
  String questionsUid  = "93869de4-5814-435e-834e-48013500eebe";

  @observable
  QuitOverlayResponse isQuit = QuitOverlayResponse.wait;

  @computed
  bool get loading => fetchQuestionsFuture.status == FutureStatus.pending;

  @computed
  bool get saving => saveUserResult.status == FutureStatus.pending;

  //action:---------------------------------------------------------------------
  @action
  Future getQuestions() async {
    final future = _getQuestionsUseCase.call(params: questionsUid);
    fetchQuestionsFuture = ObservableFuture(future);

    future.then((questions) {
      questionList = questions;
      //Default set
      questionList ??= QuestionList(message: '', size: 0, questions: []);

    }).catchError((error){
      if (error is DioException) {
        if (error.response?.statusCode == 401){
          isAuthorized = false;
          return;
        }
        else {

        }
      }
      print("Error: $error");
      questionList = QuestionList(message: '', size: 0, questions: []);
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future submitAnswer(int correct, DateTime start, DateTime end) async {
    final future = _submitResultUseCase.call(
        params: SubmitResultParams(
            exerciseId: questionsUid,
            totalCorrectAnswers: correct,
            totalAnswers: questionList!.size,
            startAt: start,
            endAt: end
        )
    );
    saveUserResult = ObservableFuture(future);
    future.then((statusCode){
      if (statusCode == 200) {
        print('Saving done');
      }
    }).catchError((error){
      print("Store: $error");
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  //action
  @action
  void setQuit(QuitOverlayResponse value){
    isQuit = value;
  }

  @action
  void setQuestionsUid(String uid){
    questionsUid = uid;
  }
}