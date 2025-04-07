import 'dart:io';

import 'package:mela/data/network/apis/presigned_image/presigned_image_api.dart';
import 'package:mela/data/network/apis/presigned_image/presigned_image_upload_api.dart';
import 'package:mela/domain/entity/presigned_image/presigned_image.dart';
import 'package:mela/domain/repository/presigned_image/presigned_image_repository.dart';

class PresignedImageRepositoryImpl extends PresignedImageRepository {
  final PresignedImageApi _presignedImageApi;
  final PresignedImageUploadApi _presignedImageUploadApi;

  PresignedImageRepositoryImpl(
      this._presignedImageApi, this._presignedImageUploadApi);

  @override
  Future<PresignedImage> getPreSignUrl() async {
    return _presignedImageApi.getPresignedImage();
  }

  @override
  Future<int> uploadImage(File file, String presigned) async {
    return _presignedImageUploadApi.uploadImage(file, presigned);
  }
}
