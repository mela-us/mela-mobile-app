import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/utils/locale/app_localization.dart';

import '../../../constants/enum.dart';
import '../../question/store/single_question/single_question_store.dart';

class ListItemTile extends StatelessWidget {
  ListItemTile({super.key, required this.index, required this.status});
  final int index;
  final AnswerStatus status;
  final singleQuestionStore = getIt<SingleQuestionStore>();

  @override
  Widget build(BuildContext context) {
    return _buildSingleTile(context);
  }

  Widget _buildSingleTile(BuildContext context) {
    return Observer(builder: (context){
      return Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Align(
          alignment: Alignment.bottomLeft,

          child: Container(
            width: 46,
            height: singleQuestionStore.currentIndex == index? 66:46,
            decoration: BoxDecoration(
              color: colorSwitch(status, context),
              borderRadius: BorderRadius.circular(90.0),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: Theme.of(context).textTheme.normal
                  .copyWith(color: Theme.of(context).colorScheme.textInBg1),
            ),
          ),
        ),
      );
    });
  }

  Color colorSwitch(AnswerStatus status, BuildContext context){
    switch (status){
      case AnswerStatus.correct:
        return Theme.of(context).colorScheme.buttonCorrect;
      case AnswerStatus.incorrect:
        return Theme.of(context).colorScheme.buttonIncorrect;
      case AnswerStatus.noAnswer:
        return Theme.of(context).colorScheme.inputMutedText;
      default: return Theme.of(context).colorScheme.inputMutedText;
    }
  }
}
