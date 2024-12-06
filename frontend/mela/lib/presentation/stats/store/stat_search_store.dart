import 'package:http/http.dart';
import 'package:mela/domain/usecase/stat/get_stat_search_history_usecase.dart';
import 'package:mobx/mobx.dart';
import '../../../di/service_locator.dart';
import '../../../domain/entity/stat/progress_list.dart';
import '../../../domain/usecase/stat/update_stat_search_history_usecase.dart';
// Include generated file
part 'stat_search_store.g.dart';

// This is the class used by rest of your codebase
class StatSearchStore = _StatSearchStore with _$StatSearchStore;

abstract class _StatSearchStore with Store {
  //UseCase
  GetStatSearchHistoryUseCase _getStatSearchHistoryUseCase;
  UpdateStatSearchHistoryUseCase _updateStatSearchHistoryUseCase;

  //Constructor
  _StatSearchStore(this._getStatSearchHistoryUseCase, this._updateStatSearchHistoryUseCase);

  @observable
  bool isSearched = false; //check typing search done

  @observable
  bool isFiltered = false; //check applied filter

  @observable
  String errorString = '';

  @observable
  ObservableList<String> searchHistory = ObservableList<String>();

  @computed
  bool get isLoadingHistorySearch =>
      fetchHistorySearchFuture.status == FutureStatus.pending;

  @observable
  ObservableFuture<List<String>?> fetchHistorySearchFuture =
  ObservableFuture<List<String>?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<void> fetchUpdateHistory =
  ObservableFuture<void>(ObservableFuture.value(null));

  @action
  Future getStatSearchHistory() async {
    final future = _getStatSearchHistoryUseCase.call(params: null);
    fetchHistorySearchFuture = ObservableFuture(future);
    future.then((value) {
      searchHistory = ObservableList.of(value ?? []);
    }).catchError((onError) {
      searchHistory = ObservableList<String>();
      print(onError);
    });
  }

  @action
  Future updateStatSearchHistory() async {
    final future = _updateStatSearchHistoryUseCase.call(params: searchHistory);
    fetchUpdateHistory = ObservableFuture(future);
    future.then((value) {
    }).catchError((onError) {
      print(onError);
    });
  }

  @action
  void removeSearchHistoryItem(int index) {
    if (index >= 0 && index < searchHistory.length) {
      searchHistory.removeAt(index);
    }
    updateStatSearchHistory();
  }

  @action
  void addSearchHistoryItem(String item) {
    if (searchHistory.contains(item)) return;
    searchHistory.insert(0, item);
    updateStatSearchHistory();
  }

  @action
  void toggleIsSearched() {
    isSearched = !isSearched;
  }

  @action
  void resetIsSearched() {
    isSearched = false;
  }

  @action
  void setIsFiltered(bool value) {
    isFiltered = value;
  }

  @action
  void resetErrorString() {
    errorString = '';
  }

}