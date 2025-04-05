import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

class PresignedImageUploadApi {
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
