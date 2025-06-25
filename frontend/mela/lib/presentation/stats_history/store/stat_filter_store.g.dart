// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StatFilterStore on _StatFilterStore, Store {
  late final _$isAscendingSelectedAtom =
      Atom(name: '_StatFilterStore.isAscendingSelected', context: context);

  @override
  bool get isAscendingSelected {
    _$isAscendingSelectedAtom.reportRead();
    return super.isAscendingSelected;
  }

  @override
  set isAscendingSelected(bool value) {
    _$isAscendingSelectedAtom.reportWrite(value, super.isAscendingSelected, () {
      super.isAscendingSelected = value;
    });
  }

  late final _$isDescendingSelectedAtom =
      Atom(name: '_StatFilterStore.isDescendingSelected', context: context);

  @override
  bool get isDescendingSelected {
    _$isDescendingSelectedAtom.reportRead();
    return super.isDescendingSelected;
  }

  @override
  set isDescendingSelected(bool value) {
    _$isDescendingSelectedAtom.reportWrite(value, super.isDescendingSelected,
        () {
      super.isDescendingSelected = value;
    });
  }

  late final _$isInProgressSelectedAtom =
      Atom(name: '_StatFilterStore.isInProgressSelected', context: context);

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
      Atom(name: '_StatFilterStore.isCompletedSelected', context: context);

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

  late final _$isFilterButtonPressedAtom =
      Atom(name: '_StatFilterStore.isFilterButtonPressed', context: context);

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

  late final _$_StatFilterStoreActionController =
      ActionController(name: '_StatFilterStore', context: context);

  @override
  void setIsFilteredButtonPressed(bool value) {
    final _$actionInfo = _$_StatFilterStoreActionController.startAction(
        name: '_StatFilterStore.setIsFilteredButtonPressed');
    try {
      return super.setIsFilteredButtonPressed(value);
    } finally {
      _$_StatFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAscending() {
    final _$actionInfo = _$_StatFilterStoreActionController.startAction(
        name: '_StatFilterStore.toggleAscending');
    try {
      return super.toggleAscending();
    } finally {
      _$_StatFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleDescending() {
    final _$actionInfo = _$_StatFilterStoreActionController.startAction(
        name: '_StatFilterStore.toggleDescending');
    try {
      return super.toggleDescending();
    } finally {
      _$_StatFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleInProgress() {
    final _$actionInfo = _$_StatFilterStoreActionController.startAction(
        name: '_StatFilterStore.toggleInProgress');
    try {
      return super.toggleInProgress();
    } finally {
      _$_StatFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleCompleted() {
    final _$actionInfo = _$_StatFilterStoreActionController.startAction(
        name: '_StatFilterStore.toggleCompleted');
    try {
      return super.toggleCompleted();
    } finally {
      _$_StatFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFilter() {
    final _$actionInfo = _$_StatFilterStoreActionController.startAction(
        name: '_StatFilterStore.resetFilter');
    try {
      return super.resetFilter();
    } finally {
      _$_StatFilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAscendingSelected: ${isAscendingSelected},
isDescendingSelected: ${isDescendingSelected},
isInProgressSelected: ${isInProgressSelected},
isCompletedSelected: ${isCompletedSelected},
isFilterButtonPressed: ${isFilterButtonPressed}
    ''';
  }
}
