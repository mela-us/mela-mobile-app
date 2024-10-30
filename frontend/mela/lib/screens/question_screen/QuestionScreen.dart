import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/models/QuestionFamilly/AQuestion.dart';
import 'package:mela/screens/question_screen/widgets/AppBarText.dart';
import 'package:mela/screens/question_screen/widgets/ExitDialog.dart';
import 'package:mela/screens/question_screen/widgets/SingleQuestionView.dart';

import '../../constants/global.dart';

class QuestionScreen extends StatefulWidget{
  final List<AQuestion> questions;

  const QuestionScreen({super.key, required this.questions});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>{
  late List<AQuestion> _questions;
  late Timer _timer;
  late AQuestion _currentQuestion;
  Duration _elapsedTime = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questions = widget.questions;
    _currentQuestion = _questions.first;
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant QuestionScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questions != widget.questions){
      _questions = widget.questions;
      _currentQuestion = _questions.first;
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
                    'lib/assets/icons/arrow_back_longer.png',
                    width: 26,
                    height: 20,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 11.79),
                  child: AppBarText(text: 'Luyện tập'),
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
                    'lib/assets/icons/clock.png',
                    width: 30,
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '$hours:$minutes:$seconds',
                      style: const TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xFF0961F5),
                      ),
                    ),
                  ),
                ],
              ),
          )
        ],
      ),
      body: SingleQuestionView(
          question: _currentQuestion,
          qNumber: _questions.indexOf(_currentQuestion) + 1
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
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 23),
                  child: Image.asset(
                    'lib/assets/icons/select_list.png',
                    width: 25,
                    height: 25,
                  ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: const Text(
                    'Danh sách câu',
                    style: TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              )
            ],
          ),
          backgroundColor: Color(0xFF0961F5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Thay đổi border circular tại đây
          ),
        ),

      )

    );
    // TODO: implement build
    throw UnimplementedError();
  }

  void _backButtonPressed() {
    Overlay.of(context).insert(
      OverlayEntry(builder: (context)=> Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.53),
          ),
          Positioned(
            bottom: 34,
            left: 19,
            right: 19,
            child: ExitDialog(onConfirm: confirmLeaving),
          )
        ],
      )

      )
    );
  }

  void _questionListButtonPressed() {
  }

  void confirmLeaving() {
  }
}