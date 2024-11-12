// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilterStore on _FilterStore, Store {
  late final _$isPrimarySelectedAtom =
      Atom(name: '_FilterStore.isPrimarySelected', context: context);

  @override
  bool get isPrimarySelected {
    _$isPrimarySelectedAtom.reportRead();
    return super.isPrimarySelected;
  }

  @override
  set isPrimarySelected(bool value) {
    _$isPrimarySelectedAtom.reportWrite(value, super.isPrimarySelected, () {
      super.isPrimarySelected = value;
    });
  }

  late final _$isSecondarySelectedAtom =
      Atom(name: '_FilterStore.isSecondarySelected', context: context);

  @override
  bool get isSecondarySelected {
    _$isSecondarySelectedAtom.reportRead();
    return super.isSecondarySelected;
  }

  @override
  set isSecondarySelected(bool value) {
    _$isSecondarySelectedAtom.reportWrite(value, super.isSecondarySelected, () {
      super.isSecondarySelected = value;
    });
  }

  late final _$isHighSchoolSelectedAtom =
      Atom(name: '_FilterStore.isHighSchoolSelected', context: context);

  @override
  bool get isHighSchoolSelected {
    _$isHighSchoolSelectedAtom.reportRead();
    return super.isHighSchoolSelected;
  }

  @override
  set isHighSchoolSelected(bool value) {
    _$isHighSchoolSelectedAtom.reportWrite(value, super.isHighSchoolSelected,
        () {
      super.isHighSchoolSelected = value;
    });
  }

  late final _$isNotStartedSelectedAtom =
      Atom(name: '_FilterStore.isNotStartedSelected', context: context);

  @override
  bool get isNotStartedSelected {
    _$isNotStartedSelectedAtom.reportRead();
    return super.isNotStartedSelected;
  }

  @override
  set isNotStartedSelected(bool value) {
    _$isNotStartedSelectedAtom.reportWrite(value, super.isNotStartedSelected,
        () {
      super.isNotStartedSelected = value;
    });
  }

  late final _$isInProgressSelectedAtom =
      Atom(name: '_FilterStore.isInProgressSelected', context: context);

  @override
  bool get isInProgressSelected {
    _$isInProgressSelectedAtom.reportRead();
    return super.isInProgressSelected;
  }

  @override
  set isInProgressSelected(bool value) {
    _$isInProgressSelectedAtom.reportWrite(value, super.isInProgressSelected,
        () {
      super.isInProgressSelected = value;
    });
  }

  late final _$isCompletedSelectedAtom =
      Atom(name: '_FilterStore.isCompletedSelected', context: context);

  @override
  bool get isCompletedSelected {
    _$isCompletedSelectedAtom.reportRead();
    return super.isCompletedSelected;
  }

  @override
  set isCompletedSelected(bool value) {
    _$isCompletedSelectedAtom.reportWrite(value, super.isCompletedSelected, () {
      super.isCompletedSelected = value;
    });
  }

  late final _$startPercentageAtom =
      Atom(name: '_FilterStore.startPercentage', context: context);

  @override
  double get startPercentage {
    _$startPercentageAtom.reportRead();
    return super.startPercentage;
  }

  @override
  set startPercentage(double value) {
    _$startPercentageAtom.reportWrite(value, super.startPercentage, () {
      super.startPercentage = value;
    });
  }

  late final _$endPercentageAtom =
      Atom(name: '_FilterStore.endPercentage', context: context);

  @override
  double get endPercentage {
    _$endPercentageAtom.reportRead();
    return super.endPercentage;
  }

  @override
  set endPercentage(double value) {
    _$endPercentageAtom.reportWrite(value, super.endPercentage, () {
      super.endPercentage = value;
    });
  }

  late final _$selectedRangeIndexAtom =
      Atom(name: '_FilterStore.selectedRangeIndex', context: context);

  @override
  int? get selectedRangeIndex {
    _$selectedRangeIndexAtom.reportRead();
    return super.selectedRangeIndex;
  }

  @override
  set selectedRangeIndex(int? value) {
    _$selectedRangeIndexAtom.reportWrite(value, super.selectedRangeIndex, () {
      super.selectedRangeIndex = value;
    });
  }

  late final _$isFilterButtonPressedAtom =
      Atom(name: '_FilterStore.isFilterButtonPressed', context: context);

  @override
  bool get isFilterButtonPressed {
    _$isFilterButtonPressedAtom.reportRead();
    return super.isFilterButtonPressed;
  }

  @override
  set isFilterButtonPressed(bool value) {
    _$isFilterButtonPressedAtom.reportWrite(value, super.isFilterButtonPressed,
        () {
      super.isFilterButtonPressed = value;
    });
  }

  late final _$_FilterStoreActionController =
      ActionController(name: '_FilterStore', context: context);

  @override
  void setIsFilteredButtonPressed(bool value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setIsFilteredButtonPressed');
    try {
      return super.setIsFilteredButtonPressed(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePrimary() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.togglePrimary');
    try {
      return super.togglePrimary();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSecondary() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.toggleSecondary');
    try {
      return super.toggleSecondary();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleHighSchool() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.toggleHighSchool');
    try {
      return super.toggleHighSchool();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleNotStarted() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.toggleNotStarted');
    try {
      return super.toggleNotStarted();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleInProgress() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.toggleInProgress');
    try {
      return super.toggleInProgress();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleCompleted() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.toggleCompleted');
    try {
      return super.toggleCompleted();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeStartPercentage(double value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.changeStartPercentage');
    try {
      return super.changeStartPercentage(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeEndPercentage(double value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.changeEndPercentage');
    try {
      return super.changeEndPercentage(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFilter() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.resetFilter');
    try {
      return super.resetFilter();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedRangeIndex(int index) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setSelectedRangeIndex');
    try {
      return super.setSelectedRangeIndex(index);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetSelectedRangeIndex() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.resetSelectedRangeIndex');
    try {
      return super.resetSelectedRangeIndex();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isPrimarySelected: ${isPrimarySelected},
isSecondarySelected: ${isSecondarySelected},
isHighSchoolSelected: ${isHighSchoolSelected},
isNotStartedSelected: ${isNotStartedSelected},
isInProgressSelected: ${isInProgressSelected},
isCompletedSelected: ${isCompletedSelected},
startPercentage: ${startPercentage},
endPercentage: ${endPercentage},
selectedRangeIndex: ${selectedRangeIndex},
isFilterButtonPressed: ${isFilterButtonPressed}
    ''';
  }
}
