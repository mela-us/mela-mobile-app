// ignore_for_file: unused_import

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';
import 'package:mela/domain/repository/user/user_repository.dart';

import '../user_login/refresh_access_token_usecase.dart';
import 'logout_usecase.dart';

class DeleteAccountUseCase extends UseCase<bool, void>{
  final UserRepository _userRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  DeleteAccountUseCase(this._userRepository, this._logoutUseCase, this._refreshAccessTokenUsecase);

  @override
  Future<bool> call({required params}) async {
    try {
      return await _userRepository.deleteAccount();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
          await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            print("----------->E1: $e");
            return await call(params: null);
          }
          await _logoutUseCase.call(params: null);
          rethrow;
        }
        print("----------->E2: $e");
        rethrow;
      }
      print("----------->E3: $e");
      rethrow;
    }
  }
}