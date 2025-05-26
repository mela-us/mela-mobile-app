import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/domain/entity/lecture/lecture.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/home_screen/widgets/button_individual_exercise.dart';
import 'package:mela/presentation/home_screen/widgets/level_item.dart';
import 'package:mela/presentation/list_proposed_new_lecture/list_proposed_new_lecture.dart';
import 'package:mela/presentation/streak/streak_action_icon.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/widgets/lecture_item_copy.dart';
import 'package:mobx/mobx.dart';

import '../../di/service_locator.dart';
import '../../themes/default/colors_standards.dart';
import '../../utils/animation_helper/animation_helper.dart';
import '../../utils/routes/routes.dart';
import '../streak/store/streak_store.dart';
import '../streak/streak_dialog.dart';
import '../topic_lecture_in_level_screen/widgets/lecture_item.dart';
import 'widgets/cover_image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //stores:---------------------------------------------------------------------
  final LevelStore _levelStore = getIt<LevelStore>();
  final StreakStore _streakStore = getIt<StreakStore>();

  late final ReactionDisposer _unAuthorizedReactionDisposer;
  final GlobalKey _buttonIndividualExerciseKey = GlobalKey();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Add ScrollController
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    //routeObserver.subscribe(this, ModalRoute.of(context));

    //for only refresh token expired
    _unAuthorizedReactionDisposer = reaction(
      (_) => _levelStore.isUnAuthorized,
      (value) {
        if (value) {
          _levelStore.isUnAuthorized = false;
          _levelStore.resetErrorString();
          //Remove all routes in stack
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginOrSignupScreen, (route) => false);
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //print("========TopicError: ${_topicStore.errorString}");
    // check to see if already called api
    if (!_levelStore.loading) {
      _levelStore.getLevels();
      _levelStore.getTopics();
      _levelStore.getAreLearningLectures();
    }
  }

  @override
  void dispose() {
    //routeObserver.unsubscribe(this);
    _animationController.dispose();

    _unAuthorizedReactionDisposer();
    _scrollController.dispose();

    super.dispose();
  }

  // void _scrollToButtonIndividualExercise() {
  //   final RenderBox? renderBox = _buttonIndividualExerciseKey.currentContext
  //       ?.findRenderObject() as RenderBox?;
  //   if (renderBox != null) {
  //     final position = renderBox.localToGlobal(Offset.zero).dy;
  //     final scrollOffset = position + _scrollController.offset - 100;
  //     _scrollController
  //         .animateTo(
  //       scrollOffset,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     )
  //         .then((_) {
  //       _animationController.forward().then((_) {
  //         _animationController.reverse();
  //       });
  //     });
  //   }
  // }
  void _scrollToEnd() {
    _scrollController
        .animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("^^^^^^^^^^^^^^^^^^ErrorString in Courses_Screen1: ${_topicStore.errorString}");
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text("MELA",
              style: Theme.of(context)
                  .textTheme
                  .heading
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        actions: [
          Observer(builder: (context) {
            if (_levelStore.errorString.isNotEmpty ||
                _levelStore.lecturesAreLearningList == null ||
                _levelStore.topicList == null ||
                _levelStore.levelList == null) {
              return const SizedBox.shrink();
            }
            //Icon search
            return IconButton(
              onPressed: () {
                //eg: incourse no wifi, enter search, turnon wifi, back to app
                _levelStore.resetErrorString();
                Navigator.of(context).pushNamed(Routes.searchScreen);
              },
              icon: const Icon(Icons.search),
              color: Theme.of(context).colorScheme.onPrimary,
            );
          }),
          InkWell(
              onTap: () {
                _showStreakDialog();
              },
              child: const StreakActionIcon()),
          const SizedBox(width: 24),
        ],
      ),
      body: Observer(
        builder: (context) {
          //print("^^^^^^^^^^^^^^^^^^ErrorString in Courses_Screen2: ${_topicStore.errorString}");
          if (_levelStore.loading) {
            return AbsorbPointer(
              absorbing: true,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(0.8),
                  ),
                  const RotatingImageIndicator(),
                ],
              ),
            );
          }
          //print("^^^^^^^^^^^^^^^^^^ErrorString in Courses_Screen 3: ${_topicStore.errorString}");
          if (_levelStore.errorString.isNotEmpty ||
              _levelStore.lecturesAreLearningList == null ||
              _levelStore.topicList == null ||
              _levelStore.levelList == null) {
            return Center(
              child: Text(_levelStore.errorString,
                  style: const TextStyle(color: Colors.red)),
            );
          }
          //print("build In CoursesScreen+++++++++++++++++++++++++++++++");
          return DefaultTabController(
            length: 2,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Cover Image Introduction
                      CoverImageWidget(
                        onPressed: _scrollToEnd,
                      ),
                      const SizedBox(height: 15),
                      //Levels Grid
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 0,
                          childAspectRatio: 1,
                          mainAxisExtent: 80, // set the height of each item
                        ),
                        itemCount: _levelStore.levelList!.levelList.length,
                        itemBuilder: (context, index) {
                          return Animate(
                            onPlay: (controller) async {
                              await Future.delayed(
                                  AnimationHelper.getAnimationDelayOfIndex(
                                      index));
                              if (mounted) {
                                controller.repeat(
                                  period: AnimationHelper
                                      .getAnimationDurationOfIndex(index),
                                );
                              }
                            },
                            effects: [
                              MoveEffect(
                                begin: const Offset(0, 0),
                                end: const Offset(0, -11),
                                duration: 200.ms,
                                curve: Curves.elasticOut,
                              ),
                              MoveEffect(
                                begin: const Offset(0, -11),
                                end: const Offset(0, 0),
                                duration: 500.ms,
                                curve: Curves.elasticOut,
                              ),
                            ],
                            child: LevelItem(
                              level: _levelStore.levelList!.levelList[index],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: TabBar(
                          // key: _buttonIndividualExerciseKey,
                          labelColor: Theme.of(context).colorScheme.tertiary,
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.onSecondary,
                          dividerColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          indicator: UnderlineTabIndicator(
                            insets: const EdgeInsets.symmetric(horizontal: 50),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 2),
                          ),
                          tabs: const [
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.school, size: 14),
                                  SizedBox(width: 12),
                                  Text(
                                    "Cùng ôn tập",
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.integration_instructions_outlined,
                                      size: 14),
                                  SizedBox(width: 12),
                                  Text(
                                    "Hôm nay học gì?",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 420,
                        child: TabBarView(
                          children: [
                            // Tab 1: Bài giảng đang học
                            _levelStore.lecturesAreLearningList!.lectures
                                    .isNotEmpty
                                ? _buildRoadList()
                                : const Center(
                                    child: Text("Không có bài giảng đang học"),
                                  ),
                            // Tab 2: Bài giảng đề xuất
                            ListProposedNewLectureScreen()
                          ],
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Image.asset(
                      //         'assets/images/fire.png',
                      //         width: 20,
                      //         height: 28,
                      //         fit: BoxFit.contain,
                      //       ),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       Text(
                      //         "Bài tập nhanh",
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .subTitle
                      //             .copyWith(
                      //                 color: ColorsStandards
                      //                     .textColorInBackground2),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 10),

                      // AnimatedBuilder(
                      //     animation: _scaleAnimation,
                      //     builder: (context, child) {
                      //       return Transform.scale(
                      //         scale: _scaleAnimation.value,
                      //         child: ButtonIndividualExercise(
                      //             key: _buttonIndividualExerciseKey,
                      //             leadingIcon: SvgPicture.asset(
                      //               Assets.mela_think,
                      //               width: 40,
                      //             ),
                      //             textButton: "Ôn tập nhanh cùng MELA",
                      //             onPressed: () {}),
                      //       );
                      //     }),
                      const SizedBox(height: 20),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoadList() {
    // return LayoutBuilder(
    //   builder: (context, constrain) {
    //     double width = constrain.maxWidth;
    //     double lineX = width * 0.5 - 1; // Center the line
    //     return Stack(
    //       children: [
    //         Positioned(
    //           left: lineX,
    //           top: 0,
    //           bottom: 0,
    //           width: 2,
    //           child: Container(
    //             color: Theme.of(context).colorScheme.tertiary,
    //           ),
    //         ),
    //         ListView.builder(
    //           physics: const NeverScrollableScrollPhysics(),
    //           shrinkWrap: true,
    //           itemCount: _levelStore.lecturesAreLearningList!.lectures.length,
    //           itemBuilder: (context, index) {
    //             return LectureItemCopy(
    //               isFirst: index == 0,
    //               isLast: index ==
    //                   _levelStore.lecturesAreLearningList!.lectures.length - 1,
    //               lecture: _levelStore.lecturesAreLearningList!.lectures[index],
    //             );
    //           },
    //         )
    //       ],
    //     );
    //   },
    // );
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _levelStore.lecturesAreLearningList!.lectures.length,
      itemBuilder: (context, index) {
        List<Lecture> lectures = _levelStore.lecturesAreLearningList!.lectures;
        return LectureItemCopy(
          isFirst: index == 0,
          isLast: index == lectures.length - 1,
          lecture: lectures[index],
          isPursuing: (index == 0 && lectures[0].progress < 0.8) ||
              (index != 0 &&
                  lectures[index].progress < 0.8 &&
                  lectures[index - 1].progress >=
                      0.8), // Check if the lecture is in progress
        );
      },
    );
  }

  void _showStreakDialog() {
    if (_streakStore.isLoading) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreakDialog(
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
