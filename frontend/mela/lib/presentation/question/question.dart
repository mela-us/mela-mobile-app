import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/domain/entity/question/question.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mela/presentation/question/widgets/question_app_bar_widget.dart';
import 'package:mela/presentation/question/widgets/question_list_overlay_widget.dart';
import 'package:mela/utils/locale/app_localization.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';

import '../../constants/assets.dart';
import '../../constants/enum.dart';
import '../../constants/layout.dart';
import '../../core/widgets/progress_indicator_widget.dart';
import '../../di/service_locator.dart';

class QuestionScreen extends StatefulWidget {
  QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  //Stores:---------------------------------------------------------------------
  final TimerStore _timerStore = getIt<TimerStore>();
  final QuestionStore _questionStore = getIt<QuestionStore>();
  final SingleQuestionStore _singleQuestionStore = getIt<SingleQuestionStore>();
  late OverlayEntry questionListOverlay;

  //----------------------------------------------------------------------------
  final TextEditingController _controller = TextEditingController();

  //State set:------------------------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timerStore.resetTimer();
    _timerStore.startTimer();


    //Reaction to questions status.
    reaction((_) => _questionStore.loading, (loading){
      if (!loading){
        //can't be null here
        _singleQuestionStore
            .generateAnswerList(_questionStore.questionList!
            .questions!.length);
        _initListOverlay(context);
      }
    },
    fireImmediately: true);


    //Reaction to question index change.
    reaction((_) => _singleQuestionStore.currentIndex, (index){
      String userAnswer = _singleQuestionStore.userAnswers[index];
      Question question = _questionStore.questionList!.questions![index];
      if (isQuizQuestion(question)){
        if (userAnswer.isEmpty) {
          _singleQuestionStore.setQuizAnswerValue(userAnswer);
        }
        int choiceIndex = getIndexFromLetter(userAnswer);
        String choiceValue = question.options[choiceIndex].content;

        _singleQuestionStore.setQuizAnswerValue(choiceValue);
      }
      else {
        _controller.text = userAnswer;
      }
    });

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // check to see if already called api
    if (!_questionStore.loading) {
      _questionStore.getQuestions();
    }

    reaction((_) => _questionStore.questionList, (questions){
      if (questions != null){
        //can't be null here
        _singleQuestionStore
            .generateAnswerList(_questionStore.questionList!
            .questions!.length);
        _initListOverlay(context);
      }
    }, fireImmediately: true);

    //Reaction to quit
    reaction((_) => _questionStore.isQuit, (quit){
      if (quit == QuitOverlayResponse.quit){
        Navigator.of(context).pop();
      }
    }, fireImmediately: true);

