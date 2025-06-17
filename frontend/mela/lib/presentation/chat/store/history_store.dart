import 'package:dio/dio.dart';
import 'package:mela/core/stores/error/error_store.dart';
import 'package:mela/domain/entity/chat/history_item.dart';
import 'package:mela/domain/usecase/chat/delete_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_history_chat_usecase.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
part 'history_store.g.dart';

class HistoryStore = _HistoryStore with _$HistoryStore;

abstract class _HistoryStore with Store {
  //Use-cases:

  final GetHistoryChatUsecase _getHistoryChatUsecase;
  final ErrorStore _errorStore;
  final DeleteConversationUsecase _deleteConversationUsecase;

  //Observable:-----------------------------------------------------------------
  @observable
  ObservableList<HistoryItem> convs = ObservableList<HistoryItem>();

  @observable
  bool isLoading = false;

  @observable
  bool isUnauthorized = false;

  _HistoryStore(this._getHistoryChatUsecase, this._errorStore,
      this._deleteConversationUsecase);

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
          isUnauthorized = true;
          return;
        } else {
          //ss
        }
        _errorStore.errorMessage = DioExceptionUtil.handleError(e);
      } else {
        if (e == 401) {
          isUnauthorized = true;
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

  @action
  Future<void> deleteConversation(String conversationId) async {
    isLoading = true;

    try {
      _deleteConversationUsecase.call(params: conversationId);
    } catch (e, stackTrace) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          isUnauthorized = true;
          return;
        } else {
          //ss
        }
        _errorStore.errorMessage = DioExceptionUtil.handleError(e);
      } else {
        if (e == 401) {
          isUnauthorized = true;
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
