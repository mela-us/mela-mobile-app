import 'dart:async';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
//Data:-------------------------------------------------------------------------

//Domain:-----------------------------------------------------------------------
import 'package:mela/domain/entity/presigned_image/presigned_image.dart';
import 'package:mela/domain/entity/question/question_list.dart';

//Other:------------------------------------------------------------------------
import '../../constants/endpoints_const.dart';
import '../../dio_client.dart';

class QuestionsApi {
  // dio instance
  final DioClient _dioClient;
  // injecting dio instance
  QuestionsApi(this._dioClient);

  /// Returns list of post in response
  Future<QuestionList> getQuestions(String exerciseUid) async {
    final res = await _dioClient.dio.get(
      EndpointsConst.getQuestions + exerciseUid,
    );
    if (res.statusCode == 200) {
      QuestionList list = QuestionList.fromJson(res.data);
      return list;
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<PresignedImage> getPresignedImageUrlForQuestion() async {
    final res = await _dioClient.get(EndpointsConst.getPresignUrlForQuestion);
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
