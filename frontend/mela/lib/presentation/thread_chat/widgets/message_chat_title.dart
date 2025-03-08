import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';

class MessageChatTitle extends StatelessWidget {
  final MessageChat currentMessage;

  const MessageChatTitle({
    super.key,
    required this.currentMessage,
  });

  ///-----Images
  Widget _buildImage(BuildContext context, File image) {
    return GestureDetector(
      onTap: () => _showFullImage(context, image),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Set border radius here
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //Show full image when click into image
  void _showFullImage(BuildContext context, File image) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12), // Rounded edges
                child: Image.file(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    focusColor: Colors.amber,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 30,
                      height: 30,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridImages(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: currentMessage.images!.length >= 3
              ? 3
              : currentMessage.images!.length,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1,
        ),
        itemCount: currentMessage.images!.length,
        itemBuilder: (context, index) {
          return _buildImage(context, currentMessage.images![index]);
        },
      ),
    );
  }

  //---Message
  Widget _buildMessage(BuildContext context) {
    bool isAI = currentMessage.isAI;
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
      // margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: isAI ? Theme.of(context).colorScheme.primary : Colors.grey,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isAI ? Theme.of(context).colorScheme.primary : Colors.grey,
          width: 1,
        ),
      ),
      child: currentMessage.message == null
          ? LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 20,
            )
          : Text(
              currentMessage.message!,
              style: Theme.of(context).textTheme.normal.copyWith(
                    color: isAI ? Colors.white : Colors.black,
                  ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAI = currentMessage.isAI;
    // final _threadChatStore = getIt.get<ThreadChatStore>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment:
            isAI ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment:
                isAI ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              //Grid Images
              if (currentMessage.images != null &&
                  currentMessage.images!.isNotEmpty) ...[
                _buildGridImages(context),
                const SizedBox(height: 5)
              ],
              //Message
              _buildMessage(context),

              //Support Icons: Like, not like, copy
              if (isAI) ...[
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...[
                      Icon(Icons.thumb_down_alt_outlined),
                      Icon(Icons.thumb_up_alt_outlined),
                      Icon(Icons.copy)
                    ]
                        .expand((item) => [item, const SizedBox(width: 5)])
                        .toList(),
                  ],
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
