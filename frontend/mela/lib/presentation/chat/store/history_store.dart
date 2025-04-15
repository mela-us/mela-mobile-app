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
  List<HistoryItem>? convs;

  @observable
  bool isLoading = false;

  _HistoryStore(this._getHistoryChatUsecase, this._errorStore);

  //Action:---------------------------------------------------------------------

  @action
  void getConvHistory() async {
    isLoading = true;

    try {
      convs = await _getHistoryChatUsecase.call(params: null);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          // isAuthorized = false;
          return;
        } else {
          //ss
        }
        _errorStore.errorMessage = DioExceptionUtil.handleError(e);
      } else {
        if (e == 401) {
          return;
        }
      }
      print("Error: $e");
    }
  }

  //Computed:-------------------------------------------------------------------
}
