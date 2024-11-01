import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mela/constants/assets_path.dart';
import 'package:mela/models/QuestionFamily/AQuestion.dart';
import 'package:mela/screens/question_screen/widgets/ExitDialog.dart';
import 'package:mela/screens/question_screen/widgets/QuestionListDialog.dart';
import 'package:mela/screens/question_screen/widgets/SingleQuestionView.dart';

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
  Duration _elapsedTime = Duration.zero;

  late OverlayEntry quitOverlayEntry;
  late OverlayEntry questionListOverlayEntry;

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
          onContinueTextPressed: (String answer) {
            toNextQuestion(answer);
          },
      ),
      floatingActionButton: Container(
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
              borderRadius: BorderRadius.circular(30.0), // Thay đổi border circular tại đây
          ),
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 23),
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
        ),

      )

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
                child: QuestionListDialog(
                    answers: _answers,
                    onPickedQuestion: (int selected) {

                    },
                    onSubmitted: (bool isStaying){
                      if (!isStaying){
                        questionListOverlayEntry.remove();
                      }
                      else {

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

        //checker
        for (String ans in _answers){
          print(ans);
        }
      }
      if (_currentQuestionIndex == _questions.length-1) return;
      _currentQuestionIndex++;
      _currentQuestion = _questions.elementAt(_currentQuestionIndex);
    });
  }
}