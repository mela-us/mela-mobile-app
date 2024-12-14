import 'package:flutter/material.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/widgets/item_infor.dart';

class GeneralInfor extends StatelessWidget {
  GeneralInfor({super.key});
  
  final TopicLectureStore _topicLectureStore = getIt<TopicLectureStore>();

  String getInforForStructureGrade() {
    String result = "- Các chủ đề:";
    final inforList = _topicLectureStore.topicLectureInLevelList!.topicLectureInLevelList;
    for (int i = 0; i < inforList.length; i++) {
      result += "\n${i + 1}. ${inforList[i].topicName}: ${inforList[i].lectureList.lectures.length} bài học.";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: const EdgeInsets.only(top: 10, right: 18, left: 18, bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onTertiary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ItemInfor(
                title: "Mô tả chung",
                content: "- Khóa học hoàn toàn miễn phí và dành cho học sinh ${_topicLectureStore.currentLevel!.levelName}.\n- Khóa học bao gồm nhiều chủ đề và bài học khác nhau từ cơ bản đến nâng cao."
              ),
              ItemInfor(
                title: "Mục tiêu khóa học",
                content: "- Học sinh của ${_topicLectureStore.currentLevel!.levelName} có thể nắm rõ được kiến thức cơ bản và nâng cao của từng bài giảng và ôn tập lại với các bài tập."
              ),
              ItemInfor(
                title: "Cấu trúc khóa học",
                content: getInforForStructureGrade()
              ),
              ItemInfor(
                title: "Liên hệ hỗ trợ",
                content: "datnmathelearning2025@gmail.com"
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
