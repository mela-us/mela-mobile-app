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

  late final _$isLoadingAtom =
      Atom(name: '_PersonalStore.isLoading', context: context);

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

  late final _$logout_successAtom =
      Atom(name: '_PersonalStore.logout_success', context: context);

  @override
  bool get logout_success {
    _$logout_successAtom.reportRead();
    return super.logout_success;
  }

  @override
  set logout_success(bool value) {
    _$logout_successAtom.reportWrite(value, super.logout_success, () {
      super.logout_success = value;
    });
  }

  late final _$getUserInfoAsyncAction =
      AsyncAction('_PersonalStore.getUserInfo', context: context);

  @override
  Future<dynamic> getUserInfo() {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo());
  }

  late final _$updateNameAsyncAction =
      AsyncAction('_PersonalStore.updateName', context: context);

  @override
  Future<bool> updateName(String name) {
    return _$updateNameAsyncAction.run(() => super.updateName(name));
  }

  late final _$updateBirthdayAsyncAction =
      AsyncAction('_PersonalStore.updateBirthday', context: context);

  @override
  Future<bool> updateBirthday(String birthday) {
    return _$updateBirthdayAsyncAction
        .run(() => super.updateBirthday(birthday));
  }

  late final _$updateImageAsyncAction =
      AsyncAction('_PersonalStore.updateImage', context: context);

  @override
  Future<bool> updateImage(File image) {
    return _$updateImageAsyncAction.run(() => super.updateImage(image));
  }

  late final _$deleteAccountAsyncAction =
      AsyncAction('_PersonalStore.deleteAccount', context: context);

  @override
  Future<bool> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_PersonalStore.logout', context: context);

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
fetchFuture: ${fetchFuture},
user: ${user},
isLoading: ${isLoading},
logout_success: ${logout_success},
progressLoading: ${progressLoading},
detailedProgressLoading: ${detailedProgressLoading}
    ''';
  }
}
