import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/topic/topic.dart';
import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/widgets/exercise_list_item.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';

import '../../constants/route_observer.dart';
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
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;

  ExerciseStore _exerciseStore = getIt<ExerciseStore>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    if (!_exerciseStore.isGetExercisesLoading) {
      _exerciseStore.getExercisesByLectureId();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          //AppBar
          AppBar(
        title: Observer(builder: (context) {
          // print("Lecture TopicId");
          // print(_lectureStore.toppicId);
          return _exerciseStore.errorString.isEmpty
              ? Text(
                  _exerciseStore.currentLecture!.lectureName,
                  style: Theme.of(context)
                      .textTheme
                      .heading
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                )
              : Container();
        }),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            // _exerciseStore.resetLectureId();
            _exerciseStore.resetErrorString();
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
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.8),
                          ),
                          const CustomProgressIndicatorWidget(),
                        ],
                      ),
                    )
                  // ? Text('Loading...')
                  : TabBarView(
                      controller: _tabController,
                      children: _exerciseStore.errorString.isEmpty
                          ? [
                              //Tab "Lý thuyết" content
                              DividedLectureListItem(),

                              //Tab "Luyện tập" content
                              ExerciseListItem(),
                            ]
                          : [
                              Center(
                                child: Text(
                                  _exerciseStore.errorString,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                              Center(
                                child: Text(
                                  _exerciseStore.errorString,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                    );
            }),
          ),
        ],
      ),
    );
  }
}
