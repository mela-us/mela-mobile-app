import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/progress_indicator_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';
import 'widgets/lectures_in_topic_and_level.dart';

class AllLecturesInTopicScreen extends StatefulWidget {
  AllLecturesInTopicScreen({super.key});

  @override
  State<AllLecturesInTopicScreen> createState() =>
      _AllLecturesInTopicScreenState();
}

class _AllLecturesInTopicScreenState extends State<AllLecturesInTopicScreen> {
  final TopicStore _topicStore = getIt<TopicStore>();

  final LectureStore _lectureStore = getIt<LectureStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_lectureStore.isGetLecturesLoading) {
      _lectureStore.getListLectureByTopicIdAndLevelId();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("FlutterSa: AllLecturesInTopicScreen");
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            _topicStore.topicList!.topics[_lectureStore.toppicId].topicName,
            style: Theme.of(context)
                .textTheme
                .heading
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
              // print("FlutterSa<------: trc khi back ${_lectureStore.toppicId}");
              _lectureStore.resetTopicId();
              // print("FlutterSa<------: sau khi back ${_lectureStore.toppicId}");
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
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
              Tab(text: "Tiểu học"),
              Tab(text: "Trung học"),
              Tab(text: "Phổ thông"),
            ],
          ),
        ),
        body: Observer(builder: (context) {
          return _lectureStore.isGetLecturesLoading
              ? AbsorbPointer(
                  absorbing: true,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.8),
                      ),
                      const CustomProgressIndicatorWidget(),
                    ],
                  ),
                )
              : TabBarView(
                  children: [
                    LecturesInTopicAndLevel(levelId: 0),
                    LecturesInTopicAndLevel(levelId: 1),
                    LecturesInTopicAndLevel(levelId: 2),
                  ],
                );
        }),
      ),
    );
  }
}



//Version replace
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
