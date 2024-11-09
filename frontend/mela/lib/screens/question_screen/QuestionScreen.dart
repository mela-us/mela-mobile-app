import 'dart:async';

import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:mela/constants/assets_path.dart';
import 'package:mela/models/QuestionFamily/AQuestion.dart';
import 'package:mela/screens/question_screen/widgets/ExitDialog.dart';
import 'package:mela/screens/question_screen/widgets/QuestionListDialog.dart';
import 'package:mela/screens/question_screen/widgets/SingleQuestionView.dart';
import 'package:mela/screens/result_screen/ResultScreen.dart';

import '../../constants/global.dart';
import '../../themes/default/text_styles.dart';

class QuestionScreen extends StatefulWidget{
  final List<AQuestion> questions;

  const QuestionScreen({super.key, required this.questions});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>{
  late List<AQuestion> _questions;
  late List<String> _answers;
  late Timer _timer;
  late int _currentQuestionIndex;
  late AQuestion _currentQuestion;
  late OverlayEntry quitOverlayEntry;
  late OverlayEntry questionListOverlayEntry;

  Duration _elapsedTime = Duration.zero;

  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questions = widget.questions;
    _currentQuestionIndex = 0;
    _currentQuestion = _questions.elementAt(_currentQuestionIndex);
    _startTimer();

    overlayEntryInit(context);

    _answers = List.filled(_questions.length, '');
  }

  @override
  void didUpdateWidget(covariant QuestionScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questions != widget.questions){
      _questions = widget.questions;
      _currentQuestionIndex = 0; // reset index;
      _currentQuestion = _questions.elementAt(_currentQuestionIndex);
      _answers.clear();
      _answers = List.filled(_questions.length, '');

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  void _startTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState(() {
        _elapsedTime += const Duration(seconds: 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String hours = _elapsedTime.inHours.toString().padLeft(2, '0');
    String minutes = (_elapsedTime.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (_elapsedTime.inSeconds % 60).toString().padLeft(2, '0');

    return Scaffold(
        backgroundColor: Global.AppBackgroundColor,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: Global.PracticeLeftPadding),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _backButtonPressed,
                  child: Image.asset(
                    AssetsPath.arrow_back_longer,
                    width: 26,
                    height: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 11.79),
                  child: TextStandard.Heading(
                      'Luyện tập',
                      Global.AppBarContentColor
                  ),
                )
              ],
            ),
          ),
          backgroundColor: Global.AppBackgroundColor,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Global.PracticeRightPadding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    AssetsPath.clock,
                    width: 30,
                    height: 30,
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 4),
                      child: TextStandard.SubTitle(
                        '$hours:$minutes:$seconds',
                        const Color(0xFF0961F5),
                      )
                  ),
                ],
              ),
            )
          ],
        ),
        body: SingleQuestionView(
          question: _currentQuestion,
          qNumber: _questions.indexOf(_currentQuestion) + 1,
          answer: _answers[_currentQuestionIndex],
          controller: _answerController,
          onContinueTextPressed: (String answer) {
            toNextQuestion(answer);
          },
        ),
        floatingActionButton: DraggableFab(
          child: Container(
            width: 220,
            height: 45,
            margin: const EdgeInsets.fromLTRB(
              0,
              0,
              19,
              30,
            ),
            child: FloatingActionButton(
                onPressed: _questionListButtonPressed,
                backgroundColor: Color(0xFF0961F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0),

                ),
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Image.asset(
                          AssetsPath.select_list,
                          width: 25,
                          height: 25,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        //
                        child: TextStandard.Button(
                            'Danh sách câu',
                            Colors.white
                        ),
                      )
                    ],
                  ),
                )
            ),

          ),
        ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  void overlayEntryInit(BuildContext context){
    quitOverlayEntry = OverlayEntry(
        builder: (BuildContext overlayContext){
          return Stack(
            children: [
              Container(
                color: Colors.black.withOpacity(0.53),
              ),
              Positioned(
                bottom: 34,
                left: 19,
                right: 19,
                child: ExitDialog(
                  onStaying: (bool isStaying) {
                    if(isStaying){
                      quitOverlayEntry.remove();
                    }
                    else {
                      quitOverlayEntry.remove();
                      //Navigator pop().
                    }
                  },
                ),
              )
            ],
          );
        }
    );


    questionListOverlayEntry = OverlayEntry(
        builder: (BuildContext overlayContext) {
          return Stack(
            children: [
              Container(
                color: Colors.black.withOpacity(0.53),
              ),
              Positioned(
                bottom: 34,
                left: 19,
                right: 19,
                child: QuestionListDialog(
                    answers: _answers,
                    onPickedQuestion: (int selected) {
                      if (selected < _answers.length) {
                        toSelectedQuestion(selected);
                        questionListOverlayEntry.remove();
                      }
                    },
                    onSubmitted: (bool isStaying) {
                      if (!isStaying) {
                        questionListOverlayEntry.remove();
                      }
                      else {
                        questionListOverlayEntry.remove();

                        Navigator.pushReplacement(
                          context,
                          _changeScreenAnimation(),
                        );
                      }
                    }),
              )
            ],
          );
        }
    );
  }

  void _backButtonPressed() {
    Overlay.of(context).insert(quitOverlayEntry);
  }


  void _questionListButtonPressed() {
    Overlay.of(context).insert(questionListOverlayEntry);
  }

  void confirmLeaving() {
  }

  void confirmStay() {
  }

  void toNextQuestion(String? answer) {
    setState(() {
      if (answer != null  && answer.isNotEmpty ) {
        _answers[_currentQuestionIndex] = answer;
        _answerController.text = answer;
      }

      if (_currentQuestionIndex == _questions.length-1) return;
      _currentQuestionIndex++;
      //set Question view
      _currentQuestion = _questions.elementAt(_currentQuestionIndex);
      //set Answer view
      setAnswerValue(_currentQuestionIndex);
    });
  }

  void toSelectedQuestion(int index){
    setState(() {
      _currentQuestionIndex = index;
      _currentQuestion = _questions.elementAt(_currentQuestionIndex);
      setAnswerValue(_currentQuestionIndex);
    });
  }

  void setAnswerValue(int questionIndex) {
    _answerController.text = _answers[questionIndex].isEmpty?
                  '' : _answers[questionIndex];
  }

  PageRouteBuilder _changeScreenAnimation() {
    return PageRouteBuilder(
        pageBuilder: (context, ani, secAni) =>
            ResultScreen(
                questions: _questions,
                answers: _answers,
                elapsedTime: _elapsedTime),
        transitionsBuilder: (context, ani, secAni,
            child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(
              begin: begin,
              end: end
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = ani.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 500),
    );
  }
}