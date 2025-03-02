import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/utils/locale/app_localization.dart';

import '../../../constants/assets.dart';
import '../../../di/service_locator.dart';

class QuestionQuitOverlay extends StatelessWidget {
  final QuestionStore questionStore = getIt<QuestionStore>();

  QuestionQuitOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 390,
        height: 480+34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImage(),

            //Spacing
            const SizedBox(height: 27.15),

            //Text
            Text(
              AppLocalizations.of(context)
                  .translate('question_title_question_dialog'),
              style: Theme.of(context)
                  .textTheme
                  .heading
                  .copyWith(color: Theme.of(context).colorScheme.textInBg1),
            ),

            const SizedBox(height: 17),

            //Build detail text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 54),
              child: Text(
                AppLocalizations.of(context)
                    .translate('question_title_question_detail'),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.textInBg2),
              ),
            ),

            const SizedBox(height: 18),

            _buildStayButton(context),

            const SizedBox(height: 8),

            _buildQuitButton(context),
          ],
        ),
      ),
    );
  }

  //Build items:----------------------------------------------------------------
  Widget _buildImage(){
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Image.asset(
              Assets.exit_image,
              width: 242,
              height: 170.85,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStayButton(BuildContext context){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: GestureDetector(
          onTap: () {
            questionStore.setQuit(QuitOverlayResponse.stay);
          },
          child: _buildContinueButtonMain(context),
        )
    );
  }

  Widget _buildQuitButton(BuildContext context){
    return GestureDetector(
        onTap: () {
          questionStore.setQuit(QuitOverlayResponse.quit);
        },
        child: Text(
          AppLocalizations.of(context)
              .translate('question_btn_question_dialog_quit'),
          style: Theme.of(context)
              .textTheme
              .buttonStyle
              .copyWith(color: Theme.of(context).colorScheme.inputText),
        ),
    );
  }

  Widget _buildContinueButtonMain(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.buttonYesBgOrText,
        borderRadius: BorderRadius.circular(Dimens.bigButtonRadius),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 19),
            //Text
            child: Text(
              AppLocalizations.of(context)
                  .translate('question_btn_question_dialog_continue'),
              style: Theme.of(context)
                  .textTheme
                  .buttonStyle
                  .copyWith(color: Theme.of(context)
                                        .colorScheme.buttonYesTextOrBg
              ),
            ),
          ),

          //Icon 'next ->'
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
    );
  }
}
