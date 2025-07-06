import 'dart:io';

import 'package:mela/data/network/apis/exam/exam_api.dart';
import 'package:mela/domain/entity/exam/exam.dart';
import 'package:mela/domain/repository/exam/exam_repository.dart';

class ExamRepositoryImpl extends ExamRepository {
  final ExamApi _examApi;

  ExamRepositoryImpl(this._examApi);
  @override
  Future<ExamModel> getExam() async {
    try {
      ExamModel exam = await _examApi.getExam();
      return exam;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> submitQuestion(
      String exerciseUid, String questionText, List<String> imageUrls) {
    // TODO: implement submitQuestion
    throw UnimplementedError();
  }

  @override
  Future<List<List<String>?>> uploadImages(List<List<File>> images) async {
    List<List<String>?> result = [];
    for (List<File> imageList in images) {
      result.add(await _uploadSingleImage(imageList));
    }
    return Future.value(result);
  }

  Future<List<String>?> _uploadSingleImage(List<File> imageList) async {
    print("Reach");
    if (imageList.isEmpty) {
      return Future.value(null);
    }
    List<String> imageUrls = [];
    await _examApi
        .getPresignedImageUrlForQuestion()
        .then((presignedImage) async {
      for (File image in imageList) {
        int statusCode =
            await _examApi.uploadImage(image, presignedImage.preSignedUrl);
        if (statusCode == 200 || statusCode == 201) {
          imageUrls.add(presignedImage.imageUrl);
        } else {
          if (statusCode == 401) {
            throw Exception("Unauthorized");
          } else {
            throw Exception(statusCode.toString());
          }
        }
      }
    });

    return Future.value(imageUrls);
  }
}
