// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_or_signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginOrSignupStore on _LoginOrSignupStore, Store {
  late final _$isLoginScreenAtom =
      Atom(name: '_LoginOrSignupStore.isLoginScreen', context: context);

  @override
  bool get isLoginScreen {
    _$isLoginScreenAtom.reportRead();
    return super.isLoginScreen;
  }

  @override
  set isLoginScreen(bool value) {
    _$isLoginScreenAtom.reportWrite(value, super.isLoginScreen, () {
      super.isLoginScreen = value;
    });
  }

  late final _$_LoginOrSignupStoreActionController =
      ActionController(name: '_LoginOrSignupStore', context: context);

  @override
  void toggleChangeScreen() {
    final _$actionInfo = _$_LoginOrSignupStoreActionController.startAction(
        name: '_LoginOrSignupStore.toggleChangeScreen');
    try {
      return super.toggleChangeScreen();
    } finally {
      _$_LoginOrSignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoginScreen: ${isLoginScreen}
    ''';
  }
}
