import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/presigned_image/presigned_image.dart';
import 'package:mela/domain/repository/presigned_image/presigned_image_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetPresignImageUsecase extends UseCase<String, File> {
  final PresignedImageRepository _presignedImageRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;
  GetPresignImageUsecase(this._presignedImageRepository,
      this._refreshAccessTokenUsecase, this._logoutUseCase);

  @override
  Future<String> call({required File params}) async {
    try {
      PresignedImage presignedImage =
          await _presignedImageRepository.getPreSignUrl();
      // print("----------->Đường dẫn ảnh: ${presignedImage.imageUrl}");
      // print("----------->Đường dẫn presign: ${presignedImage.preSignedUrl}");
      int statusCode = await _presignedImageRepository.uploadImage(
          params, presignedImage.preSignedUrl);

      if (statusCode == 200 || statusCode == 201) {
        // print("----------->Đã up ảnh thành công: $statusCode");
        return presignedImage.imageUrl;
      }
      // print("----------->Lỗi up ảnh: $statusCode");
      throw Exception("Upload image failed");
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
              await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            print("----------->E1: $e");
            return await call(params: params);
          }
          //Call logout, logout will delete token in secure storage, shared preference.....
          await _logoutUseCase.call(params: null);
          rethrow;
          //.................
        }
        print("----------->E2: $e");
        rethrow;
      }
      print("----------->E3: $e");
      rethrow;
    }
  }
}
