import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/image_source/image_source.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class NormalMessage extends MessageChat {
  final String? text;
  final List<ImageSource>? imageSourceList;

  NormalMessage({
    required bool isAI,
    required this.text,
    this.imageSourceList,
    DateTime? timestamp,
  }) : super(isAI: isAI, type: MessageType.normal, timestamp: timestamp);

  factory NormalMessage.fromJson(
      Map<String, dynamic> json, bool isAI, DateTime? timestamp) {
    final content = json['content'] as Map<String, dynamic>;
    return NormalMessage(
      isAI: isAI,
      text: content['text'],
      imageSourceList: content['image_url'] != null
          ? [
              ImageSource(
                image: content['image_url'] as String,
                isImageUrl: true,
              )
            ]
          : [],
      timestamp: timestamp,
    );
  }
}
