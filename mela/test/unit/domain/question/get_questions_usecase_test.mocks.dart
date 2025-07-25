// Mocks generated by Mockito 5.4.4 from annotations
// in mela/test/unit/domain/question/get_questions_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i5;

import 'package:mela/domain/entity/question/question_list.dart' as _i2;
import 'package:mela/domain/repository/question/question_repository.dart'
    as _i3;
import 'package:mela/domain/usecase/user/logout_usecase.dart' as _i7;
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeQuestionList_0 extends _i1.SmartFake implements _i2.QuestionList {
  _FakeQuestionList_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [QuestionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockQuestionRepository extends _i1.Mock
    implements _i3.QuestionRepository {
  MockQuestionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.QuestionList> getQuestions(String? exerciseUid) =>
      (super.noSuchMethod(
        Invocation.method(
          #getQuestions,
          [exerciseUid],
        ),
        returnValue: _i4.Future<_i2.QuestionList>.value(_FakeQuestionList_0(
          this,
          Invocation.method(
            #getQuestions,
            [exerciseUid],
          ),
        )),
      ) as _i4.Future<_i2.QuestionList>);

  @override
  _i4.Future<_i2.QuestionList> updateQuestions(
          _i2.QuestionList? newQuestionList) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateQuestions,
          [newQuestionList],
        ),
        returnValue: _i4.Future<_i2.QuestionList>.value(_FakeQuestionList_0(
          this,
          Invocation.method(
            #updateQuestions,
            [newQuestionList],
          ),
        )),
      ) as _i4.Future<_i2.QuestionList>);

  @override
  _i4.Future<List<List<String>?>> uploadImages(List<List<_i5.File>>? images) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadImages,
          [images],
        ),
        returnValue: _i4.Future<List<List<String>?>>.value(<List<String>?>[]),
      ) as _i4.Future<List<List<String>?>>);

  @override
  _i4.Future<int> submitQuestion(
    String? exerciseUid,
    String? questionText,
    List<String>? imageUrls,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #submitQuestion,
          [
            exerciseUid,
            questionText,
            imageUrls,
          ],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
}

/// A class which mocks [RefreshAccessTokenUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRefreshAccessTokenUsecase extends _i1.Mock
    implements _i6.RefreshAccessTokenUsecase {
  MockRefreshAccessTokenUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> call({required dynamic params}) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [LogoutUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogoutUseCase extends _i1.Mock implements _i7.LogoutUseCase {
  MockLogoutUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> call({required dynamic params}) => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#params: params},
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
