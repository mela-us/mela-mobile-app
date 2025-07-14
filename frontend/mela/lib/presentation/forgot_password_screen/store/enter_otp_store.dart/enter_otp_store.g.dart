// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enter_otp_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EnterOTPStore on _EnterOTPStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_EnterOTPStore.isLoading'))
          .value;

  late final _$timeLeftAtom =
      Atom(name: '_EnterOTPStore.timeLeft', context: context);

  @override
  int get timeLeft {
    _$timeLeftAtom.reportRead();
    return super.timeLeft;
  }

  @override
  set timeLeft(int value) {
    _$timeLeftAtom.reportWrite(value, super.timeLeft, () {
      super.timeLeft = value;
    });
  }

  late final _$canResendAtom =
      Atom(name: '_EnterOTPStore.canResend', context: context);

  @override
  bool get canResend {
    _$canResendAtom.reportRead();
    return super.canResend;
  }

  @override
  set canResend(bool value) {
    _$canResendAtom.reportWrite(value, super.canResend, () {
      super.canResend = value;
    });
  }

  late final _$verifyOTPFutureAtom =
      Atom(name: '_EnterOTPStore.verifyOTPFuture', context: context);

  @override
  ObservableFuture<void> get verifyOTPFuture {
    _$verifyOTPFutureAtom.reportRead();
    return super.verifyOTPFuture;
  }

  @override
  set verifyOTPFuture(ObservableFuture<void> value) {
    _$verifyOTPFutureAtom.reportWrite(value, super.verifyOTPFuture, () {
      super.verifyOTPFuture = value;
    });
  }

  late final _$verifyOTPAsyncAction =
      AsyncAction('_EnterOTPStore.verifyOTP', context: context);

  @override
  Future<void> verifyOTP() {
    return _$verifyOTPAsyncAction.run(() => super.verifyOTP());
  }

  late final _$resendOTPAsyncAction =
      AsyncAction('_EnterOTPStore.resendOTP', context: context);

  @override
  Future<void> resendOTP() {
    return _$resendOTPAsyncAction.run(() => super.resendOTP());
  }

  late final _$_EnterOTPStoreActionController =
      ActionController(name: '_EnterOTPStore', context: context);

  @override
  void startTimer() {
    final _$actionInfo = _$_EnterOTPStoreActionController.startAction(
        name: '_EnterOTPStore.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_EnterOTPStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
timeLeft: ${timeLeft},
canResend: ${canResend},
verifyOTPFuture: ${verifyOTPFuture},
isLoading: ${isLoading}
    ''';
  }
}
