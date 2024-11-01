import 'package:flutter/material.dart';
import 'package:mela/screens/lectures_in_topic_screen/all_lectures_in_topic_screen.dart';

import '../../../models/topic.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AllLecturesInTopicScreen(currentTopic: topic),
          ),
        );
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
              width: 65,
              child: Text(
                topic.topicName,
                textAlign: TextAlign.center,
                maxLines: null,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
