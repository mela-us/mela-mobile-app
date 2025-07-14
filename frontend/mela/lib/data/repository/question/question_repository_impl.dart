import 'dart:io';

import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/repository/question/question_repository.dart';

import '../../network/apis/questions/questions_api.dart';

class QuestionRepositoryImpl extends QuestionRepository {
  final QuestionsApi _questionsApi;

  QuestionRepositoryImpl(this._questionsApi);

  @override
  Future<QuestionList> getQuestions(String exerciseUid) async {
    try {
      QuestionList temp = await _questionsApi.getQuestions(exerciseUid);
      return temp;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<QuestionList> updateQuestions(QuestionList newQuestionList) {
    // TODO: implement updateQuestions
    throw UnimplementedError();
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
    await _questionsApi
        .getPresignedImageUrlForQuestion()
        .then((presignedImage) async {
      for (File image in imageList) {
        int statusCode =
            await _questionsApi.uploadImage(image, presignedImage.preSignedUrl);
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
