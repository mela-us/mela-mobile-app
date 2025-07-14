import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/topic_lecture_in_level/topic_lecture_in_level_list.dart';

class TopicLectureApi {
  final DioClient _dioClient;
  TopicLectureApi(this._dioClient);
  Future<TopicLectureInLevelList> getTopicLecture(String levelId) async {
    print("================================ở getTopicLecture API");

    //Test
    final responseData = await _dioClient.get(
      EndpointsConst.getTopicLectureInLevel,
      queryParameters: {"levelId": levelId},
    );

    return TopicLectureInLevelList.fromJson(responseData["data"]);
    //   await Future.delayed(Duration(seconds: 1));
    //   //Bỏ dòng trong đoạn test tới dòng này
    //   if (int.tryParse(levelId) != null && int.parse(levelId) % 2 == 0) {
    //     return TopicLectureInLevelList(
    //       topicLectureInLevelList: [
    //         TopicLectureInLevel(
    //             topicId: "206eb409-4078-40b1-9024-185b2c360645",
    //             topicName: "Số học",
    //             lectureList: LectureList(lectures: [
    //               Lecture(
    //                 lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //                 levelId: levelId,
    //                 topicId: "206eb409-4078-40b1-9024-185b2c360645",
    //                 lectureName: "Số mũ đúng",
    //                 lectureDescription: "Chuyên đề về số mũ đúng",
    //                 totalExercises: 10,
    //                 totalPassExercises: 5,
    //               ),
    //               Lecture(
    //                 lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //                 levelId: levelId,
    //                 topicId: "206eb409-4078-40b1-9024-185b2c360645",
    //                 lectureName: "Số mũ đúng nâng cao",
    //                 lectureDescription: "Chuyên đề về số mũ đúng nâng cao",
    //                 totalExercises: 10,
    //                 totalPassExercises: 5,
    //               )
    //             ])),
    //         TopicLectureInLevel(
    //             topicId: "0af2634d-1f55-457b-b933-e0ad8749d133",
    //             topicName: "Hình học",
    //             lectureList: LectureList(lectures: [
    //               Lecture(
    //                 lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //                 levelId: levelId,
    //                 topicId: "0af2634d-1f55-457b-b933-e0ad8749d133",
    //                 lectureName: "Hình học cơ bản",
    //                 lectureDescription: "Chuyên đề về hình học cơ bản",
    //                 totalExercises: 10,
    //                 totalPassExercises: 5,
    //               ),
    //               Lecture(
    //                 lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //                 levelId: levelId,
    //                 topicId: "0af2634d-1f55-457b-b933-e0ad8749d133",
    //                 lectureName: "Hình học không gian nâng cao",
    //                 lectureDescription:
    //                     "Chuyên đề về hình học không gian nâng cao",
    //                 totalExercises: 10,
    //                 totalPassExercises: 5,
    //               )
    //             ])),
    //         TopicLectureInLevel(
    //             topicId: "c7679a40-4fdc-48d7-bfef-d4ec39872860",
    //             topicName: "Xác suất thống kê",
    //             lectureList: LectureList(lectures: [
    //               Lecture(
    //                 lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //                 levelId: levelId,
    //                 topicId: "c7679a40-4fdc-48d7-bfef-d4ec39872860",
    //                 lectureName: "Xác suất cơ bản",
    //                 lectureDescription: "Chuyên đề về xác suất cơ bản",
    //                 totalExercises: 10,
    //                 totalPassExercises: 5,
    //               ),
    //               Lecture(
    //                 lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //                 levelId: levelId,
    //                 topicId: "c7679a40-4fdc-48d7-bfef-d4ec39872860",
    //                 lectureName: "Xác suất nâng cao",
    //                 lectureDescription: "Chuyên đề về xác suất nâng cao",
    //                 totalExercises: 10,
    //                 totalPassExercises: 5,
    //               )
    //             ])),
    //         TopicLectureInLevel(
    //             topicId: "a59ba7ff-15e4-4f8f-bd18-07a7f35c1788",
    //             topicName: "Tư duy",
    //             lectureList: LectureList(lectures: [
    //               Lecture(
    //                 lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //                 levelId: levelId,
    //                 topicId: "a59ba7ff-15e4-4f8f-bd18-07a7f35c1788",
    //                 lectureName: "Toán tư duy cơ bản",
    //                 lectureDescription: "Chuyên đề về toán tư duy cơ bản",
    //                 totalExercises: 10,
    //                 totalPassExercises: 5,
    //               ),
    //               Lecture(
    //                 lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //                 levelId: levelId,
    //                 topicId: "a59ba7ff-15e4-4f8f-bd18-07a7f35c1788",
    //                 lectureName: "Toán tư duy nâng cao",
    //                 lectureDescription: "Chuyên đề về toán tư duy nâng cao",
    //                 totalExercises: 10,
    //                 totalPassExercises: 5,
    //               )
    //             ]))
    //       ],
    //     );
    //   }
    //   return TopicLectureInLevelList(
    //     topicLectureInLevelList: [
    //       TopicLectureInLevel(
    //           topicId: "c7679a40-4fdc-48d7-bfef-d4ec39872860",
    //           topicName: "Xác suất thống kê",
    //           lectureList: LectureList(lectures: [
    //             Lecture(
    //               lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //               levelId: levelId,
    //               topicId: "c7679a40-4fdc-48d7-bfef-d4ec39872860",
    //               lectureName: "Xác suất cơ bản",
    //               lectureDescription: "Chuyên đề về xác suất cơ bản",
    //               totalExercises: 10,
    //               totalPassExercises: 5,
    //             ),
    //             Lecture(
    //               lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //               levelId: levelId,
    //               topicId: "c7679a40-4fdc-48d7-bfef-d4ec39872860",
    //               lectureName: "Xác suất nâng cao",
    //               lectureDescription: "Chuyên đề về xác suất nâng cao",
    //               totalExercises: 10,
    //               totalPassExercises: 5,
    //             )
    //           ])),
    //       TopicLectureInLevel(
    //           topicId: "a59ba7ff-15e4-4f8f-bd18-07a7f35c1788",
    //           topicName: "Tư duy",
    //           lectureList: LectureList(lectures: [
    //             Lecture(
    //               lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //               levelId: levelId,
    //               topicId: "a59ba7ff-15e4-4f8f-bd18-07a7f35c1788",
    //               lectureName: "Toán tư duy cơ bản",
    //               lectureDescription: "Chuyên đề về toán tư duy cơ bản",
    //               totalExercises: 10,
    //               totalPassExercises: 5,
    //             ),
    //             Lecture(
    //               lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //               levelId: levelId,
    //               topicId: "a59ba7ff-15e4-4f8f-bd18-07a7f35c1788",
    //               lectureName: "Toán tư duy nâng cao",
    //               lectureDescription: "Chuyên đề về toán tư duy nâng cao",
    //               totalExercises: 10,
    //               totalPassExercises: 5,
    //             )
    //           ])),
    //       TopicLectureInLevel(
    //           topicId: "206eb409-4078-40b1-9024-185b2c360645",
    //           topicName: "Số học",
    //           lectureList: LectureList(lectures: [
    //             Lecture(
    //               lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //               levelId: levelId,
    //               topicId: "206eb409-4078-40b1-9024-185b2c360645",
    //               lectureName: "Số mũ đúng",
    //               lectureDescription: "Chuyên đề về số mũ đúng",
    //               totalExercises: 10,
    //               totalPassExercises: 5,
    //             ),
    //             Lecture(
    //               lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //               levelId: levelId,
    //               topicId: "206eb409-4078-40b1-9024-185b2c360645",
    //               lectureName: "Số mũ đúng nâng cao",
    //               lectureDescription: "Chuyên đề về số mũ đúng nâng cao",
    //               totalExercises: 10,
    //               totalPassExercises: 5,
    //             )
    //           ])),
    //       TopicLectureInLevel(
    //           topicId: "0af2634d-1f55-457b-b933-e0ad8749d133",
    //           topicName: "Hình học",
    //           lectureList: LectureList(lectures: [
    //             Lecture(
    //               lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //               levelId: levelId,
    //               topicId: "0af2634d-1f55-457b-b933-e0ad8749d133",
    //               lectureName: "Hình học cơ bản",
    //               lectureDescription: "Chuyên đề về hình học cơ bản",
    //               totalExercises: 10,
    //               totalPassExercises: 5,
    //             ),
    //             Lecture(
    //               lectureId: "b8d97942-ea84-495e-98f3-b1c7aa65ad3c",
    //               levelId: levelId,
    //               topicId: "0af2634d-1f55-457b-b933-e0ad8749d133",
    //               lectureName: "Hình học không gian nâng cao",
    //               lectureDescription: "Chuyên đề về hình học không gian nâng cao",
    //               totalExercises: 10,
    //               totalPassExercises: 5,
    //             )
    //           ])),
    //     ],
    //   );
    //
  }
}
