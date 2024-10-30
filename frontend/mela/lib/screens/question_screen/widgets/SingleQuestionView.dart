import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/constants/global.dart';
import 'package:mela/models/QuestionFamilly/AQuestion.dart';
import 'package:mela/models/QuestionFamilly/QuizQuestion.dart';

class SingleQuestionView extends StatefulWidget{
  final AQuestion question;
  final int qNumber;

  const SingleQuestionView({
    super.key,
    required this.question,
    required this.qNumber
  });

  @override
  _SingleQuestionState createState() => _SingleQuestionState();
}

class _SingleQuestionState extends State<SingleQuestionView>{
  late AQuestion _question;
  late int _qNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _question = widget.question;
    _qNumber = widget.qNumber;
  }

  @override
  void didUpdateWidget(covariant SingleQuestionView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question){
      _question = widget.question;
    }
    if (oldWidget.qNumber != widget.qNumber){
      _qNumber = widget.qNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool isQuiz = _question is QuizQuestion? true: false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Question View
        Container(
          margin: EdgeInsets.fromLTRB(
                30,
                16.0,
                Global.PracticeRightPadding,
                0.0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Đổ bóng
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Câu $_qNumber:',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFFFF6B00),
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    _question.questionContent,
                    style: const TextStyle(
                      color: Color(0xFF393939),
                      fontSize: 14,
                      fontFamily: 'Mulish',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 27),
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
              _question is QuizQuestion?
                  'Hãy chọn đáp án chính xác nhất':
                  'Hãy điền đáp án chính xác nhất',
            style: const TextStyle(
              color: Color(0xFF545454),
              fontFamily: 'Mulish',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),

        SizedBox(height: 17),

        //Answer View
        _question is! QuizQuestion?
        Container(
          margin: EdgeInsets.fromLTRB(
              30,
              0,
              Global.PracticeRightPadding,
              0.0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Đổ bóng
                ),
              ],
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Điền đáp án vào đây',
                hintStyle: TextStyle(
                  color: Color(0xFFB4BDC4),
                  fontFamily: 'Mulish',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 21,
                    horizontal: 15),
              ),
              style: const TextStyle(
                color: Color(0xFF393939),
                fontFamily: 'Mulish',
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ) : Container(

        ),
        const SizedBox(height: 7),
        Padding(
            padding: const EdgeInsets.only(right: 43),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: _continueButtonPressed,
                    child: const Text(
                      'Tiếp theo',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF545454),
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                )
              ],
            )
        ),
      ],
    );
    // TODO: implement build
    throw UnimplementedError();
  }


  void _continueButtonPressed() {
  }
}