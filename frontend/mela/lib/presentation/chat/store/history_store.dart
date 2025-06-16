import 'package:dio/dio.dart';
import 'package:mela/core/stores/error/error_store.dart';
import 'package:mela/domain/entity/chat/history_item.dart';
import 'package:mela/domain/usecase/chat/get_history_chat_usecase.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
part 'history_store.g.dart';

class HistoryStore = _HistoryStore with _$HistoryStore;

abstract class _HistoryStore with Store {
  //Use-cases:

  final GetHistoryChatUsecase _getHistoryChatUsecase;
  final ErrorStore _errorStore;

  //Observable:-----------------------------------------------------------------
  @observable
  ObservableList<HistoryItem> convs = ObservableList<HistoryItem>();

  @observable
  bool isLoading = false;

  _HistoryStore(this._getHistoryChatUsecase, this._errorStore);


  @computed
  bool get iisLoading => isLoading;
  //Action:---------------------------------------------------------------------

  @action
  Future<void> getConvHistory() async {
    isLoading = true;

    try {
      print("Reach");
      List<HistoryItem> hist = await _getHistoryChatUsecase.call(params: null);
      convs.clear();
      convs.addAll(hist);
      print("Done!");
      isLoading = false;
    } catch (e, stackTrace) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          // isAuthorized = false;
          return;
        } else {
          //ss
        }
        _errorStore.errorMessage = DioExceptionUtil.handleError(e);
      }
      else {
        if (e == 401) {
          return;
        }
        print("Error: $e");
      }
      print("Error: $e, stackTrace: $stackTrace");
    } finally {
      isLoading = false;
    }

    isLoading = false;
  }

  //Computed:-------------------------------------------------------------------
}
