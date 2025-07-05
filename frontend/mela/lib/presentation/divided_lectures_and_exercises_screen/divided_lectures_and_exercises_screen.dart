import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/icon_widget/error_icon_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/widgets/exercise_list_item.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';
import '../../core/widgets/image_progress_indicator.dart';
import 'widgets/divided_lecture_list_item.dart';

class DividedLecturesAndExercisesScreen extends StatefulWidget {
  int initialTabIndex; // Default to the first tab displayed
  DividedLecturesAndExercisesScreen({super.key, this.initialTabIndex = 0});
  @override
  _DividedLecturesAndExercisesScreenState createState() =>
      _DividedLecturesAndExercisesScreenState();
}

class _DividedLecturesAndExercisesScreenState
    extends State<DividedLecturesAndExercisesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ExerciseStore _exerciseStore = getIt<ExerciseStore>();

  late final ReactionDisposer _unAuthorizedReactionDisposer;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    //for only refresh token expired
    _unAuthorizedReactionDisposer = reaction(
      (_) => _exerciseStore.isUnAuthorized,
      (value) {
        print("isUnAuthorized in DivideLecture: $value");
        if (value) {
          print("----------->isUnAuthorized DivideLecture: $value");
          _exerciseStore.isUnAuthorized = false;
          _exerciseStore.resetErrorString();
          //Remove all routes in stack
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginOrSignupScreen, (route) => false);
        }
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set the initial tab index after the first frame is rendered
      _tabController.animateTo(widget.initialTabIndex);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    if (!_exerciseStore.isGetExercisesLoading) {
      _exerciseStore.getDividedLecturesByLectureId();
      _exerciseStore.getExercisesByLectureId();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _unAuthorizedReactionDisposer();
    //routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          //AppBar
          AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          _exerciseStore.currentLecture!.lectureName,
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(true);
            // _exerciseStore.resetLectureId();
            _exerciseStore.resetErrorString();
          },
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inverseSurface,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Theme.of(context).colorScheme.primary,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicator: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
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
                          const RotatingImageIndicator(),
                        ],
                      ),
                    )
                  // ? Text('Loading...')
                  : TabBarView(
                      controller: _tabController,
                      children: (_exerciseStore.errorString.isEmpty &&
                              _exerciseStore.dividedLectureList != null &&
                              _exerciseStore.exerciseList != null)
                          ? [
                              //Tab "Lý thuyết" content
                              DividedLectureListItem(
                                onGoToExercise: () {
                                  _tabController.animateTo(1);
                                },
                              ),

                              //Tab "Luyện tập" content
                              ExerciseListItem(),
                            ]
                          : [
                              const ErrorIconWidget(
                                message:
                                    "Đang có lỗi. Bạn chờ Mela một chút nhé!",
                              ),
                              const ErrorIconWidget(
                                message:
                                    "Đang có lỗi. Bạn chờ Mela một chút nhé!",
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
