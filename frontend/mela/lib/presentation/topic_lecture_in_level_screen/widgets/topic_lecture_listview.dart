import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/showcase_custom.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/widgets/lectures_in_topic.dart';
import 'package:showcaseview/showcaseview.dart';

class TopicLectureListview extends StatefulWidget {
  TopicLectureListview({super.key});

  @override
  State<TopicLectureListview> createState() => _TopicLectureListviewState();
}

class _TopicLectureListviewState extends State<TopicLectureListview> {
  final TopicLectureStore topicLectureStore = getIt<TopicLectureStore>();

  final _sharedPrefsHelper = getIt.get<SharedPreferenceHelper>();
  final GlobalKey _guideLearnTopicKey = GlobalKey();
  BuildContext? showCaseContext;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Thêm delay 500ms trước khi gọi startShowCase
      Future.delayed(const Duration(milliseconds: 300), () async {
        final isFirstTimeOpenLevel =
            await _sharedPrefsHelper.isFirstTimeOpenLevel;
        if (mounted && showCaseContext != null && isFirstTimeOpenLevel) {
          ShowCaseWidget.of(showCaseContext!)
              .startShowCase([_guideLearnTopicKey]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (topicLectureStore
        .topicLectureInLevelList!.topicLectureInLevelList.isEmpty) {
      return Center(
        child: Text(
          "Hiện tại chưa có dữ liệu cho khối lớp này",
          style: Theme.of(context)
              .textTheme
              .subTitle
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      );
    }

    return ShowCaseWidget(onFinish: () async {
      _sharedPrefsHelper.saveIsFirstTimeOpenLevel(false);
    }, builder: (context) {
      showCaseContext = context;
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          // shrinkWrap: true,
          itemCount: topicLectureStore
              .topicLectureInLevelList!.topicLectureInLevelList.length,
          itemBuilder: (context, index) {
            // await _sharedPrefsHelper
            //     .isFirstTimeOpenLessonInTopic;
            return index == 0
                ? ShowcaseCustom(
                    keyWidget: _guideLearnTopicKey,
                    title: "Hoàn thành chủ đề",
                    description:
                        "Bạn hãy cố gắng hoàn thành tất cả các bài học để được ghi nhận hoàn thành chủ để nhé!",
                    isHideActionWidget: true,
                    child: LecturesInTopic(
                        topicId: topicLectureStore.topicLectureInLevelList!
                            .topicLectureInLevelList[index].topicId,
                        topicName: topicLectureStore.topicLectureInLevelList!
                            .topicLectureInLevelList[index].topicName,
                        lectureList: topicLectureStore.topicLectureInLevelList!
                            .topicLectureInLevelList[index].lectureList),
                  )
                : LecturesInTopic(
                    topicId: topicLectureStore.topicLectureInLevelList!
                        .topicLectureInLevelList[index].topicId,
                    topicName: topicLectureStore.topicLectureInLevelList!
                        .topicLectureInLevelList[index].topicName,
                    lectureList: topicLectureStore.topicLectureInLevelList!
                        .topicLectureInLevelList[index].lectureList);
          },
        ),
      );
    });
  }
}
