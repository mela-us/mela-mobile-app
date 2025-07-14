import 'package:mobx/mobx.dart';

part 'stat_filter_store.g.dart';

class StatFilterStore = _StatFilterStore with _$StatFilterStore;

abstract class _StatFilterStore with Store {
  @observable
  bool isAscendingSelected = false;
  @observable
  bool isDescendingSelected = false;
  @observable
  bool isInProgressSelected = false;
  @observable
  bool isCompletedSelected = false;

  @observable
  bool isFilterButtonPressed = false;

  @action
  void setIsFilteredButtonPressed(bool value) {
    isFilterButtonPressed = value;
  }

  @action
  void toggleAscending() {
    isAscendingSelected = !isAscendingSelected;
    isDescendingSelected = !isAscendingSelected;
  }

  @action
  void toggleDescending() {
    isDescendingSelected = !isDescendingSelected;
    isAscendingSelected = !isDescendingSelected;
  }

  @action
  void toggleInProgress() {
    isInProgressSelected = !isInProgressSelected;
  }

  @action
  void toggleCompleted() {
    isCompletedSelected = !isCompletedSelected;
  }

  @action
  void resetFilter() {
    isAscendingSelected = false;
    isDescendingSelected = false;
    isInProgressSelected = false;
    isCompletedSelected = false;
    isFilterButtonPressed = false;
  }
}