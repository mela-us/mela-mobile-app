import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/showcase_custom.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../di/service_locator.dart';
import 'exercise_item.dart';

class ExerciseListItem extends StatefulWidget {
  ExerciseListItem();

  @override
  State<ExerciseListItem> createState() => _ExerciseListItemState();
}

class _ExerciseListItemState extends State<ExerciseListItem> {
  final ExerciseStore _exerciseStore = getIt<ExerciseStore>();
  final _sharedPrefsHelper = getIt.get<SharedPreferenceHelper>();
  final GlobalKey _guideLearnLessonKey = GlobalKey();
  final GlobalKey _guideLearnExerciseKey = GlobalKey();
  BuildContext? showCaseContext;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Thêm delay 500ms trước khi gọi startShowCase
      Future.delayed(const Duration(milliseconds: 300), () async {
        final isFirstTimeOpenLessonInTopic =
            await _sharedPrefsHelper.isFirstTimeOpenLessonInTopic;
        if (mounted &&
            showCaseContext != null &&
            isFirstTimeOpenLessonInTopic) {
          ShowCaseWidget.of(showCaseContext!)
              .startShowCase([_guideLearnExerciseKey, _guideLearnLessonKey]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_exerciseStore.exerciseList!.exercises.isEmpty) {
      return Center(
        child: Text(
          "Hiện tại chưa có bài tập ở đây",
          style: Theme.of(context)
              .textTheme
              .subTitle
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      );
    }
    return ShowCaseWidget(onFinish: () async {
      _sharedPrefsHelper.saveIsFirstTimeOpenLessonInTopic(false);
    }, builder: (context) {
      showCaseContext = context;
      return ShowcaseCustom(
        keyWidget: _guideLearnLessonKey,
        title: "Hoàn thành bài học",
        description:
            "Cố gắng kết thúc bài học bằng cách làm toàn bộ bài tập nhé!",
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _exerciseStore.exerciseList!.exercises.length,
          itemBuilder: (context, index) {
            return index == 0
                ? ShowcaseCustom(
                    keyWidget: _guideLearnExerciseKey,
                    title: "Hoàn thành bài tập",
                    isHideActionWidget: true,
                    description:
                        "Cố gắng vượt qua 80% số câu hỏi để hoàn thành bài tập nhé!",
                    child: ExerciseItem(
                        currentExercise:
                            _exerciseStore.exerciseList!.exercises[index]),
                  )
                : ExerciseItem(
                    currentExercise:
                        _exerciseStore.exerciseList!.exercises[index]);
          },
        ),
      );
    });
  }
}
