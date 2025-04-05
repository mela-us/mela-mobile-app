import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/message_chat/explain_message.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/message_loading_response.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mela/constants/assets.dart';

class ExplainMessageTile extends StatelessWidget {
  final ExplainMessage currentMessage;

  const ExplainMessageTile({super.key, required this.currentMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMessage(context),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.like,
                    width: 20,
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset(
                    Assets.unlike,
                    width: 20,
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset(
                    Assets.copy,
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    if (currentMessage.explain != null && currentMessage.explain!.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.buttonYesBgOrText,
          ),
        ),
        child: currentMessage.explain == null
            ? const MessageLoadingResponse()
            : Text(
                currentMessage.explain!,
                style: Theme.of(context).textTheme.content.copyWith(
                      color: Colors.black,
                      fontSize: 17,
                      letterSpacing: 0.65,
                      height: 1.65,
                    ),
              ),
      ),
    );
  }
}
