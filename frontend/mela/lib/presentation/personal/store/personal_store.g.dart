// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PersonalStore on _PersonalStore, Store {
  Computed<bool>? _$progressLoadingComputed;

  @override
  bool get progressLoading =>
      (_$progressLoadingComputed ??= Computed<bool>(() => super.progressLoading,
              name: '_PersonalStore.progressLoading'))
          .value;
  Computed<bool>? _$detailedProgressLoadingComputed;

  @override
  bool get detailedProgressLoading => (_$detailedProgressLoadingComputed ??=
          Computed<bool>(() => super.detailedProgressLoading,
              name: '_PersonalStore.detailedProgressLoading'))
      .value;

  late final _$fetchFutureAtom =
      Atom(name: '_PersonalStore.fetchFuture', context: context);

  @override
  ObservableFuture<User?> get fetchFuture {
    _$fetchFutureAtom.reportRead();
    return super.fetchFuture;
  }

  @override
  set fetchFuture(ObservableFuture<User?> value) {
    _$fetchFutureAtom.reportWrite(value, super.fetchFuture, () {
      super.fetchFuture = value;
    });
  }

  late final _$userAtom = Atom(name: '_PersonalStore.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_PersonalStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$getUserInfoAsyncAction =
      AsyncAction('_PersonalStore.getUserInfo', context: context);

  @override
  Future<dynamic> getUserInfo() {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo());
  }

  @override
  String toString() {
    return '''
fetchFuture: ${fetchFuture},
user: ${user},
success: ${success},
progressLoading: ${progressLoading},
detailedProgressLoading: ${detailedProgressLoading}
    ''';
  }
}
