import 'dart:io';

import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/exam/exam.dart';
import 'package:mela/domain/entity/presigned_image/presigned_image.dart';

// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

class ExamApi {
  final DioClient _dioClient;
  ExamApi(this._dioClient);

  Future<ExamModel> getExam() async {
    await Future.delayed(const Duration(seconds: 1));
    final res = await _dioClient.dio.get(
      EndpointsConst.getExam,
    );
    if (res.statusCode == 200) {
      return ExamModel.fromJson(res.data);
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<PresignedImage> getPresignedImageUrlForQuestion() async {
    final res = await _dioClient.get(EndpointsConst.getPresignUrlForExam);
    return PresignedImage.fromJson(res as Map<String, dynamic>);
  }

  Future<int> uploadImage(File image, String presignedUrl) async {
    try {
      String contentType =
          lookupMimeType(image.path) ?? "application/octet-stream";
      // print("Content type: $contentType");
      // print("Presigned URL: $presignedUrl");

      var request = await http.put(
        Uri.parse(presignedUrl),
        body: await image.readAsBytes(),
        headers: {'x-ms-blob-type': 'BlockBlob', 'Content-Type': contentType},
      );
      // print(
      //     "Response body trong PresignedImageUploadApi ${request.body.toString()} ${request.statusCode}");
      return request.statusCode;
    } catch (e) {
      print("Lỗi upload ảnh ở PresignedImageUploadApi API: $e");
      rethrow;
    }
  }
}
