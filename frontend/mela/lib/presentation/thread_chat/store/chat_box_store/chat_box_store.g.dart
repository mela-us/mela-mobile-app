// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_box_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatBoxStore on _ChatBoxStore, Store {
  late final _$showSendIconAtom =
      Atom(name: '_ChatBoxStore.showSendIcon', context: context);

  @override
  bool get showSendIcon {
    _$showSendIconAtom.reportRead();
    return super.showSendIcon;
  }

  @override
  set showSendIcon(bool value) {
    _$showSendIconAtom.reportWrite(value, super.showSendIcon, () {
      super.showSendIcon = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ChatBoxStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_ChatBoxStoreActionController =
      ActionController(name: '_ChatBoxStore', context: context);

  @override
  void setShowSendIcon(bool value) {
    final _$actionInfo = _$_ChatBoxStoreActionController.startAction(
        name: '_ChatBoxStore.setShowSendIcon');
    try {
      return super.setShowSendIcon(value);
    } finally {
      _$_ChatBoxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_ChatBoxStoreActionController.startAction(
        name: '_ChatBoxStore.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_ChatBoxStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showSendIcon: ${showSendIcon},
isLoading: ${isLoading}
    ''';
  }
}
