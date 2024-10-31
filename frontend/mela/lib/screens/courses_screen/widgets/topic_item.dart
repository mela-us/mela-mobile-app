import 'package:flutter/material.dart';

import '../../../models/topic.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
