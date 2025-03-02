import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/widgets/general_infor.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/widgets/topic_lecture_listview.dart';
import 'package:mobx/mobx.dart';
import '../../utils/routes/routes.dart';

class TopicLectureInLevelScreen extends StatefulWidget {
  TopicLectureInLevelScreen({super.key});

  @override
  State<TopicLectureInLevelScreen> createState() =>
      _TopicLectureInLevelScreenState();
}

class _TopicLectureInLevelScreenState extends State<TopicLectureInLevelScreen> {
  final TopicLectureStore _topicLectureStore = getIt<TopicLectureStore>();

  late final ReactionDisposer _unAuthorizedReactionDisposer;
  @override
  void initState() {
    super.initState();
    //routeObserver.subscribe(this, ModalRoute.of(context));

    //for only refresh token expired
    _unAuthorizedReactionDisposer = reaction(
      (_) => _topicLectureStore.isUnAuthorized,
      (value) {
        if (value) {
          _topicLectureStore.isUnAuthorized = false;
          _topicLectureStore.resetErrorString();
          //Remove all routes in stack
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginOrSignupScreen, (route) => false);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _unAuthorizedReactionDisposer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_topicLectureStore.isGetTopicLectureLoading) {
      _topicLectureStore.getListTopicLectureInLevel();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("AllLecturesInTopicScreen");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Text(
            _topicLectureStore.currentLevel!.levelName,
            style: Theme.of(context)
                .textTheme
                .heading
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
              //_lectureStore.resetTopic();
              _topicLectureStore.resetErrorString();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Observer(builder: (context) {
                if (_topicLectureStore.errorString.isNotEmpty ||
                    _topicLectureStore.topicLectureInLevelList == null) {
                  return const SizedBox.shrink();
                }
                return IconButton(
                  onPressed: () {
                    _topicLectureStore.resetErrorString();
                    Navigator.of(context).pushNamed(Routes.searchScreen);
                  },
                  icon: const Icon(Icons.search),
                  color: Theme.of(context).colorScheme.onPrimary,
                );
              }),
            )
          ],
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.tertiary,
            unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary, width: 2),
            ),
            tabs: const [
              Tab(text: "Thông tin chung"),
              Tab(text: "Chi tiết bài học"),
            ],
          ),
        ),
        body: Observer(builder: (context) {
          return _topicLectureStore.isGetTopicLectureLoading
              ? AbsorbPointer(
                  absorbing: true,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Theme.of(context)
                            .colorScheme
                            .surface,
                      ),
                      const RotatingImageIndicator(),
                    ],
                  ),
                )
              : TabBarView(
                  children: (_topicLectureStore.errorString.isEmpty &&
                          _topicLectureStore.topicLectureInLevelList != null)
                      ? [GeneralInfor(), TopicLectureListview()]
                      : [
                          Center(
                            child: Text(
                              _topicLectureStore.errorString,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          Center(
                            child: Text(
                              _topicLectureStore.errorString,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                );
        }),
      ),
    );
  }
}
