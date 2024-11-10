// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserSignupStore on _UserSignupStore, Store {
  Computed<bool>? _$isSignupLoadingComputed;

  @override
  bool get isSignupLoading =>
      (_$isSignupLoadingComputed ??= Computed<bool>(() => super.isSignupLoading,
              name: '_UserSignupStore.isSignupLoading'))
          .value;

  late final _$isSignupSuccessfulAtom =
      Atom(name: '_UserSignupStore.isSignupSuccessful', context: context);

  @override
  bool get isSignupSuccessful {
    _$isSignupSuccessfulAtom.reportRead();
    return super.isSignupSuccessful;
  }

  @override
  set isSignupSuccessful(bool value) {
    _$isSignupSuccessfulAtom.reportWrite(value, super.isSignupSuccessful, () {
      super.isSignupSuccessful = value;
    });
  }

  late final _$isPasswordVisibleAtom =
      Atom(name: '_UserSignupStore.isPasswordVisible', context: context);

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

  late final _$isAcceptedAtom =
      Atom(name: '_UserSignupStore.isAccepted', context: context);

  @override
  bool get isAccepted {
    _$isAcceptedAtom.reportRead();
    return super.isAccepted;
  }

  @override
  set isAccepted(bool value) {
    _$isAcceptedAtom.reportWrite(value, super.isAccepted, () {
      super.isAccepted = value;
    });
  }

  late final _$signUpFutureAtom =
      Atom(name: '_UserSignupStore.signUpFuture', context: context);

  @override
  ObservableFuture<void> get signUpFuture {
    _$signUpFutureAtom.reportRead();
    return super.signUpFuture;
  }

  @override
  set signUpFuture(ObservableFuture<void> value) {
    _$signUpFutureAtom.reportWrite(value, super.signUpFuture, () {
      super.signUpFuture = value;
    });
  }

  late final _$signUpAsyncAction =
      AsyncAction('_UserSignupStore.signUp', context: context);

  @override
  Future<void> signUp(String email, String password) {
    return _$signUpAsyncAction.run(() => super.signUp(email, password));
  }

  late final _$_UserSignupStoreActionController =
      ActionController(name: '_UserSignupStore', context: context);

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$_UserSignupStoreActionController.startAction(
        name: '_UserSignupStore.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$_UserSignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAccepted() {
    final _$actionInfo = _$_UserSignupStoreActionController.startAction(
        name: '_UserSignupStore.toggleAccepted');
    try {
      return super.toggleAccepted();
    } finally {
      _$_UserSignupStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSignupSuccessful: ${isSignupSuccessful},
isPasswordVisible: ${isPasswordVisible},
isAccepted: ${isAccepted},
signUpFuture: ${signUpFuture},
isSignupLoading: ${isSignupLoading}
    ''';
  }
}
