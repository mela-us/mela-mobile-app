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

  @override
  String toString() {
    return '''
verifyEmailFuture: ${verifyEmailFuture},
isLoadingVerifyEmail: ${isLoadingVerifyEmail}
    ''';
  }
}