    _singleQuestionStore.changeQuestion(0);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timerStore.stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.appBackground,
      appBar: const QuestionAppBar(),
      body: _buildMainBody(),
      floatingActionButton: _buildFAB(context),
    );
  }


  //Build components:-----------------------------------------------------------
  Widget _buildMainBody(){
    return Observer(
      builder: (context){
        if (_questionStore.loading){
          return const CustomProgressIndicatorWidget();
        }
        else {
          return SingleChildScrollView(
            child: _buildBodyContent(context),
          );
        }
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return DraggableFab(
      child: Container(
        width: 220,
        height: 45,
        margin: const EdgeInsets.fromLTRB(0, 0, 19, 30),
        child: FloatingActionButton(
            onPressed: _listButtonPressedEvent,
            backgroundColor: const Color(0xFF0961F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.bigButtonRadius),
            ),
            child: Center(
              child: Row(
                children: [
                  //Icon
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimens.practiceLeftContainer
                    ),
                    child: Image.asset(
                      Assets.select_list,
                      width: 25,
                      height: 25,
                    ),
                  ),

                  //Text
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    //Text
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('question_btn_question_list'),
                      style: Theme.of(context)
                          .textTheme
                          .buttonStyle
                          .copyWith(color: Theme.of(context)
                                                .colorScheme
                                                .buttonYesTextOrBg),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  //Build items:----------------------------------------------------------------
  BoxDecoration decorationWithShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(Dimens.textContainerRadius),
    boxShadow: [
      Layout.practiceBoxShadow,
    ],
  );


  Widget _buildBodyContent(BuildContext context) {
    //TODO: Need check more for null value
    List<Question>? questions = _questionStore.questionList!.questions;
    int index = _singleQuestionStore.currentIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Question View
        _buildQuestionContent(),
        //spacing
        const SizedBox(height: 27),

        _buildQuestionSubTitle(context, questions![index]),

        const SizedBox(height: 17),
        //Answer View
        isQuizQuestion(questions[index]) ?
        //quiz view      :      fill view
        _buildQuizView(questions[index]) : _buildFillView(questions[index]),
      ],
    );
  }


  Widget _buildQuestionSubTitle(BuildContext context, Question question){
    return Padding(
        padding: const EdgeInsets.only(left: Dimens.practiceLeftContainer),
        child: isQuizQuestion(question) ?
        Text(
          AppLocalizations.of(context)
              .translate('question_subtitle_for_quiz'),
          style: Theme.of(context).textTheme.subTitle
              .copyWith(color: Theme.of(context).colorScheme.textInBg2),
        ) : Text(
          AppLocalizations.of(context)
              .translate('question_subtitle_for_fitb'),
          style: Theme.of(context).textTheme.subTitle
              .copyWith(color: Theme.of(context).colorScheme.textInBg2),
        )
    );
  }

  Widget _buildQuestionContent(){
    return Row(
      children: [
        Expanded(
          child: Container(
            //Outside Border
            margin: Layout.practiceContainerPaddingWithTop,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            //Content border
            child: Container(
              decoration: decorationWithShadow,
              child: Padding(
                padding: Layout.practiceTextPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Câu ${_singleQuestionStore.currentIndex+1}:',
                      style: Theme.of(context).textTheme.subTitle
                          .copyWith(color: const Color(0xFFFF6B00)),
                    ),
                    const SizedBox(height: 3.0),

                    Text(
                      getCurrentQuestion()!.content,
                      style: Theme.of(context).textTheme.questionStyle
                          .copyWith(
                          color: Theme.of(context)
                              .colorScheme.inputTitleText
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizView(Question question) {
    return Column(
        children: [
          Container(
            padding: Layout.practiceContainerPadding,
            child: ListView.builder(
              itemCount: getCurrentQuestion()!.options.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Observer(builder: (context) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _radioTile(index)
                  );
                });
              },
            ),
          ),
          _buildNextButton(question),
        ]
    );
  }

  Widget _buildFillView(Question question) {
    return Container(
      margin: Layout.practiceContainerPadding,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      
      child: Column(
        children: [
          Container(
            decoration: decorationWithShadow,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)
                    .translate('question_hint_text_field'),
                hintStyle: Theme.of(context).textTheme.subTitle
                    .copyWith(color: Theme.of(context)
                    .colorScheme.inputHintText),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 21,
                    horizontal: Dimens.practiceHorizontalText
                ),

              ),
              onChanged: (value){
                _singleQuestionStore.setAnswer(
                    _singleQuestionStore.currentIndex,
                    value
                );
              },
              style:
                Theme.of(context).textTheme.normal
                    .copyWith(color: Theme.of(context)
                    .colorScheme.inputTitleText),
              ),
            ),
              const SizedBox(height: 12),
             _buildNextButton(question),
          ],
      )
    );
  }

  Widget _buildNextButton(Question question){
    return Padding(
        padding: isQuizQuestion(question)?
            const EdgeInsets.only(right: 34+9): const EdgeInsets.only(right: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => _continueButtonPressedEvent(),
                child: Text(
                  AppLocalizations.of(context)
                      .translate('question_btn_text_next'),
                  style: Theme.of(context).textTheme.subTitle
                      .copyWith(color: Theme.of(context).colorScheme.textInBg2),
                ),
            )
          ],
        )
    );
  }

  Widget _radioTile(int index){
    return Container(
      height: Dimens.answerTileHeight,
      decoration: decorationWithShadow,
      child: RadioListTile<String>(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            getCurrentQuestion()!.options.isEmpty ?
            'null' :
            makeChoiceFromIndex(index)+
                getCurrentQuestion()!.options[index].content,
            style: Theme.of(context).textTheme.normal
                .copyWith(color: Theme.of(context).colorScheme.inputText),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.answerTileRadius),
        ),
        value: getCurrentQuestion()!.options[index].content,
        groupValue: _singleQuestionStore.currentQuizAnswer,
        contentPadding: const EdgeInsets.fromLTRB(18, 0, 15, 12),
        controlAffinity: ListTileControlAffinity.trailing,
        //Answer key.
        onChanged: (value) {
          _singleQuestionStore.setAnswer(
              _singleQuestionStore.currentIndex,
              getAnswerFromIndex(index)
          );
          _singleQuestionStore.setQuizAnswerValue(value!);
        },
      ),
    );
  }

  //Event handlers:-------------------------------------------------------------
  void _listButtonPressedEvent() {
    Overlay.of(context).insert(questionListOverlay);
  }

  void _continueButtonPressedEvent() {
    if (_singleQuestionStore.currentIndex <
          _questionStore.questionList!.questions!.length-1) {

      _singleQuestionStore.changeQuestion(_singleQuestionStore.currentIndex+1);
    }
  }

  //Others:---------------------------------------------------------------------
  Question? getCurrentQuestion(){
    int index = _singleQuestionStore.currentIndex;

    if (_questionStore.questionList == null) return null;
    if (_questionStore.questionList!.questions == null) return null;
    if (_questionStore.questionList!.questions!.isEmpty) return null;

    List<Question> questions = _questionStore.questionList!.questions!;
    return questions[index];
  }

  int getIndexFromLetter(String key){
    return key.codeUnitAt(0) - 'A'.codeUnitAt(0);
  }

  bool isQuizQuestion(Question question){
    if (question.options.isEmpty){
      return false;
    }
    return true;
  }

  String makeChoiceFromIndex(int index) {
    return '${String.fromCharCode(index + 65)}. ';
  }

  String getAnswerFromIndex(int index){
    return String.fromCharCode(index + 65);
  }

  //Initialize overlay:---------------------------------------------------------
   void _initListOverlay(BuildContext context) async{
     questionListOverlay = OverlayEntry(
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
                 child: QuestionListOverlay(
                     isSubmitted: (bool submit) {
                       if (!submit) {
                         questionListOverlay.remove();
                       }
                       else {
                         questionListOverlay.remove();
                         Navigator.of(context)
                             .pushReplacementNamed(Routes.result);
                       }
                     }),
               )
             ],
           );
         }
     );
   }



}

