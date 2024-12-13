import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/progress_indicator_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/widgets/topic_lecture_listview.dart';
import 'package:mobx/mobx.dart';
import '../../utils/routes/routes.dart';
import 'widgets/lectures_in_topic.dart';

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
                            .surface
                            .withOpacity(0.2),
                      ),
                      const CustomProgressIndicatorWidget(),
                    ],
                  ),
                )
              : TabBarView(
                  children: (_topicLectureStore.errorString.isEmpty &&
                          _topicLectureStore.topicLectureInLevelList != null)
                      ? [
                          Text(
                              "Thông tin chung của khối lớp ${_topicLectureStore.currentLevel!.levelName}"),
                          TopicLectureListview()
                        ]
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



//Version replace 2 
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mela/constants/app_theme.dart';
// import 'package:mela/core/widgets/progress_indicator_widget.dart';
// import 'package:mela/di/service_locator.dart';
// import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';
// import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';
// import 'widgets/lectures_in_topic_and_level.dart';

// class AllLecturesInTopicScreen extends StatefulWidget {
//   AllLecturesInTopicScreen({super.key});

//   @override
//   State<AllLecturesInTopicScreen> createState() =>
//       _AllLecturesInTopicScreenState();
// }

// class _AllLecturesInTopicScreenState extends State<AllLecturesInTopicScreen> {
//   final TopicStore _topicStore = getIt<TopicStore>();

//   final LectureStore _lectureStore = getIt<LectureStore>();

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_lectureStore.isGetLecturesLoading) {
//       _lectureStore.getListLectureByTopicIdAndLevelId();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("FlutterSa: AllLecturesInTopicScreen");
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           title: Text(
//             _topicStore.topicList!.topics[_lectureStore.toppicId].topicName,
//             style: Theme.of(context)
//                 .textTheme
//                 .heading
//                 .copyWith(color: Theme.of(context).colorScheme.primary),
//           ),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () {
//               Navigator.of(context).pop();
//               // print("FlutterSa<------: trc khi back ${_lectureStore.toppicId}");
//               _lectureStore.resetTopicId();
//               // print("FlutterSa<------: sau khi back ${_lectureStore.toppicId}");
//             },
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.search),
//                 color: Theme.of(context).colorScheme.onPrimary,
//               ),
//             )
//           ],
//           bottom: TabBar(
//             labelColor: Theme.of(context).colorScheme.tertiary,
//             unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
//             dividerColor: Colors.transparent,
//             overlayColor: WidgetStateProperty.all(Colors.transparent),
//             indicator: UnderlineTabIndicator(
//               borderSide: BorderSide(
//                   color: Theme.of(context).colorScheme.tertiary, width: 2),
//             ),
//             tabs: const [
//               Tab(text: "Tiểu học"),
//               Tab(text: "Trung học"),
//               Tab(text: "Phổ thông"),
//             ],
//           ),
//         ),
//         body: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               TabBarView(
//                 children: [
//                   LecturesInTopicAndLevel(levelId: 0),
//                   LecturesInTopicAndLevel(levelId: 1),
//                   LecturesInTopicAndLevel(levelId: 2),
//                 ],
//               ),
//               Observer(
//                 builder: (context) {
//                   return Visibility(
//                     visible: _lectureStore.isGetLecturesLoading,
//                     child: AbsorbPointer(
//                       absorbing: true,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Container(
//                             color: Theme.of(context)
//                                 .colorScheme
//                                 .primary
//                                 .withOpacity(0.8),
//                           ),
//                           const CustomProgressIndicatorWidget(),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
