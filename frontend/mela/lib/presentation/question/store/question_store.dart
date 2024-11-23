import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../domain/usecase/question/get_questions_usecase.dart';
import '../../../utils/dio/dio_error_util.dart';
part 'question_store.g.dart';

class QuestionStore = _QuestionStore with _$QuestionStore;

abstract class _QuestionStore with Store{
  //Constructor:----------------------------------------------------------------
  _QuestionStore(this._getQuestionsUseCase, this._errorStore);

  //UseCase:--------------------------------------------------------------------
  final GetQuestionsUseCase _getQuestionsUseCase;
  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<QuestionList?> emptyQuestionResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<QuestionList?> fetchQuestionsFuture =
  ObservableFuture<QuestionList?>(emptyQuestionResponse);

  @observable
  QuestionList? questionList;

  @observable
  bool success = false;

  @observable
  QuitOverlayResponse isQuit = QuitOverlayResponse.wait;

  @computed
  bool get loading => fetchQuestionsFuture.status == FutureStatus.pending;

  //action:---------------------------------------------------------------------
  @action
  Future getQuestions() async {
    final future = _getQuestionsUseCase.call(params: null);
    fetchQuestionsFuture = ObservableFuture(future);

    future.then((questions) {
      questionList = questions;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  //action
  @action
  void setQuit(QuitOverlayResponse value){
    isQuit = value;
  }
}