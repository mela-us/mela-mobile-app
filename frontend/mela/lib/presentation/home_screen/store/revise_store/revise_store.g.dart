// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revise_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReviseStore on _ReviseStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ReviseStore.loading'))
      .value;

  late final _$userReviewsResponseAtom =
      Atom(name: '_ReviseStore.userReviewsResponse', context: context);

  @override
  UserReviewsResponse? get userReviewsResponse {
    _$userReviewsResponseAtom.reportRead();
    return super.userReviewsResponse;
  }

  @override
  set userReviewsResponse(UserReviewsResponse? value) {
    _$userReviewsResponseAtom.reportWrite(value, super.userReviewsResponse, () {
      super.userReviewsResponse = value;
    });
  }

  late final _$revisionItemListAtom =
      Atom(name: '_ReviseStore.revisionItemList', context: context);

  @override
  ObservableList<ReviseItem> get revisionItemList {
    _$revisionItemListAtom.reportRead();
    return super.revisionItemList;
  }

  @override
  set revisionItemList(ObservableList<ReviseItem> value) {
    _$revisionItemListAtom.reportWrite(value, super.revisionItemList, () {
      super.revisionItemList = value;
    });
  }

  late final _$errorStringAtom =
      Atom(name: '_ReviseStore.errorString', context: context);

  @override
  String get errorString {
    _$errorStringAtom.reportRead();
    return super.errorString;
  }

  @override
  set errorString(String value) {
    _$errorStringAtom.reportWrite(value, super.errorString, () {
      super.errorString = value;
    });
  }

  late final _$isUnAuthorizedAtom =
      Atom(name: '_ReviseStore.isUnAuthorized', context: context);

  @override
  bool get isUnAuthorized {
    _$isUnAuthorizedAtom.reportRead();
    return super.isUnAuthorized;
  }

  @override
  set isUnAuthorized(bool value) {
    _$isUnAuthorizedAtom.reportWrite(value, super.isUnAuthorized, () {
      super.isUnAuthorized = value;
    });
  }

  late final _$fetchRevisionFutureAtom =
      Atom(name: '_ReviseStore.fetchRevisionFuture', context: context);

  @override
  ObservableFuture<UserReviewsResponse?> get fetchRevisionFuture {
    _$fetchRevisionFutureAtom.reportRead();
    return super.fetchRevisionFuture;
  }

  @override
  set fetchRevisionFuture(ObservableFuture<UserReviewsResponse?> value) {
    _$fetchRevisionFutureAtom.reportWrite(value, super.fetchRevisionFuture, () {
      super.fetchRevisionFuture = value;
    });
  }

  late final _$getRevisionAsyncAction =
      AsyncAction('_ReviseStore.getRevision', context: context);

  @override
  Future<dynamic> getRevision() {
    return _$getRevisionAsyncAction.run(() => super.getRevision());
  }

  late final _$updateReviewAsyncAction =
      AsyncAction('_ReviseStore.updateReview', context: context);

  @override
  Future<String> updateReview(UpdateReviewParam params) {
    return _$updateReviewAsyncAction.run(() => super.updateReview(params));
  }

  @override
  String toString() {
    return '''
userReviewsResponse: ${userReviewsResponse},
revisionItemList: ${revisionItemList},
errorString: ${errorString},
isUnAuthorized: ${isUnAuthorized},
fetchRevisionFuture: ${fetchRevisionFuture},
loading: ${loading}
    ''';
  }
}
