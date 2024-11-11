import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/widgets/exercise_list_item.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';

import '../../core/widgets/progress_indicator_widget.dart';
import 'widgets/divided_lecture_list_item.dart';

class DividedLecturesAndExercisesScreen extends StatefulWidget {
  DividedLecturesAndExercisesScreen({super.key});
  @override
  _DividedLecturesAndExercisesScreenState createState() =>
      _DividedLecturesAndExercisesScreenState();
}

class _DividedLecturesAndExercisesScreenState
    extends State<DividedLecturesAndExercisesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ExerciseStore _exerciseStore = getIt<ExerciseStore>();
  LectureStore _lectureStore = getIt<LectureStore>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_exerciseStore.isGetExercisesLoading) {
      _exerciseStore.getExercisesByLectureId();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _findIndexInLectureListById() {
    for (int i = 0; i < _lectureStore.lectureList!.lectures.length; i++) {
      if (_lectureStore.lectureList!.lectures[i].lectureId ==
          _exerciseStore.lectureId) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          //AppBar
          AppBar(
        title: Text(
          _lectureStore
              .lectureList!.lectures[_findIndexInLectureListById()].lectureName,
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            _exerciseStore.resetLectureId();
          },
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inverseSurface,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Theme.of(context).colorScheme.primary,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                indicator: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(40),
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
                tabs: [
                  //Tab "Lý thuyết"
                  Tab(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text('Lý thuyết',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  //Tab "Luyện tập"
                  Tab(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text('Luyện tập',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Observer(builder: (context) {
              return _exerciseStore.isGetExercisesLoading
                  ? AbsorbPointer(
                      absorbing: true,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                          ),
                          const CustomProgressIndicatorWidget(),
                        ],
                      ),
                    )
                  // ? Text('Loading...')
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        //Tab "Lý thuyết" content
                        DividedLectureListItem(),

                        //Tab "Luyện tập" content
                        ExerciseListItem(),
                      ],
                    );
            }),
          ),
        ],
      ),
    );
  }
}
