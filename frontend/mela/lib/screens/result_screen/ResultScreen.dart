import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/models/QuestionFamily/AQuestion.dart';

import '../../constants/assets_path.dart';
import '../../constants/global.dart';
import '../../themes/default/text_styles.dart';

class ResultScreen extends StatelessWidget{
  final List<AQuestion> questions;
  final List<String> answers;
  final Duration elapsedTime;

  const ResultScreen({
    super.key,
    required this.questions,
    required this.answers,
    required this.elapsedTime
  });

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //image -> Text -> Text -> Row (2 box -> text) -> Button
        children: [
          //image
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Image.asset(
                  AssetsPath.result_image,
                  height: 207.63,
                  width: 312,
                ),
              )
          ),
          SizedBox(height: 25),
          Center(
            child: TextStandard.Title(
                'Hoàn thành bài tập!!!',
                Color(0xFF202244)
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: TextStandard.SubTitle(
                'Luyện mãi thành tài, miệt mài tất giỏi.',
                Color(0xFF545454)
            ),
          ),
          SizedBox(height: 44),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              valueDisplayContainer(
                  'ĐIỂM',
                  calculatePoint().toString(),
                  Color(0xFF167F71)
              ),

              SizedBox(width: 11),
              valueDisplayContainer('THỜI GIAN', '0:22', Color(0xFF0961F5)),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  bottom: 34,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: reviewButton(),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  void _backButtonPressed() {
  }

  Container valueDisplayContainer(String name, String value, Color color){
    return Container(
      width: 111,
      height: 111,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: TextStandard.Normal(name, Colors.white),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(4, 8, 4, 4),
            child: Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: TextStandard.SubHeading(value, color),
              )
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector reviewButton() {
    return GestureDetector(
      onTap: reviewButtonPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF0961F5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 19),
              //
              child: TextStandard.Button('Phân tích bài làm', Colors.white),
            ),
            Positioned(
              right: 10,
              child: Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF0961F5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void reviewButtonPressed() {
    print('Pressed');
  }

  double calculatePoint(){
    int correct = 0;
    for (int i= 0; i < questions.length; i ++){
      if (questions[i].answer.toLowerCase() == answers[i].toLowerCase()){
        correct ++;
      }
    }
    return correct/questions.length * 1.0;
  }

  String getTime(){
    String hours = elapsedTime.inHours.toString().padLeft(2, '0');
    String minutes = (elapsedTime.inMinutes % 60).toString().padLeft(2, '0');

    return '$hours:$minutes';
  }
}