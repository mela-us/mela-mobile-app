import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/core/widgets/showcase_custom.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/home_screen/store/revise_store/revise_store.dart';
import 'package:mela/presentation/home_screen/widgets/level_item.dart';
import 'package:mela/presentation/home_screen/widgets/revise_view_widget.dart';
import 'package:mela/presentation/list_proposed_new_lecture/list_proposed_new_lecture.dart';
import 'package:mela/presentation/streak/streak_action_icon.dart';
import 'package:mobx/mobx.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../constants/assets.dart';
import '../../core/widgets/icon_widget/error_icon_widget.dart';
import '../../di/service_locator.dart';
import '../../utils/animation_helper/animation_helper.dart';
import '../../utils/routes/routes.dart';
import '../personal/store/personal_store.dart';
import '../streak/store/streak_store.dart';
import '../streak/streak_dialog.dart';
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
  final ReviseStore _reviseStore = getIt<ReviseStore>();
  final PersonalStore _personalStore = getIt<PersonalStore>();

  int _selectedTab = 0;
  int focusLevelIndex = 0;

  late final ReactionDisposer _unAuthorizedReactionDisposer;
  // final GlobalKey _buttonIndividualExerciseKey = GlobalKey();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final _sharedPrefsHelper = getIt.get<SharedPreferenceHelper>();
  GlobalKey _streakKey = GlobalKey();
  BuildContext? showCaseContext;

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
      (_) => _levelStore.isUnAuthorized || _reviseStore.isUnAuthorized,
      (value) {
        if (value) {
          _levelStore.isUnAuthorized = false;
          _reviseStore.isUnAuthorized = false;

          _levelStore.resetErrorString();
          //Remove all routes in stack
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginOrSignupScreen, (route) => false);
        }
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Thêm delay 500ms trước khi gọi startShowCase
      Future.delayed(const Duration(milliseconds: 300), () async {
        final isFirstTimeGoToChat =
            await _sharedPrefsHelper.isFirstTimeGoToChat;
        if (mounted && showCaseContext != null && isFirstTimeGoToChat) {
          ShowCaseWidget.of(showCaseContext!).startShowCase([_streakKey]);
        }
      });
    });
  }

  Future<void> _initReviseData() async {
    if (!_reviseStore.loading) {
      await _reviseStore.getRevision();
    }
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

    _initReviseData();

    _personalStore.getUserInfo();
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

  void _scrollToHead() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }


  @override
  Widget build(BuildContext context) {
    //print("^^^^^^^^^^^^^^^^^^ErrorString in Courses_Screen1: ${_topicStore.errorString}");
    return ShowCaseWidget(
        onComplete: (p0, p1) => print("===============>Complete $p0 $p1"),
        onStart: (p0, p1) => print("================>Start $p0 $p1"),
        onFinish: () {
          print("Finish");
          _sharedPrefsHelper.saveIsFirstTimeSeeStreak(false);
        },
        builder: (context) {
          showCaseContext = context;
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("MELA",
                    style: Theme.of(context).textTheme.heading.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary)),
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
                ShowcaseCustom(
                  keyWidget: _streakKey,
                  isHideActionWidget: true,
                  title: "Mela Streak",
                  description:
                      "Cố gắng làm bài tập hằng ngày để duy trì streak của bạn nhé!",
                  child: InkWell(
                      onTap: () {
                        _showStreakDialog();
                      },
                      child: const StreakActionIcon()),
                ),
                const SizedBox(width: 24),
              ],
            ),
            body: Observer(
              builder: (context) {
                //print("^^^^^^^^^^^^^^^^^^ErrorString in Courses_Screen2: ${_topicStore.errorString}");
                if (_levelStore.loading ||
                    _personalStore.progressLoading ||
                    _personalStore.isLoading) {
                  return AbsorbPointer(
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
                  );
                }
                //print("^^^^^^^^^^^^^^^^^^ErrorString in Courses_Screen 3: ${_topicStore.errorString}");
                if (_levelStore.errorString.isNotEmpty ||
                    _levelStore.lecturesAreLearningList == null ||
                    _levelStore.topicList == null ||
                    _levelStore.levelList == null) {
                  return Center(
                    child: ErrorIconWidget(
                      message: _levelStore.errorString,
                    ),
                  );
                }
                focusLevelIndex = extractLevel(_personalStore.user?.level ?? "Lớp 1");
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
                            const SizedBox(height: 5),
                            Text(
                              "Chào ${_personalStore.user?.name ?? "bạn"} trở lại, học cùng Mela nhé!",
                              style: Theme.of(context).textTheme.subTitle.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 5),
                            //Levels Grid
                            _buildSubHeading("Học tự do"),
                            const SizedBox(height: 20),
                            _buildLevelGridView(),

                            const SizedBox(height: 8),

                            //Study Tab View
                            _buildSubHeading("Dành cho bạn...", onTap: _scrollToEnd),
                            ..._buildStudyTabView(),

                            const SizedBox(height: 20),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        });
  }

  Widget _buildLevelGridView() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 2,
        mainAxisExtent: 70,
      ),
      itemCount:
      _levelStore.levelList!.levelList.length,
      itemBuilder: (context, index) {
        return Animate(
          onPlay: (controller) async {
            await Future.delayed(AnimationHelper
                .getAnimationDelayOfIndex(index));
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
            focus: index == focusLevelIndex,
          ),
        );
      },
    );
  }

  List<Widget> _buildStudyTabView() {
    return [
      ScaleTransition(
        scale: _scaleAnimation,
        child: TabBar(
          onTap: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
          // key: _buttonIndividualExerciseKey,
          labelColor: Theme.of(context).colorScheme.tertiary,
          unselectedLabelColor: Theme.of(context).colorScheme.secondary,
          dividerColor: Colors.transparent,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          indicator: UnderlineTabIndicator(
            insets: const EdgeInsets.symmetric(
                horizontal: 30),
            borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary,
                width: 2),
          ),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  const Icon(Icons.school, size: 14),
                  const SizedBox(width: 10),
                  Text(
                    "Cùng ôn tập nào",
                    style: Theme.of(context).textTheme.subTitle.copyWith(
                        color: _selectedTab == 0
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  const Icon(
                      Icons
                          .integration_instructions_outlined,
                      size: 14),
                  const SizedBox(width: 10),
                  Text(
                    "Học gì tiếp đây?",
                    style: Theme.of(context).textTheme.subTitle.copyWith(
                      color: _selectedTab == 1
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.secondary,
                    ),
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
            // Tab 1: Revision List
            ReviseViewWidget(onScrollToHead: _scrollToHead),

            // Tab 2: Bài giảng đề xuất
            ListProposedNewLectureScreen(onScrollToHead: _scrollToHead),
          ],
        ),
      ),
    ];
  }

  Widget _buildSubHeading(String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Image.asset(Assets.mela_small_icon, height: 20, width: 20),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.subTitle.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.fade,
            maxLines: 1,
          )
        ],
      ),
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

  int extractLevel(String input) {
    final regex = RegExp(r'Lớp\s*(\d+)', caseSensitive: false);
    final match = regex.firstMatch(input);
    if (match != null) {
      return int.parse(match.group(1)!) - 1;
    } else {
      return 0;
    }
  }

}
