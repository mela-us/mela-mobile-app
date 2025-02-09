import 'dart:async';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/params/user/user_update_param.dart';

import '../../repository/user/user_repository.dart';
import '../user_login/refresh_access_token_usecase.dart';
import 'logout_usecase.dart';

class UpdateUserUsecase extends UseCase<String, UserUpdateParam>{
  final UserRepository _userRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  UpdateUserUsecase(this._userRepository, this._refreshAccessTokenUsecase, this._logoutUseCase);
  @override
  Future<String> call({required UserUpdateParam params}) async {
    try {
      switch (params.field) {
        case UpdateField.name:
          return await _userRepository.updateName(params.value);
        case UpdateField.birthday:
          String formattedDate = DateFormat('yyyy-MM-dd').format(
              DateTime.parse(params.value));
          return await _userRepository.updateBirthday(formattedDate);
        case UpdateField.image:
          return await _userRepository.updateImage(params.value);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess = await _refreshAccessTokenUsecase.call(
              params: null);
          if (isRefreshTokenSuccess) {
            return await call(params: params);
          }
          await _logoutUseCase.call(params: null);
          rethrow;
        }
        rethrow;
      }
      rethrow;
    }
    return "Error Occurred without DioException";
  }
}
