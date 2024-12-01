// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';

import 'lecture_item.dart';

class LecturesInTopicAndLevel extends StatelessWidget {
  final String levelId;

  LecturesInTopicAndLevel({super.key, required this.levelId});

  final LectureStore lectureStore = getIt<LectureStore>();

  @override
  Widget build(BuildContext context) {
    LectureList lecturesInTopicAndLevel =
        lectureStore.getLectureListByLevelId(levelId);
    
    if(lecturesInTopicAndLevel.lectures.isEmpty){
      return const Center(child: Text("Không có bài giảng"));
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: lecturesInTopicAndLevel.lectures.length,
        itemBuilder: (context, index) {
          return LectureItem(
            lecture: lecturesInTopicAndLevel.lectures[index],
          );
        },
      ),
    );
  }
}

//Cái này khác với cái trên là có observer hiện tại thì nghĩ k cần observer chỗ này nữa
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mela/di/service_locator.dart';
// import 'package:mela/domain/entity/lecture/lecture_list.dart';
// import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';

// import 'lecture_item.dart';

// class LecturesInTopicAndLevel extends StatefulWidget {
//   final String levelId;

//   LecturesInTopicAndLevel({super.key, required this.levelId});

//   @override
//   State<LecturesInTopicAndLevel> createState() =>
//       _LecturesInTopicAndLevelState();
// }

// class _LecturesInTopicAndLevelState extends State<LecturesInTopicAndLevel>{
//   final LectureStore lectureStore = getIt<LectureStore>();


//   @override
//   Widget build(BuildContext context) {

//     return Observer(builder: (context) {
//       LectureList lecturesInTopicAndLevel =
//           lectureStore.getLectureListByLevelId(widget.levelId);

//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: lecturesInTopicAndLevel.lectures.length,
//           itemBuilder: (context, index) {
//             return LectureItem(
//               lecture: lecturesInTopicAndLevel.lectures[index],
//             );
//           },
//         ),
//       );
//     });
//   }
// }



