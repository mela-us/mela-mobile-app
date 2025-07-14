// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserLoginStore on _UserLoginStore, Store {
  Computed<bool>? _$isSetLoginLoadingComputed;

  @override
  bool get isSetLoginLoading => (_$isSetLoginLoadingComputed ??= Computed<bool>(
          () => super.isSetLoginLoading,
          name: '_UserLoginStore.isSetLoginLoading'))
      .value;

  late final _$isLoggedInAtom =
      Atom(name: '_UserLoginStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$isPasswordVisibleAtom =
      Atom(name: '_UserLoginStore.isPasswordVisible', context: context);

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

  late final _$loginFutureAtom =
      Atom(name: '_UserLoginStore.loginFuture', context: context);

  @override
  ObservableFuture<TokenModel?> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<TokenModel?> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  late final _$setIsLoginFutureAtom =
      Atom(name: '_UserLoginStore.setIsLoginFuture', context: context);

  @override
  ObservableFuture<void> get setIsLoginFuture {
    _$setIsLoginFutureAtom.reportRead();
    return super.setIsLoginFuture;
  }

  @override
  set setIsLoginFuture(ObservableFuture<void> value) {
    _$setIsLoginFutureAtom.reportWrite(value, super.setIsLoginFuture, () {
      super.setIsLoginFuture = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_UserLoginStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_UserLoginStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$emailErrorAtom =
      Atom(name: '_UserLoginStore.emailError', context: context);

  @override
  String get emailError {
    _$emailErrorAtom.reportRead();
    return super.emailError;
  }

  @override
  set emailError(String value) {
    _$emailErrorAtom.reportWrite(value, super.emailError, () {
      super.emailError = value;
    });
  }

  late final _$passwordErrorAtom =
      Atom(name: '_UserLoginStore.passwordError', context: context);

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

  late final _$isLoadingLoginAtom =
      Atom(name: '_UserLoginStore.isLoadingLogin', context: context);

  @override
  bool get isLoadingLogin {
    _$isLoadingLoginAtom.reportRead();
    return super.isLoadingLogin;
  }

  @override
  set isLoadingLogin(bool value) {
    _$isLoadingLoginAtom.reportWrite(value, super.isLoadingLogin, () {
      super.isLoadingLogin = value;
    });
  }

  late final _$setIsLoginAsyncAction =
      AsyncAction('_UserLoginStore.setIsLogin', context: context);

  @override
  Future<dynamic> setIsLogin() {
    return _$setIsLoginAsyncAction.run(() => super.setIsLogin());
  }

  late final _$loginAsyncAction =
      AsyncAction('_UserLoginStore.login', context: context);

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$loginWithGoogleAsyncAction =
      AsyncAction('_UserLoginStore.loginWithGoogle', context: context);

  @override
  Future<dynamic> loginWithGoogle(String? idToken, String? accessToken) {
    return _$loginWithGoogleAsyncAction
        .run(() => super.loginWithGoogle(idToken, accessToken));
  }

  late final _$_UserLoginStoreActionController =
      ActionController(name: '_UserLoginStore', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_UserLoginStoreActionController.startAction(
        name: '_UserLoginStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_UserLoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_UserLoginStoreActionController.startAction(
        name: '_UserLoginStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_UserLoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$_UserLoginStoreActionController.startAction(
        name: '_UserLoginStore.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$_UserLoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoadingLogin(bool value) {
    final _$actionInfo = _$_UserLoginStoreActionController.startAction(
        name: '_UserLoginStore.setLoadingLogin');
    try {
      return super.setLoadingLogin(value);
    } finally {
      _$_UserLoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetSettingForLogin() {
    final _$actionInfo = _$_UserLoginStoreActionController.startAction(
        name: '_UserLoginStore.resetSettingForLogin');
    try {
      return super.resetSettingForLogin();
    } finally {
      _$_UserLoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isPasswordVisible: ${isPasswordVisible},
loginFuture: ${loginFuture},
setIsLoginFuture: ${setIsLoginFuture},
email: ${email},
password: ${password},
emailError: ${emailError},
passwordError: ${passwordError},
isLoadingLogin: ${isLoadingLogin},
isSetLoginLoading: ${isSetLoginLoading}
    ''';
  }
}
