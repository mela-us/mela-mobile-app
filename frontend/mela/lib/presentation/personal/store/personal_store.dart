import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/user/user.dart';
import 'package:mela/domain/params/user/user_update_param.dart';
import 'package:mela/domain/usecase/user/get_user_info_usecase.dart';
import 'package:mela/domain/usecase/user/update_user_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../domain/usecase/user/delete_user_usecase.dart';
import '../../../domain/usecase/user/logout_usecase.dart';
import '../../../utils/dio/dio_error_util.dart';

part 'personal_store.g.dart';

class PersonalStore = _PersonalStore with _$PersonalStore;


abstract class _PersonalStore with Store {
  //Constructor:----------------------------------------------------------------
  _PersonalStore(
      this._getUserInfoUseCase,
      this._logoutUseCase,
      this._errorStore,
      this._updateUserUsecase,
      this._deleteAccountUseCase
      );
  //UseCase:--------------------------------------------------------------------
  final GetUserInfoUseCase _getUserInfoUseCase;
  final LogoutUseCase _logoutUseCase;
  final UpdateUserUsecase _updateUserUsecase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;

  // store variables:-----------------------------------------------------------
  //empty-------------
  static ObservableFuture<User?> emptyResponse =
  ObservableFuture.value(null);
  //fetch-------------
  @observable
  ObservableFuture<User?> fetchFuture =
  ObservableFuture<User?>(emptyResponse);
  //
  @observable
  User? user;

  @observable
  bool isLoading = false;
  //
  @observable
  bool logout_success = false;
  //loading
  @computed
  bool get progressLoading => fetchFuture.status == FutureStatus.pending;
  @computed
  bool get detailedProgressLoading => fetchFuture.status == FutureStatus.pending;

  //action:---------------------------------------------------------------------
  @action
  Future getUserInfo() async {
    final future = _getUserInfoUseCase.call(params: null);
    fetchFuture = ObservableFuture(future);

    future.then((temp) {
      user = temp;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future<bool> updateName(String name) async{
    try {
      isLoading = true;
      await _updateUserUsecase.call(params: UserUpdateParam(null, field: UpdateField.name, value: name));
      return true;
    } catch (e) {
      if (e is DioException) {
        _errorStore.errorMessage = DioExceptionUtil.handleError(e);
        if (e.response?.statusCode == 401) {
          await _logoutUseCase.call(params: null);
        }
      } else {
        print(e.toString());
      }
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> updateBirthday(String birthday) async {
    try {
      isLoading = true;
      await _updateUserUsecase.call(params: UserUpdateParam(null, field: UpdateField.birthday, value: birthday));
      return true;
    } catch (e) {
      if (e is DioException) {
        _errorStore.errorMessage = DioExceptionUtil.handleError(e);
        if (e.response?.statusCode == 401) {
          await _logoutUseCase.call(params: null);
        }
      } else {
        print(e.toString());
      }
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> updateImage(File image) async {
    try {
      isLoading = true;
      await _updateUserUsecase.call(params: UserUpdateParam(image, field: UpdateField.name, value:""));
      return true;
    } catch (e) {
      if (e is DioException) {
        _errorStore.errorMessage = DioExceptionUtil.handleError(e);
        if (e.response?.statusCode == 401) {
          await _logoutUseCase.call(params: null);
        }
      } else {
        print(e.toString());
      }
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> deleteAccount() async {
    try {
      isLoading = true;
      return await _deleteAccountUseCase.call(params: null);
    } catch (e) {
      if (e is DioException) {
        _errorStore.errorMessage = DioExceptionUtil.handleError(e);
        if (e.response?.statusCode == 401) {
          await _logoutUseCase.call(params: null);
        }
      } else {
        print(e.toString());
      }
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future logout() async {
    final future = _logoutUseCase.call(params: null);
    future.then((temp) {
      logout_success = true;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
      logout_success = false;
    });
  }
}