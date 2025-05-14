//---Version 1:
import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/level/level.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:vibration/vibration.dart';

import '../../../di/service_locator.dart';
import '../../../utils/animation_helper/animation_helper.dart';
import '../../../utils/routes/routes.dart';

class LevelItem extends StatelessWidget {
  final Level level;
  LevelItem({super.key, required this.level});

  final TopicLectureStore _topicLectureStore = getIt<TopicLectureStore>();
  final LevelStore _levelStore = getIt<LevelStore>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _topicLectureStore.setCurrentLevel(level);
        _levelStore.resetErrorString();
        Navigator.of(context).pushNamed(Routes.topicLectureInLevelScreen);
        Vibration.vibrate(duration: 60);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Logo level
            SizedBox(
              width: 55,
              height: 55,
              child: Image(
                image: level.levelImagePath.isEmpty
                    ? const AssetImage('assets/images/grades/default_level.png')
                    : NetworkImage(level.levelImagePath)
                        as ImageProvider<Object>,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: AnimationHelper.buildShimmerPlaceholder(context,100,100),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),

            //Name topic
            SizedBox(
              width: 75,
              child: Text(
                level.levelName,
                textAlign: TextAlign.center,
                maxLines: null,
                overflow: TextOverflow.visible,
                style: Theme.of(context).textTheme.miniCaption.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
