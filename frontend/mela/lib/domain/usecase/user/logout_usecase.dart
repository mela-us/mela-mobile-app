import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/stat/progress_list.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';
import 'package:mela/domain/repository/user/user_repository.dart';

import '../user_login/refresh_access_token_usecase.dart';

class LogoutUseCase extends UseCase<bool, void>{
  final UserRepository _userRepository;

  LogoutUseCase(this._userRepository);

  @override
  Future<bool> call({required params}) async {
    try {
      return await _userRepository.logout();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
        }
        print("----------->E2: $e");
        rethrow;
      }
      print("----------->E3: $e");
      rethrow;
    }
  }
}