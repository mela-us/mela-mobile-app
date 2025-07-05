import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/stores/error/error_store.dart';
import 'package:mela/domain/entity/chat/history_item.dart';
import 'package:mela/domain/entity/exam/exam.dart';
import 'package:mela/domain/usecase/chat/delete_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_history_chat_usecase.dart';
import 'package:mela/domain/usecase/exam/get_exam_usecase.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
part 'exam_store.g.dart';

class ExamStore = _ExamStore with _$ExamStore;

abstract class _ExamStore with Store {
  //Use-cases:
  final GetExamUsecase _getExamUsecase;
  final ErrorStore _errorStore;

  _ExamStore(this._getExamUsecase, this._errorStore);
  //Observable:-----------------------------------------------------------------
  @observable
  ObservableFuture<ExamModel?> fetchExamFuture =
      ObservableFuture<ExamModel?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<int?> saveUserResult =
      ObservableFuture<int?>(ObservableFuture.value(null));

  @observable
  ExamModel? exam;

  @observable
  bool success = false;
  @observable
  bool isAuthorized = true;

  @observable
  @observable
  QuitOverlayResponse isQuit = QuitOverlayResponse.wait;

  //Computed:-------------------------------------------------------------------
  @computed
  bool get isExamAvailable => exam != null && exam!.questions.isNotEmpty;

  @computed
  bool get loading => fetchExamFuture.status == FutureStatus.pending;

  @computed
  bool get saving => saveUserResult.status == FutureStatus.pending;
  //Action:---------------------------------------------------------------------

  @action
  Future<void> fetchExam() async {
    final future = _getExamUsecase.call(params: null);

    future.then((exam) {
      this.exam = exam;
      exam ??= ExamModel(questions: [], total: 0);
    }).catchError((error) {
      if (error is DioException) {
        if (error.response?.statusCode == 401) {
          isAuthorized = false;
        } else {
          _errorStore.errorMessage = DioExceptionUtil.handleError(error);
        }
      } else {
        _errorStore.errorMessage = error.toString();
      }
    });
  }

  //action
  @action
  void setQuit(QuitOverlayResponse value) {
    isQuit = value;
    //something
  }

  // @action
  // void setQuestionsUid(String uid) {
  //   questionsUid = uid;
  // }
}
