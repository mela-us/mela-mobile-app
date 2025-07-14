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
  bool focus;

  LevelItem({super.key, required this.level, this.focus = false});

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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: focus
                        ? Theme.of(context).colorScheme.tertiary.withOpacity(0.4)
                        : Theme.of(context).colorScheme.appBackground,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(14), // Bo góc tại đây
              ),
              clipBehavior: Clip.antiAlias, // Cắt ảnh theo bo góc
              child: Image(
                image: level.levelImagePath.isEmpty
                    ? const AssetImage('assets/images/grades/default_level.png')
                    : NetworkImage(level.levelImagePath) as ImageProvider<Object>,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: AnimationHelper.buildShimmerPlaceholder(context, 50, 50),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),

            //Name topic
            SizedBox(
              width: 60,
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
