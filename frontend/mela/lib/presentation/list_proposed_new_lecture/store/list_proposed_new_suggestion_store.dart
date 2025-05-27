import 'package:mela/domain/entity/suggestion/suggestion.dart';
import 'package:mela/domain/usecase/suggestion/get_proposed_new_suggestion_usecase.dart';
import 'package:mela/domain/usecase/suggestion/update_suggestion_usecase.dart';
import 'package:mobx/mobx.dart';

part 'list_proposed_new_suggestion_store.g.dart';

// This is the class used by rest of your codebase
class ListProposedNewSuggestionStore = _ListProposedNewSuggestionStore
    with _$ListProposedNewSuggestionStore;

abstract class _ListProposedNewSuggestionStore with Store {
  // UseCase
  final GetProposedNewSuggestionUsecase _getProposedNewSuggestionUsecase;
  final UpdateSuggestionUsecase _updateSuggestionUsecase;
  _ListProposedNewSuggestionStore(
      this._getProposedNewSuggestionUsecase, this._updateSuggestionUsecase);
  @observable
  bool isLoading = false;

  @observable
  bool isUnAuthorized = false;

  @action
  void setLoading(bool value) {
    isLoading = value;
  }

  @action
  void setUnAuthorized(bool value) {
    isUnAuthorized = value;
  }

  @observable
  ListSuggestion? suggestionList;

  @action
  Future<void> getProposedNewLecture() async {
    setLoading(true);
    try {
      setLoading(true);
      // Simulate a network call
      suggestionList = await _getProposedNewSuggestionUsecase.call();
    } catch (e) {
      suggestionList = null;
      // Handle error
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> updateSuggestion(String suggestionId, String lectureId,
      int ordinalNumber, bool isDone) async {
    setLoading(true);
    try {
      print("Sa1 ==>Updating suggestion: $suggestionId, $lectureId, $ordinalNumber, $isDone");
      await _updateSuggestionUsecase.call(
          params: UpdateSuggestionParams(
        suggestionId: suggestionId,
        lectureId: lectureId,
        ordinalNumber: ordinalNumber,
        isDone: isDone,
      ));
    } catch (e) {
      // Handle error
    } finally {
      setLoading(false);
    }
  }
}
