import 'package:flutter/cupertino.dart';
import 'package:mela/constants/answer_status.dart';
import 'package:mela/models/Notifiers/question_change_notifier.dart';
import 'package:mela/themes/default/text_styles.dart';
import 'package:provider/provider.dart';

class QuestionTile extends StatelessWidget {
  final AnswerStatus answerStatus;
  final bool isSelected;
  final int index;

  const QuestionTile({
    super.key,
    required this.answerStatus,
    required this.index,
    required this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<QAMixNotifier>(context);
    print(isSelected);
    return _buildSingleTile();
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget _buildSingleTile() {
    return Padding(
      padding: EdgeInsets.only(left: 6),
      child: Align(
        alignment: Alignment.bottomLeft,

        child: Container(
          width: 46,
          height: isSelected? 66:46,
          decoration: BoxDecoration(
            color: colorSwitch(answerStatus),
            borderRadius: BorderRadius.circular(90.0),
          ),
          alignment: Alignment.center,
          child: TextStandard.Normal('${index + 1}', Color(0xFF202244)),
        ),
      ),

    );
  }
}

Color colorSwitch(AnswerStatus status){
  switch (status){
    case AnswerStatus.Correct:
      return Color(0xFF8EFF97);
    case AnswerStatus.Incorrect:
      return Color(0xFFFFD5DB);
    case AnswerStatus.NoAnswer:
      return Color(0xFFE9E9E9);
    default: return Color(0xFFE9E9E9);
  }
}

