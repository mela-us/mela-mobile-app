import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/presentation/examination/store/exam_store.dart';
import 'package:mela/presentation/examination/store/single_exam_store.dart';
import 'package:mela/utils/locale/app_localization.dart';

import '../../../di/service_locator.dart';

class ExamListOverlayWidget extends StatelessWidget {
  final ExamStore _questionStore = getIt<ExamStore>();
  final SingleExamStore _singleQuestionStore = getIt<SingleExamStore>();
  final Function(bool) isSubmitted;
  final List<File> selectedImages;

  ExamListOverlayWidget(
      {super.key, required this.isSubmitted, required this.selectedImages});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        // width: 390,
        // height: 280 + 34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //firstLine
            _buildFirstLine(context),
            // const SizedBox(height: 0),
            _buildQuestionList(context),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: _buildSubmitButton(context),
            ),
          ],
        ),
      ),
    );
  }

  //Build items:----------------------------------------------------------------

  Widget _buildFirstLine(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 23),
            child: Text(
              AppLocalizations.of(context)
                  .translate('question_title_question_list'),
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Theme.of(context).colorScheme.textInBg1),
            ),
          ),
        ),
        Positioned(
          right: 15,
          top: 15,
          child: IconButton(
              onPressed: () => isSubmitted(false),
              icon: const Icon(Icons.close)),
        ),
      ],
    );
  }

  Widget _buildQuestionList(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: Dimens.practiceHorizontalText,
          right: Dimens.practiceHorizontalText,
          top: 0,
          bottom: 10),
      // height: 130,
      child: SingleChildScrollView(
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: _questionStore.exam!.questions!.length,
            itemBuilder: (context, index) {
              return _buildListItem(index);
            }),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Observer(builder: (context) {
      return GestureDetector(
        onTap: () {
          _singleQuestionStore.setImageAnswer(
              _singleQuestionStore.currentIndex, selectedImages);
          _singleQuestionStore.changeQuestion(index);
          isSubmitted(false);
        },
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: _singleQuestionStore.userAnswers[index].isEmpty &&
                    _singleQuestionStore.userImage[index].isEmpty
                ? Theme.of(context).colorScheme.inputMutedText
                : Theme.of(context).colorScheme.buttonList,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: Theme.of(context)
                  .textTheme
                  .normal
                  .copyWith(color: Theme.of(context).colorScheme.textInBg1),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
            Dimens.practiceHorizontalText, 0, Dimens.practiceHorizontalText, 0),
        child: GestureDetector(
          onTap: () => isSubmitted(true),
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.buttonYesBgOrText,
                borderRadius: BorderRadius.circular(Dimens.bigButtonRadius),
              ),
              child: _buildButtonContent(context)),
        ));
  }

  Widget _buildButtonContent(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 19),
          child: Text(
            AppLocalizations.of(context)
                .translate('question_btn_question_list_submit'),
            style: Theme.of(context)
                .textTheme
                .buttonStyle
                .copyWith(color: Colors.white),
          ),
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
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.buttonYesBgOrText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
