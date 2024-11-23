//---Version 1:
import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';

import '../../../di/service_locator.dart';
import '../../../domain/entity/topic/topic.dart';
import '../../../utils/routes/routes.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  TopicItem({super.key, required this.topic});

  final LectureStore _lectureStore = getIt<LectureStore>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _lectureStore.setCurrentTopic(topic);
        Navigator.of(context).pushNamed(Routes.allLecturesInTopicScreen);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Logo topic
            SizedBox(
              width: 55,
              height: 55,
              child: Image.asset(
                topic.imageTopicPath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 4),

            //Name topic
            SizedBox(
              width: 75,
              child: Text(
                topic.topicName,
                textAlign: TextAlign.center,
                maxLines: null,
                overflow: TextOverflow.visible,
                style: Theme.of(context).textTheme.miniCaption.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//Version 2
// import 'package:flutter/material.dart';
// import 'package:mela/constants/app_theme.dart';
// import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';
// import 'package:mobx/mobx.dart';

// import '../../../di/service_locator.dart';
// import '../../../domain/entity/topic/topic.dart';
// import '../../../utils/routes/routes.dart';

// class TopicItem extends StatefulWidget {
//   final Topic topic;
//   TopicItem({super.key, required this.topic});

//   @override
//   State<TopicItem> createState() => _TopicItemState();
// }

// class _TopicItemState extends State<TopicItem> {
//   final LectureStore _lectureStore = getIt<LectureStore>();
//   //disposers:-----------------------------------------------------------------
//   late final ReactionDisposer _topicItemReactionDisposer;
//   @override
//   void initState() {
//     super.initState();
//     _topicItemReactionDisposer =
//         reaction((_) => _lectureStore.toppicId, (int toppicId){
//       // print("FlutterSa------>1: toppicId is $toppicId");
//       //need to check toppicId==widget.topic.topicId because when buildUI
//       //it will create 6 ToppicItem, mean 6 reaction different, check to can run only one reaction

//       //need to check toppicId>0 when press back button
//       //topicId will be -1, so need to check >0 to not push to AllLecturesInTopicScreen
//       if (toppicId >= 0 && toppicId == widget.topic.topicId) {
//         // print("FlutterSa------>2: toppicId is $toppicId");
//         Navigator.of(context).pushNamed(Routes.allLecturesInTopicScreen);
//         // await _lectureStore.getListLectureByTopicIdAndLevelId();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _topicItemReactionDisposer();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("FlutterSa: TopicItem ${widget.topic.topicName}");
//     return InkWell(
//       onTap: () async {
//         _lectureStore.setTopicId(widget.topic.topicId);
//       },
//       child: Container(
//         width: double.infinity,
//         height: double.infinity,
//         padding: const EdgeInsets.all(0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             //Logo topic
//             SizedBox(
//               width: 55,
//               height: 55,
//               child: Image.asset(
//                 widget.topic.imageTopicPath,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             const SizedBox(height: 4),

//             //Name topic
//             SizedBox(
//               width: 75,
//               child: Text(
//                 widget.topic.topicName,
//                 textAlign: TextAlign.center,
//                 maxLines: null,
//                 overflow: TextOverflow.visible,
//                 style: Theme.of(context).textTheme.miniCaption.copyWith(
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








