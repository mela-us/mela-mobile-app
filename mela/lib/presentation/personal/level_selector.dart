import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/home_screen/widgets/level_item.dart';
import 'package:mela/presentation/personal/store/personal_store.dart';
import 'package:mela/presentation/stats_topic_personal/store/detailed_stats_store.dart';
import 'package:mela/presentation/tutor/stores/tutor_store.dart';
import 'package:mobx/mobx.dart';

import '../../core/widgets/image_progress_indicator.dart';

class LevelSelectorScreen extends StatefulWidget {
  final bool firstAccess;

  const LevelSelectorScreen({Key? key, this.firstAccess = true});

  @override
  _LevelSelectorScreenState createState() => _LevelSelectorScreenState();
}

class _LevelSelectorScreenState extends State<LevelSelectorScreen> {
  //bool _isGradeSelected = false;

  final TutorStore _tutorStore = getIt<TutorStore>();
  final PersonalStore _personalStore = getIt<PersonalStore>();
  final DetailedStatStore _statStore = getIt<DetailedStatStore>();

  @override
  void initState() {
    super.initState();

    if (_tutorStore.levelList == null &&
        _tutorStore.fetchLevelsFuture.status != FutureStatus.pending) {
        _tutorStore.getLevels();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chọn lớp học của bạn',
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.textInBg1),
        ),
      ),
      body: _buildGradeSelection(context),
    );
  }

  Widget _buildGradeSelection(BuildContext context) {
    return Observer(builder: (context) {
      return _tutorStore.loading
          ? const Center(child: RotatingImageIndicator())
          : _tutorStore.levelList == null
          ? const Center(
              child: Text('Không có lớp nào'),
            )
          : Padding(
        padding: const EdgeInsets.all(Dimens.horizontal_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Lựa chọn lớp học sẽ giúp bạn đề xuất bài học và bài tập',
              style: Theme.of(context).textTheme.content.copyWith(
                  color: Theme.of(context).colorScheme.textInBg2),
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildGridView()),
          ],
        ),
      );
    });
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 0,
        childAspectRatio: 1,
        mainAxisExtent: 80, // set the height of each item
      ),
      itemCount: _tutorStore.levelList!.levelList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            String levelName = _tutorStore.levelList!.levelList[index].levelName;
            await _personalStore.updateLevel(levelName);
            _statStore.getStats();
            Navigator.of(context).pop();
          },
          child: AbsorbPointer(
            child: LevelItem(
              level: _tutorStore.levelList!.levelList[index],
            ),
          ),
        );
      },
    );
  }
}
