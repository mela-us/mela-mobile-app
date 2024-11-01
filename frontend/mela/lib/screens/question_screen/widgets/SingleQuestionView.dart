import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mela/constants/global.dart';
import 'package:mela/models/QuestionFamily/AQuestion.dart';
import 'package:mela/models/QuestionFamily/QuizQuestion.dart';
import 'package:mela/themes/default/text_styles.dart';

class SingleQuestionView extends StatefulWidget{
  final AQuestion question;
  final int qNumber;
  final Function(String) onContinueTextPressed;


  const SingleQuestionView({
    super.key,
    required this.question,
    required this.qNumber,
    required this.onContinueTextPressed
  });

  @override
  _SingleQuestionState createState() => _SingleQuestionState();
}

class _SingleQuestionState extends State<SingleQuestionView> {
  late AQuestion _question;
  late int _qNumber;
  late Function(String) _onContinueTextPressed;

  final TextEditingController _controller = TextEditingController();

  String? selectedChoice = '';
  String? selectedChoiceKey = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _question = widget.question;
    _qNumber = widget.qNumber;
    _onContinueTextPressed = widget.onContinueTextPressed;
  }

  @override
  void didUpdateWidget(covariant SingleQuestionView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _question = widget.question;
    }
    if (oldWidget.qNumber != widget.qNumber) {
      _qNumber = widget.qNumber;
    }
    if (oldWidget.onContinueTextPressed != widget.onContinueTextPressed) {
      _onContinueTextPressed = widget.onContinueTextPressed;
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

                  TextStandard.SubTitle(
                      'Câu $_qNumber:',
                      const Color(0xFFFF6B00)
                  ),

                  const SizedBox(height: 3.0),

                  TextStandard.Content(
                      _question.questionContent,
                      const Color(0xFF393939)
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 27),
        Padding(
            padding: const EdgeInsets.only(left: 30),
            child: _question is QuizQuestion
                ? TextStandard.SubTitle(
                'Hãy chọn đáp án chính xác nhất',
                const Color(0xFF545454)
            ) : TextStandard.SubTitle(
                'Hãy điền đáp án chính xác nhất',
                const Color(0xFF545454)
            )
        ),

        const SizedBox(height: 17),

        //Answer View
        _question is! QuizQuestion ?

        //Fitb view...
        Container(
          margin: EdgeInsets.fromLTRB(
              30,
              0,
              Global.PracticeRightPadding,
              0.0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            children: [
              Container(
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
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
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

              const SizedBox(height: 7),

              Padding(
                  padding:EdgeInsets.only(right: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () =>
                              _onContinueTextPressed(_controller.text),
                          child: TextStandard.SubTitle(
                              'Tiếp theo',
                              const Color(0xFF545454)
                          )
                      )
                    ],
                  )
              ),
            ],
          ),

          //Quiz view
        ) : Expanded(
          child: Container(
          padding: EdgeInsets.fromLTRB(
              30,
              0,
              Global.PracticeRightPadding,
              0.0),
          child: ListView.builder(
            itemCount: _question.choiceSize(),
            itemBuilder: (context, index) {
              return index != _question.choiceSize() -1 ?
                  //Not last tile.
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Container(
                    height: 60,
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
                  child: RadioListTile<String>(
                    title: TextStandard.Normal(
                      makeChoiceFromIndex(index) +
                          _question.getChoiceList()![index],
                      Color(0xFF505050),
                    ),
                    value: _question.getChoiceList()![index],
                    groupValue: selectedChoice,
                    contentPadding:
                        EdgeInsets.fromLTRB(18, 0, 15, 0),
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      setState(() {
                        selectedChoice = value;
                        selectedChoiceKey = getAnswerFromIndex(index);
                      });
                    },
                  ),
                ),
              ) :
              Column(
                children: [
                  Container(
                    height: 60,
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
                    child: RadioListTile<String>(
                      title: TextStandard.Normal(
                        makeChoiceFromIndex(index) +
                          _question.getChoiceList()![index],
                        Color(0xFF505050),
                      ),
                      value: _question.getChoiceList()![index],
                      groupValue: selectedChoice,
                      contentPadding:
                      EdgeInsets.fromLTRB(18, 0, 15, 0),
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (value) {
                        setState(() {
                          selectedChoice = value;
                          selectedChoiceKey = getAnswerFromIndex(index);
                        });
                      },
                    ),
                  ),
                  Padding(
                      padding:EdgeInsets.only(right: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () => _onContinueTextPressed(
                                    getTrueAnswer(selectedChoiceKey)
                                  ),
                              child: TextStandard.SubTitle(
                                  'Tiếp theo',
                                  const Color(0xFF545454)
                              )
                          )
                        ],
                      )
                  ),
                ],
              );
            },
          ),
        ),
        ),
      ],
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  String makeChoiceFromIndex(int index) {
    return '${String.fromCharCode(index + 65)}. ';
  }

  String getAnswerFromIndex(int index){
    return String.fromCharCode(index + 65);
  }
  
  String getTrueAnswer(String? ans) {
    return ans ?? '';
  }
}
