import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        // margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          gradient: isAI
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.secondaryContainer.withOpacity(1),
                    Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context)
                        .colorScheme
                        .buttonYesBgOrText
                        .withOpacity(0.6),
                    Theme.of(context)
                        .colorScheme
                        .buttonYesBgOrText
                        .withOpacity(0.9),
                  ],
                ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: isAI
                    ? Theme.of(context).colorScheme.textInBg1.withOpacity(0.1)
                    : Theme.of(context).colorScheme.buttonNoBorder,
                spreadRadius: 1.5,
                blurRadius: 1,
                offset: isAI ? const Offset(3, 6) : const Offset(0, 0)),
          ],
        ),
        child: currentMessage.message == null
            ? LoadingAnimationWidget.staggeredDotsWave(
                color: Theme.of(context).colorScheme.buttonYesBgOrText,
                size: 28,
              )
            : Text(
                currentMessage.message!,
                style: isAI
                    ? Theme.of(context).textTheme.content.copyWith(
                        color: Colors.black,
                        fontSize: 17,
                        letterSpacing: 0.7,
                        height: 1.8)
                    : const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        letterSpacing: 0.7,
                        height: 1.8),
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...[
                      SvgPicture.asset(
                        Assets.like,
                        // color: Theme.of(context).colorScheme.primary,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        Assets.unlike,
                        // color: Theme.of(context).colorScheme.primary,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        Assets.copy,
                        // color: Theme.of(context).colorScheme.primary,
                        width: 20,
                      ),
                    ]
                        .expand((item) => [item, const SizedBox(width: 5)])
                        .toList(),
                  ],
                ),
              ],
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}
