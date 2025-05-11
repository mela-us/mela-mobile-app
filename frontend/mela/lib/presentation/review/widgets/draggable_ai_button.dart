import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/thread_chat_screen.dart';
import 'package:mela/presentation/thread_chat_learning/store/thread_chat_learning_store/thread_chat_learning_store.dart';
import 'package:mela/presentation/thread_chat_learning/thread_chat_learning_screen.dart';
import 'package:mela/utils/routes/routes.dart';

class DraggableAIButton extends StatefulWidget {
  @override
  _DraggableAIButtonState createState() => _DraggableAIButtonState();
}

class _DraggableAIButtonState extends State<DraggableAIButton> {
  final ThreadChatLearningStore _threadChatLearningStore =
      getIt.get<ThreadChatLearningStore>();
  double _topPosition = 60;
  final double _buttonSize = 80.0;
  final double _rightPosition = -2;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: _rightPosition,
        top: _topPosition,
        child: GestureDetector(
          onPanUpdate: (details) {
            // Cập nhật vị trí khi kéo thả theo trục Y
            setState(() {
              _topPosition += details.delta.dy;

              // Giới hạn vị trí để không vượt ra ngoài màn hình
              if (_topPosition < 0) {
                _topPosition = 0;
              }
              if (_topPosition >
                  MediaQuery.of(context).size.height - _buttonSize - 250) {
                _topPosition =
                    MediaQuery.of(context).size.height - _buttonSize - 250;
              }
            });
          },
          onTap: () {
            _threadChatLearningStore.clearConversation();

            Navigator.of(context).push(
              PageRouteBuilder(
                settings:
                    const RouteSettings(name: Routes.threadChatLearningScreen),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ThreadChatLearningScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return ClipRect(
                    child: SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
          child: Container(
            // height: _buttonSize,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              color: Colors.white,
              border: const Border(
                  bottom: BorderSide(
                    color: Colors.blueAccent,
                    width: 1,
                  ),
                  left: BorderSide(
                    color: Colors.blueAccent,
                    width: 1,
                  ),
                  top: BorderSide(
                    color: Colors.blueAccent,
                    width: 1,
                  )),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(Assets.nav_chat,
                  width: 24,
                  height: 24,
                  color: Theme.of(context).colorScheme.buttonYesBgOrText),
            ),
          ),
        ));
  }
}
