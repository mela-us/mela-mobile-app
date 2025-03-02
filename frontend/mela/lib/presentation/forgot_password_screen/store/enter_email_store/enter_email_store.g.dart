// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enter_email_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EnterEmailStore on _EnterEmailStore, Store {
  Computed<bool>? _$isLoadingVerifyEmailComputed;

  @override
  bool get isLoadingVerifyEmail => (_$isLoadingVerifyEmailComputed ??=
          Computed<bool>(() => super.isLoadingVerifyEmail,
              name: '_EnterEmailStore.isLoadingVerifyEmail'))
      .value;

  late final _$emailAtom =
      Atom(name: '_EnterEmailStore.email', context: context);

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

  late final _$emailErrorAtom =
      Atom(name: '_EnterEmailStore.emailError', context: context);

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

  late final _$verifyEmailFutureAtom =
      Atom(name: '_EnterEmailStore.verifyEmailFuture', context: context);

  @override
  ObservableFuture<void> get verifyEmailFuture {
    _$verifyEmailFutureAtom.reportRead();
    return super.verifyEmailFuture;
  }

  @override
  set verifyEmailFuture(ObservableFuture<void> value) {
    _$verifyEmailFutureAtom.reportWrite(value, super.verifyEmailFuture, () {
      super.verifyEmailFuture = value;
    });
  }

  late final _$verifyEmailAsyncAction =
      AsyncAction('_EnterEmailStore.verifyEmail', context: context);

  @override
  Future<dynamic> verifyEmail(String emailText) {
    return _$verifyEmailAsyncAction.run(() => super.verifyEmail(emailText));
  }

  late final _$_EnterEmailStoreActionController =
      ActionController(name: '_EnterEmailStore', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_EnterEmailStoreActionController.startAction(
        name: '_EnterEmailStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_EnterEmailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_EnterEmailStoreActionController.startAction(
        name: '_EnterEmailStore.reset');
    try {
      return super.reset();
    } finally {
      _$_EnterEmailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
emailError: ${emailError},
verifyEmailFuture: ${verifyEmailFuture},
isLoadingVerifyEmail: ${isLoadingVerifyEmail}
    ''';
  }
}
