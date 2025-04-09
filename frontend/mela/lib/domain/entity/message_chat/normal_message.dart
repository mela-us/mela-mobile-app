import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/image_origin/image_origin.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class NormalMessage extends MessageChat {
  final String? text;
  final List<ImageOrigin>? imageSourceList;

  NormalMessage({
    required bool isAI,
    required this.text,
    this.imageSourceList,
    DateTime? timestamp,
  }) : super(isAI: isAI, type: MessageType.normal, timestamp: timestamp);

  factory NormalMessage.fromJson(
      Map<String, dynamic> content, bool isAI, DateTime? timestamp) {
    if (content.isEmpty) {
      return NormalMessage(
        isAI: true,
        text: "Có lỗi khi tạo nội dung. Xin cảm ơn bạn đã kiên nhẫn.",
        imageSourceList: [],
        timestamp: timestamp,
      );
    }
    return NormalMessage(
      isAI: isAI,
      text: content['text'],
      imageSourceList: content['image_url'] != null
          ? [
              ImageOrigin(
                image: content['image_url'] as String,
                isImageUrl: true,
              )
            ]
          : [],
      timestamp: timestamp,
    );
  }
}
