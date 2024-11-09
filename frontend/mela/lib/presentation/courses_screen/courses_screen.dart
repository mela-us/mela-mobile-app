// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';

// import '../../di/service_locator.dart';

// class CoursesScreen extends StatefulWidget {
//   const CoursesScreen({super.key});

//   @override
//   State<CoursesScreen> createState() => _CoursesScreenState();
// }

// class _CoursesScreenState extends State<CoursesScreen> {
//   //stores:---------------------------------------------------------------------
//   final TopicStore _topicStore = getIt<TopicStore>();

//     @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // check to see if already called api
//     if (!_topicStore.loading) {
//       _topicStore.getTopics();
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Courses"),
//       ),
//       body: Observer(
//         builder: (context) {
//           return _topicStore.loading
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : Column(
//                   children: [
//                     Expanded(
//                       child: ListView.separated(
//                           itemBuilder: (context, position) {
//                             return ListTile(
//                               title: Text( _topicStore
//                                       .topicList!.topics[position].topicName
//                                   ),
//                               onTap: () {
//                                 //
//                               },
//                             );
//                           },
//                           separatorBuilder: (_, position) {
//                             return Divider();
//                           },
//                           itemCount: _topicStore.topicList!.topics.length),
//                     ),
//                         // itemCount: _topicStore.topicList!.topics.length)
//                   ],
//                 );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/courses_screen/store/theme_store/theme_store.dart';
import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';
import 'package:mela/presentation/my_app.dart';

import '../../di/service_locator.dart';
import '../../themes/default/colors_standards.dart';
import 'widgets/cover_image_widget.dart';
import 'widgets/topic_item.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final TopicStore _topicStore = getIt<TopicStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    if (!_topicStore.loading) {
      _topicStore.getTopics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text("MELA",
              style: Theme.of(context)
                  .textTheme
                  .heading
                  .copyWith(color: ColorsStandards.AppBarContentColor)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: ColorsStandards.AppBarContentColor,
          )
        ],
      ),
      body: Observer(
        builder: (context) {
          return _topicStore.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // //Header
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 10),
                        //         child: Text("MELA",
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .heading
                        //                 .copyWith(
                        //                     color: ColorsStandards
                        //                         .AppBarContentColor)),
                        //       ),
                        //       IconButton(
                        //         onPressed: () {},
                        //         icon: const Icon(Icons.search),
                        //         color: ColorsStandards.AppBarContentColor,
                        //       )
                        //     ]),

                        //Cover Image Introduction
                        const CoverImageWidget(),
                        const SizedBox(height: 15),

                        //Topics Grid
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            childAspectRatio: 1,
                            mainAxisExtent: 100, // set the height of each item
                          ),
                          itemCount: _topicStore.topicList!.topics.length,
                          itemBuilder: (context, index) {
                            return TopicItem(
                              topic: _topicStore.topicList!.topics[index],
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                        //Text "Chủ đề đang học"
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/fire.png',
                                width: 20,
                                height: 28,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Chủ đề đang học",
                                style: Theme.of(context)
                                    .textTheme
                                    .subTitle
                                    .copyWith(
                                        color: ColorsStandards
                                            .textColorInBackground2),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("abc"),
                        Text("abc"),
                        Text("abc"),
                        Text("abc"),
                        Text("abc"),
                        //Lectures is learning

                        // Column(
                        //   children: currentLecturesIsLearning.map((lecture) {
                        //     return LectureItem(lecture: lecture);
                        //   }).toList(),
                        // )
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
