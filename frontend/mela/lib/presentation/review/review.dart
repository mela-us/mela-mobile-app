import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/constants/layout.dart';
import 'package:mela/core/widgets/practice_app_bar_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/question/question.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/review/widgets/list_item_tile_widget.dart';
import 'package:mela/utils/locale/app_localization.dart';

import '../../constants/enum.dart';
import 'package:flutter_html/flutter_html.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final QuestionStore _questionStore = getIt<QuestionStore>();
  final SingleQuestionStore _singleQuestionStore = getIt<SingleQuestionStore>();
  late List<Question> questions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    questions = _questionStore.questionList!.questions!;
    _singleQuestionStore.changeQuestion(0); //reset to 0.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PracticeAppBar(
        pressedBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildQuestionList(),
    );
  }

  //Build Components:-----------------------------------------------------------
  Widget _buildBody() {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionWidget(),

            const SizedBox(height: 27),

            Padding(
              padding:
                  const EdgeInsets.only(left: Dimens.practiceLeftContainer),
              child: Text(
                AppLocalizations.of(context).translate('review_ask'),
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.textInBg2),
              ),
            ),

            const SizedBox(height: 17),

            isQuizQuestion(questions[_singleQuestionStore.currentIndex])
                ? _buildQuizAnswer()
                : _buildFillAnswer(),

            isQuizQuestion(questions[_singleQuestionStore.currentIndex])
                ? const SizedBox(height: 15)
                : const SizedBox(height: 27),

            questions[_singleQuestionStore.currentIndex].guide.isEmpty?
            Container():
            Padding(
              padding:
                  const EdgeInsets.only(left: Dimens.practiceLeftContainer),
              child: Text(
                AppLocalizations.of(context).translate('review_explain'),
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.textInBg2),
              ),
            ),

            // SizedBox(height: 17),
            questions[_singleQuestionStore.currentIndex].guide.isEmpty?
            Container():
            _buildExplainView(
                questions[_singleQuestionStore.currentIndex].guide),
            const SizedBox(height: 17),
          ],
        ),
      );
    });
  }

  Widget _buildQuestionList() {
    return Container(
      height: Dimens.listOverlayHeight,
      color: Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 61),
        itemCount: questions.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Observer(builder: (context) {
            return InkWell(
              borderRadius: BorderRadius.circular(90),
              onTap: () {
                _singleQuestionStore.changeQuestion(i);
              },
              child: ListItemTile(
                status: getStatus(
                    questions[i], _singleQuestionStore.userAnswers[i]),
                index: i,
              ),
            );
          });
        },
      ),
    );
  }

  //Build Items:----------------------------------------------------------------
  Widget _buildQuestionWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: Layout.practiceContainerPaddingWithTop,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Container(
              decoration: decorationWithShadow,
              child: Padding(
                padding: Layout.practiceTextPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Câu ${_singleQuestionStore.currentIndex + 1}',
                      style: Theme.of(context)
                          .textTheme
                          .subTitle
                          .copyWith(color: const Color(0xFFFF6B00)),
                    ),

                    const SizedBox(height: 3.0),

                    Flexible(
                      child: Html(
                        shrinkWrap: true,
                        data:
                            "<html>${questions[_singleQuestionStore.currentIndex].content}</html>",
                        extensions: [
                          TagExtension(
                              tagsToExtend: {"latex"},
                              builder: (extensionContext) {
                                String latexCode =
                                    extensionContext.innerHtml ?? "";
                                print("Latex: $latexCode");
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Math.tex(
                                    latexCode,
                                    mathStyle: MathStyle.display,
                                    textStyle: extensionContext.style
                                        ?.generateTextStyle(),
                                    onErrorFallback: (FlutterMathException e) {
                                      return Text(e.message);
                                    },
                                  ),
                                );
                              }),
                        ],
                        style: {
                          "*": Style.fromTextStyle(
                            Theme.of(context).textTheme.questionStyle.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inputTitleText),
                          ).merge(Style(
                            display: Display.inline,
                            textOverflow: TextOverflow.clip,
                            padding: HtmlPaddings.all(0),
                            margin: Margins.all(0),
                          ))
                        },
                      ),
                    ),

                    // Text(
                    //   questions[_singleQuestionStore.currentIndex].content,
                    //   style: Theme.of(context).textTheme.questionStyle
                    //       .copyWith(color: Theme.of(context)
                    //       .colorScheme.inputTitleText),
                    // ),

                    // Html(
                    //   data:questions[_singleQuestionStore.currentIndex].content,
                    //   style: {
                    //     "*": Style.fromTextStyle(
                    //         Theme.of(context).textTheme.questionStyle
                    //             .copyWith(color: Theme.of(context)
                    //             .colorScheme.inputTitleText),
                    //     ).merge(
                    //      Style(
                    //
                    //        display: Display.inline,
                    //      )
                    //     )
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExplainView(String content) {
    print(content);
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: Layout.practiceContainerPaddingWithTop,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Container(
              decoration: decorationWithShadow,
              child: Padding(
                padding: Layout.practiceTextPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('review_solution'),
                      style: Theme.of(context)
                          .textTheme
                          .subTitle
                          .copyWith(color: const Color(0xFFFF6B00)),
                    ),
                    const SizedBox(height: 3.0),
                    Flexible(
                      child: Html(
                        shrinkWrap: true,
                        data: "<html>$content</html>",
                        extensions: [
                          TagExtension(
                              tagsToExtend: {"latex"},
                              builder: (extensionContext) {
                                String latexCode = extensionContext.innerHtml;
                                print("Latex: $latexCode");
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Math.tex(
                                    latexCode,
                                    mathStyle: MathStyle.display,
                                    textStyle: extensionContext.style
                                        ?.generateTextStyle(),
                                    onErrorFallback: (FlutterMathException e) {
                                      return Text(e.message);
                                    },
                                  ),
                                );
                              }),
                        ],
                        style: {
                          "*": Style.fromTextStyle(
                            Theme.of(context).textTheme.questionStyle.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inputTitleText),
                          ).merge(Style(
                            display: Display.inline,
                            textOverflow: TextOverflow.clip,
                            padding: HtmlPaddings.all(0),
                            margin: Margins.all(0),
                          ))
                        },
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

  Widget _buildFillAnswer() {
    Question question = questions[_singleQuestionStore.currentIndex];
    String userAnswer =
        _singleQuestionStore.userAnswers[_singleQuestionStore.currentIndex];

    //answer is correct
    if (isAnswerCorrect(question, userAnswer)) {
      return _buildCorrectFill(userAnswer);
    }
    //answer is incorrect
    else {
      return _buildIncorrectFill(question.blankAnswer, userAnswer);
    }
  }

  Widget _buildCorrectFill(String answer) {
    return Container(
      margin: Layout.practiceContainerPadding,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: _buildSingleAnswerView(
          answer,
          Theme.of(context).colorScheme.buttonCorrect,
          Theme.of(context).colorScheme.buttonChooseBackground,
          Icons.check_circle),
    );
  }

  Widget _buildIncorrectFill(String correctAnswer, String answer) {
    return Container(
        margin: Layout.practiceContainerPadding,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSingleAnswerView(
                answer,
                Theme.of(context).colorScheme.buttonIncorrect,
                const Color(0xFFD32F2F),
                Icons.cancel),
            const SizedBox(height: 12),
            _buildSingleAnswerView(
                correctAnswer,
                Theme.of(context).colorScheme.buttonCorrect,
                Theme.of(context).colorScheme.buttonChooseBackground,
                Icons.check_circle)
          ],
        ));
  }

  Widget _buildQuizAnswer() {
    Question question = questions[_singleQuestionStore.currentIndex];
    String userAnswer =
        _singleQuestionStore.userAnswers[_singleQuestionStore.currentIndex];

    return Container(
      padding: Layout.practiceContainerPadding,
      child: ListView.builder(
        itemCount: question.options.length,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          print("Correct key ${question.correctQuizKey()}");
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildQuizTile(
              question.options[index].content,
              index,
              userAnswer,
              question.correctQuizKey(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuizTile(
      String quizChoice, int index, String userAnswer, String questionAnswer) {
    String choiceKey = convertNumberToLetter(index);
    String newQuizContent = "$choiceKey .$quizChoice";
    if (choiceKey == questionAnswer) {
      //correct
      return _buildSingleAnswerView(
          newQuizContent,
          Theme.of(context).colorScheme.buttonCorrect,
          Theme.of(context).colorScheme.buttonChooseBackground,
          Icons.check_circle);
    }

    if (choiceKey == userAnswer) {
      //incorrect
      return _buildSingleAnswerView(
          newQuizContent,
          Theme.of(context).colorScheme.buttonIncorrect,
          const Color(0xFFD32F2F),
          Icons.cancel);
    }
    //neutral
    return _buildSingleAnswerView(newQuizContent, Colors.white,
        Theme.of(context).colorScheme.inputText, Icons.circle_outlined);
  }

  Widget _buildSingleAnswerView(
      String text, Color backgroundColor, Color textColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Dimens.answerTileRadius),
        boxShadow: [
          Layout.practiceBoxShadow,
        ],
      ),
      height: Dimens.answerTileHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            // child: Text(
            //   text,
            //   softWrap: true,
            //   style: Theme.of(context).textTheme.normal
            //       .copyWith(color: textColor),
            // ),
            child: Html(
              shrinkWrap: true,
              data: "<html>$text</html>",
              extensions: [
                TagExtension(
                    tagsToExtend: {"latex"},
                    builder: (extensionContext) {
                      String latexCode = extensionContext.innerHtml ?? "";
                      print("Latex: $latexCode");
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Math.tex(
                          latexCode,
                          mathStyle: MathStyle.display,
                          textStyle:
                              extensionContext.style?.generateTextStyle(),
                          onErrorFallback: (FlutterMathException e) {
                            return Text(e.message);
                          },
                        ),
                      );
                    }),
              ],
              style: {
                "*": Style.fromTextStyle(
                  Theme.of(context).textTheme.normal.copyWith(color: textColor),
                ).merge(Style(
                    display: Display.inline, textOverflow: TextOverflow.clip))
              },
            ),
          ),
          Icon(
            icon,
            color: textColor,
            size: Dimens.answerTileIconSize,
          ),
        ],
      ),
    );
  }

  BoxDecoration decorationWithShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(Dimens.textContainerRadius),
    boxShadow: [
      Layout.practiceBoxShadow,
    ],
  );

  //Others:---------------------------------------------------------------------
  int getIndexFromLetter(String key) {
    return key.codeUnitAt(0) - 'A'.codeUnitAt(0);
  }

  bool isQuizQuestion(Question question) {
    if (question.options.isEmpty) {
      return false;
    }
    return true;
  }

  String makeChoiceFromIndex(int index) {
    return '${String.fromCharCode(index + 65)}. ';
  }

  String getAnswerFromIndex(int index) {
    return String.fromCharCode(index + 65);
  }

  bool isAnswerCorrect(Question question, String answer) {
    if (question.isCorrect(answer)) return true;
    return false;
  }

  String convertNumberToLetter(int number) {
    return String.fromCharCode(number + 65);
  }

  AnswerStatus getStatus(Question q, String a) {
    if (a.isEmpty) return AnswerStatus.noAnswer;
    if (q.isCorrect(a)) return AnswerStatus.correct;
    return AnswerStatus.incorrect;
  }
}
