import 'dart:async';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/params/user/user_update_param.dart';
import 'package:mela/domain/usecase/user/get_upload_presign_usecase.dart';

import '../../repository/user/user_repository.dart';
import '../user_login/refresh_access_token_usecase.dart';
import 'logout_usecase.dart';

class UpdateUserUsecase extends UseCase<String, UserUpdateParam>{
  final UserRepository _userRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;
  final GetUploadPresignUseCase _getUploadPresignUseCase;

  UpdateUserUsecase(
      this._userRepository,
      this._refreshAccessTokenUsecase,
      this._logoutUseCase,
      this._getUploadPresignUseCase
      );

  @override
  Future<String> call({required UserUpdateParam params}) async {
    try {
      switch (params.field) {
        case UpdateField.name:
          return await _userRepository.updateName(params.value);
        case UpdateField.birthday:
          String formattedDate = params.value;
          return await _userRepository.updateBirthday(formattedDate);
        case UpdateField.level:
          return await _userRepository.updateLevel(params.value);
        case UpdateField.image:
          String uploadUrl = await _getUploadPresignUseCase.call(params: null);
          if (uploadUrl.isNotEmpty) {
            return await _userRepository.updateImage(params.image!, uploadUrl);
          }
          else {
            throw "Upload Url empty";
          }
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
