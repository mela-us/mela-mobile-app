import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/stat/progress_list.dart';
import 'package:mela/domain/repository/stat/stat_repository.dart';

import '../user_login/refresh_access_token_usecase.dart';

class GetProgressListUseCase extends UseCase<ProgressList, void>{
  final StatRepository _statRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;

  GetProgressListUseCase(this._statRepository, this._refreshAccessTokenUsecase);

  @override
  Future<ProgressList> call({required params}) async {
    try {
      return await _statRepository.getProgressList();
    } catch (e) {
      if (e is DioException) {
        //eg accessToken is expired
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
              await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            print("----------->E1: $e");
            return await call(params: null);
          }
        }
        print("----------->E2: $e");
        rethrow;
      }
      print("----------->E3: $e");
      rethrow;
    }
  }
}