// import 'package:mobx/mobx.dart';
//
// part 'stat_filter_store.g.dart';
//
// class StatFilterStore = _StatFilterStore with _$StatFilterStore;
//
// abstract class _StatFilterStore with Store {
//   @observable
//   bool isPrimarySelected = false;
//   @observable
//   bool isSecondarySelected = false;
//   @observable
//   bool isHighSchoolSelected = false;
//   @observable
//   bool isNotStartedSelected = false;
//   @observable
//   bool isInProgressSelected = false;
//   @observable
//   bool isCompletedSelected = false;
//   @observable
//   double startPercentage = 0.0;
//   @observable
//   double endPercentage = 100.0;
//   @observable
//   int? selectedRangeIndex;
//   @observable
//   bool isFilterButtonPressed = false;
//
//   @action
//   void setIsFilteredButtonPressed(bool value) {
//     isFilterButtonPressed = value;
//   }
//
//   @action
//   void togglePrimary() {
//     isPrimarySelected = !isPrimarySelected;
//   }
//
//   @action
//   void toggleSecondary() {
//     isSecondarySelected = !isSecondarySelected;
//   }
//
//   @action
//   void toggleHighSchool() {
//     isHighSchoolSelected = !isHighSchoolSelected;
//   }
//
//   @action
//   void toggleNotStarted() {
//     isNotStartedSelected = !isNotStartedSelected;
//   }
//
//   @action
//   void toggleInProgress() {
//     isInProgressSelected = !isInProgressSelected;
//   }
//
//   @action
//   void toggleCompleted() {
//     isCompletedSelected = !isCompletedSelected;
//   }
//
//   @action
//   void changeStartPercentage(double value) {
//     startPercentage = value;
//   }
//
//   @action
//   void changeEndPercentage(double value) {
//     endPercentage = value;
//   }
//
//   @action
//   void resetFilter() {
//     isPrimarySelected = false;
//     isSecondarySelected = false;
//     isHighSchoolSelected = false;
//     isNotStartedSelected = false;
//     isInProgressSelected = false;
//     isCompletedSelected = false;
//     startPercentage = 0.0;
//     endPercentage = 100.0;
//     selectedRangeIndex = null;
//     isFilterButtonPressed = false;
//   }
//
//   @action
//   void setSelectedRangeIndex(int index) {
//     selectedRangeIndex = index;
//   }
//
//   @action
//   void resetSelectedRangeIndex() {
//     selectedRangeIndex = null;
//   }
// }