import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mela/domain/entity/message_chat/review_message.dart';

class AnimationOverlayWidget extends StatefulWidget {
  final ReviewStatus status;
  final VoidCallback onDismiss;

  const AnimationOverlayWidget({
    Key? key,
    required this.status,
    required this.onDismiss,
  }) : super(key: key);

  @override
  _AnimationOverlayWidgetState createState() => _AnimationOverlayWidgetState();
}

class _AnimationOverlayWidgetState extends State<AnimationOverlayWidget> {
  bool isCorrect = false;
  @override
  void initState() {
    super.initState();
    isCorrect = (widget.status == ReviewStatus.correct);
    Future.delayed(const Duration(seconds: 20), () {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDismiss,
      child: Container(
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              isCorrect
                  ? 'assets/animations/success.json'
                  : 'assets/animations/fail.json',
              width: isCorrect ? MediaQuery.of(context).size.width : 200,
              height: isCorrect ? 400 : 200,
              fit: BoxFit.contain,
              repeat: true,
            ),
            const SizedBox(height: 8),
            if (!isCorrect)
              Text(
                'Hãy cố gắng kiểm tra lại bài làm nhé.!',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.65,
                      color: Colors.white,
                    ),
              )
            else
              Text(
                'Bạn làm tốt lắm. Cố gắng phát huy nhé!',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.65,
                      color: Colors.white,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
