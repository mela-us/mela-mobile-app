import 'dart:io';

import 'package:mela/domain/entity/presigned_image/presigned_image.dart';

abstract class PresignedImageRepository {
  Future<PresignedImage> getPreSignUrl();
  Future<int> uploadImage(File file, String presignedUrl);
}
