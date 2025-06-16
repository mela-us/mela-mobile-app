// import 'package:flutter/material.dart';
// import 'package:mela/constants/app_theme.dart';
// import 'package:mela/constants/assets.dart';
// import 'package:mela/di/service_locator.dart';
// import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
// import 'package:mela/presentation/thread_chat/thread_chat_screen.dart';
// import 'package:mela/presentation/thread_chat_learning/store/thread_chat_learning_store/thread_chat_learning_store.dart';
// import 'package:mela/presentation/thread_chat_learning/thread_chat_learning_screen.dart';
// import 'package:mela/utils/routes/routes.dart';

// class DraggableAIButton extends StatefulWidget {
//   @override
//   _DraggableAIButtonState createState() => _DraggableAIButtonState();
// }

// class _DraggableAIButtonState extends State<DraggableAIButton> {
//   final ThreadChatLearningStore _threadChatLearningStore =
//       getIt.get<ThreadChatLearningStore>();
//   double _topPosition = 60;
//   final double _buttonSize = 80.0;
//   final double _rightPosition = -2;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//         right: _rightPosition,
//         top: _topPosition,
//         child: GestureDetector(
//           onPanUpdate: (details) {
//             // Cập nhật vị trí khi kéo thả theo trục Y
//             setState(() {
//               _topPosition += details.delta.dy;

//               // Giới hạn vị trí để không vượt ra ngoài màn hình
//               if (_topPosition < 0) {
//                 _topPosition = 0;
//               }
//               if (_topPosition >
//                   MediaQuery.of(context).size.height - _buttonSize - 250) {
//                 _topPosition =
//                     MediaQuery.of(context).size.height - _buttonSize - 250;
//               }
//             });
//           },
//           onTap: () {
//             _threadChatLearningStore.clearConversation();

//             Navigator.of(context).push(
//               PageRouteBuilder(
//                 settings:
//                     const RouteSettings(name: Routes.threadChatLearningScreen),
//                 pageBuilder: (context, animation, secondaryAnimation) =>
//                     ThreadChatLearningScreen(),
//                 transitionsBuilder:
//                     (context, animation, secondaryAnimation, child) {
//                   const begin = Offset(1.0, 0.0);
//                   const end = Offset.zero;
//                   const curve = Curves.easeInOut;

//                   var tween = Tween(begin: begin, end: end)
//                       .chain(CurveTween(curve: curve));
//                   var offsetAnimation = animation.drive(tween);

//                   return ClipRect(
//                     child: SlideTransition(
//                       position: offsetAnimation,
//                       child: child,
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//           child: Container(
//             // height: _buttonSize,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: const BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   bottomLeft: Radius.circular(20)),
//               color: Colors.white,
//               border: const Border(
//                   bottom: BorderSide(
//                     color: Colors.blueAccent,
//                     width: 1,
//                   ),
//                   left: BorderSide(
//                     color: Colors.blueAccent,
//                     width: 1,
//                   ),
//                   top: BorderSide(
//                     color: Colors.blueAccent,
//                     width: 1,
//                   )),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Image.asset(Assets.nav_chat,
//                   width: 24,
//                   height: 24,
//                   color: Theme.of(context).colorScheme.buttonYesBgOrText),
//             ),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/question/question.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
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
  final QuestionStore _questionStore = getIt<QuestionStore>();
  final SingleQuestionStore _singleQuestionStore = getIt<SingleQuestionStore>();
  double _topPosition = 60;
  final double _buttonSize = 80.0;
  final double _rightPosition = -2;
  late List<Question> questions;
  @override
  void initState() {
    super.initState();
    questions = _questionStore.questionList!.questions!;
    _threadChatLearningStore.getTokenChat();
  }

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
              //Nếu lần đầu mở qua hoặc là cùng câu hỏi cũ thì xóa conversation và set lại question mới
              if (_threadChatLearningStore.currentQuestion.questionId == null ||
                  _threadChatLearningStore.currentQuestion.questionId! !=
                      questions[_singleQuestionStore.currentIndex].questionId) {
                _threadChatLearningStore.clearConversation();
                _threadChatLearningStore
                    .setQuestion(questions[_singleQuestionStore.currentIndex]);
              }

              Navigator.of(context).push(
                PageRouteBuilder(
                  settings: const RouteSettings(
                      name: Routes.threadChatLearningScreen),
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
            child: Stack(
              children: [
                CustomPaint(
                  size: const Size(70, 140),
                  painter: RPSCustomPainter(context: context),
                ),
                Positioned(
                  right: 8,
                  top: 54,
                  child: Image.asset(Assets.nav_chat,
                      width: 28,
                      height: 28,
                      color: Theme.of(context).colorScheme.buttonYesBgOrText),
                ),
              ],
            )));
  }
}

class RPSCustomPainter extends CustomPainter {
  BuildContext context;
  RPSCustomPainter({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0021000, size.height * 0.1248500);
    path_0.quadraticBezierTo(size.width * 1.0008500, size.height * 0.2504000,
        size.width * 0.4981000, size.height * 0.3718000);
    path_0.cubicTo(
        size.width * 0.2995000,
        size.height * 0.4247750,
        size.width * 0.2989000,
        size.height * 0.5768500,
        size.width * 0.5008500,
        size.height * 0.6264500);
    path_0.quadraticBezierTo(size.width * 0.9950500, size.height * 0.7489000,
        size.width * 1.0001000, size.height * 0.8743750);
    path_0.lineTo(size.width * 1.0021000, size.height * 0.1248500);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = Theme.of(context).colorScheme.buttonYesBgOrText
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
