import 'package:flutter/material.dart';
import 'package:mela/screens/lectures_in_topic_screen/widgets/lectures_in_topic_and_level.dart';

import '../../constants/global.dart';
import '../../models/topic.dart';

// class AllLecturesInTopicScreen extends StatelessWidget {
//   Topic currentTopic;
//   AllLecturesInTopicScreen({super.key, required this.currentTopic});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           currentTopic.topicName,
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         bottom: const TabBar(
//           labelColor: Colors.blue,
//           unselectedLabelColor: Colors.grey,
//           indicatorColor: Colors.blue,
//           tabs: [
//             Tab(text: "Tiểu học"),
//             Tab(text: "Trung học"),
//             Tab(text: "Phổ thông"),
//           ],
//         ),
//       ),
//       body: DefaultTabController(
//         length: 3,
//         child: TabBarView(
//           children: [
//             // Primary school
//             LecturesInTopicAndLevel(levelId: 0, topicId: currentTopic.topicId),
//             // Secondary school
//             LecturesInTopicAndLevel(levelId: 1, topicId: currentTopic.topicId),
//             // High school
//             LecturesInTopicAndLevel(levelId: 2, topicId: currentTopic.topicId),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.blue[50],
//     );
//   }
// }

class AllLecturesInTopicScreen extends StatelessWidget {
  Topic currentTopic;

  AllLecturesInTopicScreen({super.key, required this.currentTopic});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Global.AppBackgroundColor,
          elevation: 0,
          title: Text(
            currentTopic.topicName,
            style: Global.heading,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: Global.AppBarContentColor,
              ),
            )
          ],
          bottom: TabBar(
            labelColor: Global.buttonYesColor1,
            unselectedLabelColor: Global.guideTextColor,
            indicatorColor: Global.buttonYesColor1,
            tabs: const [
              Tab(text: "Tiểu học"),
              Tab(text: "Trung học"),
              Tab(text: "Phổ thông"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Primary school
            LecturesInTopicAndLevel(levelId: 0, topicId: currentTopic.topicId),
            // Secondary school
            LecturesInTopicAndLevel(levelId: 1, topicId: currentTopic.topicId),
            // High school
            LecturesInTopicAndLevel(levelId: 2, topicId: currentTopic.topicId),
          ],
        ),
        backgroundColor: Global.AppBackgroundColor,
      ),
    );
  }
}
