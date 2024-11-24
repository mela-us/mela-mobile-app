import 'package:http/http.dart';
import 'package:mela/domain/usecase/stat/get_stat_search_history_usecase.dart';
import 'package:mobx/mobx.dart';
import '../../../di/service_locator.dart';
import '../../../domain/entity/stat/progress_list.dart';
import '../../../domain/usecase/stat/get_stat_search_result_usecase.dart';
// Include generated file
part 'stat_search_store.g.dart';

// This is the class used by rest of your codebase
class StatSearchStore = _StatSearchStore with _$StatSearchStore;

abstract class _StatSearchStore with Store {
  //UseCase
  GetStatSearchHistoryUseCase _getStatSearchHistoryUseCase;
  GetStatSearchResultUseCase _getStatSearchResultUseCase;

  //Constructor
  _StatSearchStore(this._getStatSearchResultUseCase, this._getStatSearchHistoryUseCase);

  @observable
  bool isSearched = false; //check press enter to search or not

  @observable
  bool isFiltered = false;

  @observable
  String errorString = '';

  @observable
  List<String>? searchHistory;

  @observable
  ProgressList? listAfterSearchingAndFiltering;

  @observable
  ProgressList?
  listAfterSearching;

  @computed
  bool get isLoadingSearch =>
      fetchAfterSearchingFuture.status == FutureStatus.pending;
  @computed
  bool get isLoadingHistorySearch =>
      fetchHistorySearchFuture.status == FutureStatus.pending;

  @observable
  ObservableFuture<ProgressList?> fetchAfterSearchingFuture =
  ObservableFuture<ProgressList?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<List<String>?> fetchHistorySearchFuture =
  ObservableFuture<List<String>?>(ObservableFuture.value(null));

  @action
  Future getStatSearchHistory() async {
    final future = _getStatSearchHistoryUseCase.call(params: null);
    fetchHistorySearchFuture = ObservableFuture(future);
    future.then((value) {
      this.searchHistory = value;
    }).catchError((onError) {
      this.searchHistory = null;
      print(onError);
    });
  }

  @action
  Future getAfterSearch(String txtSearching) async {
    final future = _getStatSearchResultUseCase.call(params: txtSearching);
    fetchAfterSearchingFuture = ObservableFuture(future);

    try {
      final value = await future;
      this.listAfterSearching = value;
      this.errorString = '';
    } catch (onError) {
      this.listAfterSearching = null;
      updateAfterSeachingAndFiltering(null);
      print(onError);
      this.errorString = onError.toString();
    }
  }

  @action
  void updateAfterSeachingAndFiltering(ProgressList? value) {
    // print("Chieu dai cua  list luc truoc: ");
    // if (lecturesAfterSearchingAndFiltering != null) {
    //   print(lecturesAfterSearchingAndFiltering!.lectures.length);
    // }

    listAfterSearchingAndFiltering = value;
    // print("Chieu dai cua  list luc sau: ");
    // print(lecturesAfterSearchingAndFiltering!.lectures.length);
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