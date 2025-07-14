// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateNewPasswordStore on _CreateNewPasswordStore, Store {
  Computed<bool>? _$isLoadingChangePasswordComputed;

  @override
  bool get isLoadingChangePassword => (_$isLoadingChangePasswordComputed ??=
          Computed<bool>(() => super.isLoadingChangePassword,
              name: '_CreateNewPasswordStore.isLoadingChangePassword'))
      .value;

  late final _$isPasswordVisibleAtom =
      Atom(name: '_CreateNewPasswordStore.isPasswordVisible', context: context);

  @override
  bool get isPasswordVisible {
    _$isPasswordVisibleAtom.reportRead();
    return super.isPasswordVisible;
  }

  @override
  set isPasswordVisible(bool value) {
    _$isPasswordVisibleAtom.reportWrite(value, super.isPasswordVisible, () {
      super.isPasswordVisible = value;
    });
  }

  late final _$isConfirmedPasswordVisibleAtom = Atom(
      name: '_CreateNewPasswordStore.isConfirmedPasswordVisible',
      context: context);

  @override
  bool get isConfirmedPasswordVisible {
    _$isConfirmedPasswordVisibleAtom.reportRead();
    return super.isConfirmedPasswordVisible;
  }

  @override
  set isConfirmedPasswordVisible(bool value) {
    _$isConfirmedPasswordVisibleAtom
        .reportWrite(value, super.isConfirmedPasswordVisible, () {
      super.isConfirmedPasswordVisible = value;
    });
  }

  late final _$changePasswordFutureAtom = Atom(
      name: '_CreateNewPasswordStore.changePasswordFuture', context: context);

  @override
  ObservableFuture<void> get changePasswordFuture {
    _$changePasswordFutureAtom.reportRead();
    return super.changePasswordFuture;
  }

  @override
  set changePasswordFuture(ObservableFuture<void> value) {
    _$changePasswordFutureAtom.reportWrite(value, super.changePasswordFuture,
        () {
      super.changePasswordFuture = value;
    });
  }

  late final _$passwordErrorAtom =
      Atom(name: '_CreateNewPasswordStore.passwordError', context: context);

  @override
  String get passwordError {
    _$passwordErrorAtom.reportRead();
    return super.passwordError;
  }

  @override
  set passwordError(String value) {
    _$passwordErrorAtom.reportWrite(value, super.passwordError, () {
      super.passwordError = value;
    });
  }

  late final _$confirmedPasswordErrorAtom = Atom(
      name: '_CreateNewPasswordStore.confirmedPasswordError', context: context);

  @override
  String get confirmedPasswordError {
    _$confirmedPasswordErrorAtom.reportRead();
    return super.confirmedPasswordError;
  }

  @override
  set confirmedPasswordError(String value) {
    _$confirmedPasswordErrorAtom
        .reportWrite(value, super.confirmedPasswordError, () {
      super.confirmedPasswordError = value;
    });
  }

  late final _$changePasswordInForgotPasswordScreenAsyncAction = AsyncAction(
      '_CreateNewPasswordStore.changePasswordInForgotPasswordScreen',
      context: context);

  @override
  Future<dynamic> changePasswordInForgotPasswordScreen(String newPassword) {
    return _$changePasswordInForgotPasswordScreenAsyncAction
        .run(() => super.changePasswordInForgotPasswordScreen(newPassword));
  }

  late final _$_CreateNewPasswordStoreActionController =
      ActionController(name: '_CreateNewPasswordStore', context: context);

  @override
  void setErrorPassword(String value) {
    final _$actionInfo = _$_CreateNewPasswordStoreActionController.startAction(
        name: '_CreateNewPasswordStore.setErrorPassword');
    try {
      return super.setErrorPassword(value);
    } finally {
      _$_CreateNewPasswordStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorConfirmedPassword(String password, String confirmedPassword) {
    final _$actionInfo = _$_CreateNewPasswordStoreActionController.startAction(
        name: '_CreateNewPasswordStore.setErrorConfirmedPassword');
    try {
      return super.setErrorConfirmedPassword(password, confirmedPassword);
    } finally {
      _$_CreateNewPasswordStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$_CreateNewPasswordStoreActionController.startAction(
        name: '_CreateNewPasswordStore.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$_CreateNewPasswordStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleConfirmedPasswordVisibility() {
    final _$actionInfo = _$_CreateNewPasswordStoreActionController.startAction(
        name: '_CreateNewPasswordStore.toggleConfirmedPasswordVisibility');
    try {
      return super.toggleConfirmedPasswordVisibility();
    } finally {
      _$_CreateNewPasswordStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isPasswordVisible: ${isPasswordVisible},
isConfirmedPasswordVisible: ${isConfirmedPasswordVisible},
changePasswordFuture: ${changePasswordFuture},
passwordError: ${passwordError},
confirmedPasswordError: ${confirmedPasswordError},
isLoadingChangePassword: ${isLoadingChangePassword}
    ''';
  }
}
