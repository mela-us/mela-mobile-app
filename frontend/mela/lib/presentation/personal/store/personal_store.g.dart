// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PersonalStore on _PersonalStore, Store {
  late final _$userNameAtom =
      Atom(name: '_PersonalStore.userName', context: context);

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$_PersonalStoreActionController =
      ActionController(name: '_PersonalStore', context: context);

  @override
  void updateUserName(String name) {
    final _$actionInfo = _$_PersonalStoreActionController.startAction(
        name: '_PersonalStore.updateUserName');
    try {
      return super.updateUserName(name);
    } finally {
      _$_PersonalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo = _$_PersonalStoreActionController.startAction(
        name: '_PersonalStore.logout');
    try {
      return super.logout();
    } finally {
      _$_PersonalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userName: ${userName}
    ''';
  }
}
