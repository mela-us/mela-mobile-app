import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/lecture/lecture.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/topic_lecture_in_level/topic_lecture_in_level.dart';
import 'package:mela/domain/entity/topic_lecture_in_level/topic_lecture_in_level_list.dart';

class TopicLectureApi {
  final DioClient _dioClient;
  TopicLectureApi(this._dioClient);
  Future<TopicLectureInLevelList> getTopicLecture(String levelId) async {
    print("================================ở getTopicLecture API");

    //Test
    // final responseData = await _dioClient.get(
    //   EndpointsConst.getTopics,
    // );
    await Future.delayed(Duration(seconds: 1));
    //Bỏ dòng trong đoạn test tới dòng này
    if (int.tryParse(levelId) != null && int.parse(levelId) % 2 == 0) {
      return TopicLectureInLevelList(
        topicLectureInLevelList: [
          TopicLectureInLevel(
              topicId: "1",
              topicName: "Số học",
              lectureList: LectureList(lectures: [
                Lecture(
                  lectureId: "1",
                  levelId: levelId,
                  topicId: "1",
                  lectureName: "Số mũ đúng",
                  lectureDescription: "Chuyên đề về số mũ đúng",
                  totalExercises: 10,
                  totalPassExercises: 5,
                ),
                Lecture(
                  lectureId: "2",
                  levelId: levelId,
                  topicId: "1",
                  lectureName: "Số mũ đúng nâng cao",
                  lectureDescription: "Chuyên đề về số mũ đúng nâng cao",
                  totalExercises: 10,
                  totalPassExercises: 5,
                )
              ])),
          TopicLectureInLevel(
              topicId: "2",
              topicName: "Hình học",
              lectureList: LectureList(lectures: [
                Lecture(
                  lectureId: "3",
                  levelId: levelId,
                  topicId: "2",
                  lectureName: "Hình học cơ bản",
                  lectureDescription: "Chuyên đề về hình học cơ bản",
                  totalExercises: 10,
                  totalPassExercises: 5,
                ),
                Lecture(
                  lectureId: "4",
                  levelId: levelId,
                  topicId: "2",
                  lectureName: "Hình học không gian nâng cao",
                  lectureDescription:
                      "Chuyên đề về hình học không gian nâng cao",
                  totalExercises: 10,
                  totalPassExercises: 5,
                )
              ]))
        ],
      );
    }
    return TopicLectureInLevelList(
      topicLectureInLevelList: [
        TopicLectureInLevel(
            topicId: "3",
            topicName: "Xác suất thống kê",
            lectureList: LectureList(lectures: [
              Lecture(
                lectureId: "5",
                levelId: levelId,
                topicId: "3",
                lectureName: "Xác suất cơ bản",
                lectureDescription: "Chuyên đề về xác suất cơ bản",
                totalExercises: 10,
                totalPassExercises: 5,
              ),
              Lecture(
                lectureId: "6",
                levelId: levelId,
                topicId: "3",
                lectureName: "Xác suất nâng cao",
                lectureDescription: "Chuyên đề về xác suất nâng cao",
                totalExercises: 10,
                totalPassExercises: 5,
              )
            ])),
        TopicLectureInLevel(
            topicId: "4",
            topicName: "Tư duy",
            lectureList: LectureList(lectures: [
              Lecture(
                lectureId: "7",
                levelId: levelId,
                topicId: "4",
                lectureName: "Toán tư duy cơ bản",
                lectureDescription: "Chuyên đề về toán tư duy cơ bản",
                totalExercises: 10,
                totalPassExercises: 5,
              ),
              Lecture(
                lectureId: "8",
                levelId: levelId,
                topicId: "4",
                lectureName: "Toán tư duy nâng cao",
                lectureDescription: "Chuyên đề về toán tư duy nâng cao",
                totalExercises: 10,
                totalPassExercises: 5,
              )
            ]))
      ],
    );
  }
}
