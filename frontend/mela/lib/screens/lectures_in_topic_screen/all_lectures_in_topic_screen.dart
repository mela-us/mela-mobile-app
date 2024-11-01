import 'package:flutter/material.dart';
import 'package:mela/screens/lectures_in_topic_screen/widgets/lectures_in_topic_and_level.dart';

import '../../constants/global.dart';
import '../../models/topic.dart';
import '../../themes/default/colors_standards.dart';
import '../../themes/default/text_styles.dart';


class AllLecturesInTopicScreen extends StatelessWidget {
  Topic currentTopic;

  AllLecturesInTopicScreen({super.key, required this.currentTopic});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsStandards.AppBackgroundColor,
          elevation: 0,
          title: 
          TextStandard.Heading(currentTopic.topicName,
                      ColorsStandards.textColorInBackground1),
          
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
                color: ColorsStandards.AppBarContentColor,
              ),
            )
          ],
          bottom: TabBar(
            labelColor: ColorsStandards.buttonYesColor1,
            unselectedLabelColor: ColorsStandards.guideTextColor,
            indicatorColor: ColorsStandards.buttonYesColor1,
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
        backgroundColor: ColorsStandards.AppBackgroundColor,
      ),
    );
  }
}
