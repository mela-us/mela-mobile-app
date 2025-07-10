import 'dart:io';

import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/domain/entity/question/guide_controller.dart';
import 'package:mela/domain/entity/question/question.dart';
import 'package:mela/presentation/home_screen/store/revise_store/revise_store.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mela/presentation/question/widgets/guide_bottom_sheet.dart';
import 'package:mela/presentation/question/widgets/question_app_bar_widget.dart';
import 'package:mela/presentation/question/widgets/question_list_overlay_widget.dart';
import 'package:mela/utils/locale/app_localization.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';

import '../../constants/enum.dart';
import '../../constants/layout.dart';
import '../../di/service_locator.dart';
import 'store/hint_store/hint_store.dart';

import '../../../utils/animation_helper/animation_helper.dart';

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
  final FocusNode _focusNode = FocusNode();
  final double screenHeight = MediaQueryData.fromView(
          WidgetsBinding.instance.platformDispatcher.views.first)
      .size
      .height
      .toDouble();
  final double screenWidth = MediaQueryData.fromView(
          WidgetsBinding.instance.platformDispatcher.views.first)
      .size
      .width
      .toDouble();
  late Offset fabPos;

  final HintStore _hintStore = getIt<HintStore>();
  final ReviseStore _reviseStore = getIt<ReviseStore>();

  List<File> _selectedImages = [];
  final ImagePicker _imagePicker = ImagePicker();

  bool? isFromMain;
  int resetCounter = 0;
  int loadCounter = 0;
  //----------------------------------------------------------------------------
  final TextEditingController _controller = TextEditingController();

  //State set:------------------------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fabPos = Offset(50, screenHeight - 80);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      isFromMain = args?['main'];
    });

    //Reaction to questions status.
    reaction((_) => _questionStore.loading, (loading) {
      if (!loading) {
        if (resetCounter > 0) return;
        //can't be null here
        _singleQuestionStore
            .generateAnswerList(_questionStore.questionList!.questions!.length);
        _initListOverlay(context);

        _timerStore.resetTimer();
        _timerStore.startTimer();
        resetCounter++;
      }
    }, fireImmediately: true);

    _singleQuestionStore.changeQuestion(0);

    //Reaction to question index change.
    reaction((_) => _singleQuestionStore.currentIndex, (index) {
      String userAnswer = _singleQuestionStore.userAnswers[index];
      Question question = _questionStore.questionList!.questions![index];
      if (isQuizQuestion(question)) {
        if (userAnswer.isEmpty) {
          _singleQuestionStore.setQuizAnswerValue(userAnswer);
        }
        int choiceIndex = getIndexFromLetter(userAnswer);
        String choiceValue = question.options[choiceIndex].content;

        _singleQuestionStore.setQuizAnswerValue(choiceValue);
      } else {
        //For fill in the blank or subjective question
        if (question.questionType == "ESSAY") {
          setState(() {
            print("Selected images: ${_singleQuestionStore.userImage[index]}");
            _selectedImages.clear(); // Set current image answer
            _selectedImages.addAll(_singleQuestionStore
                .userImage[_singleQuestionStore.currentIndex]);
          });
        } else {}
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
      if (loadCounter > 0) return;
      _questionStore.getQuestions();
      loadCounter++;
    }

    reaction((_) => _questionStore.isAuthorized, (flag) {
      if (!flag) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
      }
    });

    reaction((_) => _questionStore.questionList, (questions) {
      if (questions != null) {
        //can't be null here
        _singleQuestionStore
            .generateAnswerList(_questionStore.questionList!.questions!.length);
        _initListOverlay(context);

        _hintStore.reset();
        _hintStore.setHint(_questionStore.questionList!.questions![0].guide);
        _hintStore.setTerm(_questionStore.questionList!.questions![0].term);
      }
    }, fireImmediately: true);

    //Reaction to quit
    reaction((_) => _questionStore.isQuit, (quit) {
      if (quit == QuitOverlayResponse.quit) {
        _reviseStore.setSelectedItem(null);
        Navigator.of(context).pop();
      }
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    super.dispose();
    _timerStore.stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_questionStore.loading) {
          // return const RotatingImageIndicator();
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.appBackground,
            body: const Center(child: RotatingImageIndicator()),
          );
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.appBackground,
            appBar: QuestionAppBar(
              questionListOverlay: questionListOverlay,
              focusNode: _focusNode,
            ),
            body: SingleChildScrollView(
              child: _buildMainBody(),
            ),
            floatingActionButton: _buildDFAB(context),
          );
        }
      },
    );
  }

  //Build components:-----------------------------------------------------------
  Widget _buildMainBody() {
    return _buildBodyContent(context);
  }

  Widget _buildDFAB(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            left: fabPos.dx,
            top: fabPos.dy,
            child: Draggable(
                feedback: _buildFAB(context),
                childWhenDragging: Container(),
                onDragEnd: (details) {
                  setState(() {
                    fabPos = Offset(
                        borderPositionHandler(details.offset.dx, screenWidth),
                        borderPositionHandler(details.offset.dy, screenHeight));
                  });
                },
                child: _buildFAB(context))),
      ],
    );
  }

  //Build items:----------------------------------------------------------------
  BoxDecoration decorationWithShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(Dimens.textContainerRadius),
    // boxShadow: [
    //   Layout.practiceBoxShadow,
    // ],
  );

  Widget _buildFAB(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          border: GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Color(0xFF31BCFF),
              Color(0xFF9676FF),
              Color(0xFFBE64FE),
              Color(0xFFE157CB),
              Color(0xFFEF5794),
              Color(0xFFFD683F),
              Color(0xFFFE7C2B),
              Color(0xFFFFA10B),
            ]),
            width: 2,
          ),
        ),
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return GuideBottomSheet(screenHeight: screenHeight);
            },
          ),
          backgroundColor: Colors.white,
          hoverColor: Colors.white,
          splashColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(90)),
          ),
          child: Image.asset(
            Assets.ai_icon,
            width: 38,
            height: 38,
          ),
        ));
  }

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
        isQuizQuestion(questions[index])
            ?
            //quiz view      :      fill view
            _buildQuizView(questions[index])
            : (questions[index].questionType == "ESSAY"
                ? _buildSubjectiveView(questions[index])
                : _buildFillView(questions[index])),

        //spacing
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildQuestionSubTitle(BuildContext context, Question question) {
    return Padding(
        padding: const EdgeInsets.only(left: Dimens.practiceLeftContainer),
        child: isQuizQuestion(question)
            ? Text(
                AppLocalizations.of(context)
                    .translate('question_subtitle_for_quiz'),
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.textInBg2),
              )
            : Text(
                AppLocalizations.of(context)
                    .translate('question_subtitle_for_fitb'),
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.textInBg2),
              ));
  }

  Widget _buildQuestionContent() {
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
                      'Câu ${_singleQuestionStore.currentIndex + 1}:',
                      style: Theme.of(context)
                          .textTheme
                          .subTitle
                          .copyWith(color: const Color(0xFFFF6B00)),
                    ),
                    const SizedBox(height: 3.0),
                    Flexible(
                      child: Html(
                        shrinkWrap: true,
                        data: "<html>${getCurrentQuestion()!.content}</html>",
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
                          TagExtension(
                            tagsToExtend: {"img"},
                            builder: (context) {
                              final src = context.attributes['src'] ?? '';
                              return Image.network(src, fit: BoxFit.contain,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child:
                                      AnimationHelper.buildShimmerPlaceholder(
                                          context, 500, 200),
                                );
                              }, errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child:
                                      AnimationHelper.buildShimmerPlaceholder(
                                          context, 500, 200),
                                );
                              });
                            },
                          ),
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

  //For quiz question view
  Widget _buildQuizView(Question question) {
    return Column(children: [
      Container(
        padding: Layout.practiceContainerPadding,
        child: ListView.builder(
          itemCount: getCurrentQuestion()!.options.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Observer(builder: (context) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _radioTile(index));
            });
          },
        ),
      ),
      _buildNextButton(question),
    ]);
  }

  //For fill in the blank question view
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
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)
                      .translate('question_hint_text_field'),
                  hintStyle: Theme.of(context).textTheme.subTitle.copyWith(
                      color: Theme.of(context).colorScheme.inputHintText),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 21, horizontal: Dimens.practiceHorizontalText),
                ),
                onChanged: (value) {
                  _singleQuestionStore.setAnswer(
                      _singleQuestionStore.currentIndex, value);
                },
                style: Theme.of(context).textTheme.normal.copyWith(
                    color: Theme.of(context).colorScheme.inputTitleText),
              ),
            ),
            const SizedBox(height: 12),
            _buildNextButton(question),
          ],
        ));
  }

  //For subjective question view
  Widget _buildSubjectiveView(Question question) {
    return Container(
        margin: Layout.practiceContainerPadding,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            // TextField lớn
            Container(
              decoration: decorationWithShadow.copyWith(
                color: Colors.white, // ✅ thêm màu nền trắng
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextField lớn
                  TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: "Điền đáp án hoặc chọn ảnh tại đây.",
                      hintStyle: Theme.of(context).textTheme.subTitle.copyWith(
                          color: Theme.of(context).colorScheme.inputHintText),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      _singleQuestionStore.setAnswer(
                          _singleQuestionStore.currentIndex, value);
                    },
                    style: Theme.of(context).textTheme.normal.copyWith(
                        color: Theme.of(context).colorScheme.inputTitleText),
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                  ),

                  const SizedBox(height: 12),
                  // Preview ảnh
                  if (_selectedImages.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _selectedImages
                              .map((img) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Stack(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(img,
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover),
                                      ),
                                      Positioned(
                                        right: -10,
                                        top: -10,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(Icons.close,
                                              color: Colors.black),
                                          onPressed: () {
                                            setState(() {
                                              _selectedImages.remove(img);
                                            });
                                          },
                                        ),
                                      ),
                                    ]),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  // Nút chọn/chụp ảnh
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _pickImages,
                        child: const Icon(Icons.photo_library),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _takePhoto,
                        child: const Icon(Icons.camera_alt),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            _buildNextButton(question),
          ],

          // Container(
          //   decoration: decorationWithShadow,
          //   child: TextField(
          //     controller: _controller,
          //     focusNode: _focusNode,
          //     decoration: InputDecoration(
          //       hintText: AppLocalizations.of(context)
          //           .translate('question_hint_text_field'),
          //       hintStyle: Theme.of(context).textTheme.subTitle.copyWith(
          //           color: Theme.of(context).colorScheme.inputHintText),
          //       border: InputBorder.none,
          //       contentPadding: const EdgeInsets.symmetric(
          //           vertical: 21, horizontal: Dimens.practiceHorizontalText),
          //     ),
          //     onChanged: (value) {
          //       _singleQuestionStore.setAnswer(
          //           _singleQuestionStore.currentIndex, value);
          //     },
          //     style: Theme.of(context).textTheme.normal.copyWith(
          //         color: Theme.of(context).colorScheme.inputTitleText),
          //   ),
          // ),
        ));
  }

  Future<void> _pickImages() async {
    final images = await _imagePicker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedImages.addAll(images.map((x) => File(x.path)));
      });
    }
  }

  Future<void> _pickImageForWeb() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _selectedImages.add(File(image.path));
      } else {
        // Handle case when no image is selected
        print("No image selected");
      }
    });
  }

  Future<void> _takePhoto() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImages.add(File(image.path));
      });
    }
  }

  Widget _buildNextButton(Question question) {
    return Padding(
        padding: isQuizQuestion(question)
            ? const EdgeInsets.only(right: 34 + 9)
            : const EdgeInsets.only(right: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => _continueButtonPressedEvent(),
              child: Text(
                AppLocalizations.of(context)
                    .translate('question_btn_text_next'),
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
            )
          ],
        ));
  }

  Widget _radioTile(int index) {
    return Container(
      height: Dimens.answerTileHeight,
      decoration: decorationWithShadow,
      child: RadioListTile<String>(
        title: Align(
          alignment: Alignment.centerLeft,
          child: getCurrentQuestion()!.options.isEmpty
              ? const Text('null')
              : Html(
                  shrinkWrap: true,
                  data:
                      "<html>${makeChoiceFromIndex(index) + getCurrentQuestion()!.options[index].content}</html>",
                  extensions: [
                    TagExtension(
                        tagsToExtend: {"latex"},
                        builder: (extensionContext) {
                          String latexCode = extensionContext.innerHtml ?? "";
                          return Math.tex(
                            latexCode,
                            mathStyle: MathStyle.display,
                            textStyle:
                                extensionContext.style?.generateTextStyle(),
                            onErrorFallback: (FlutterMathException e) {
                              return Text(e.message);
                            },
                          );
                        }),
                  ],
                  style: {
                    "*": Style.fromTextStyle(Theme.of(context)
                            .textTheme
                            .normal
                            .copyWith(
                                color: Theme.of(context).colorScheme.inputText))
                        .merge(Style(
                      display: Display.inline,
                      textOverflow: TextOverflow.clip,
                    ))
                  },
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
              _singleQuestionStore.currentIndex, getAnswerFromIndex(index));
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
    _focusNode.unfocus();
    if (_singleQuestionStore.currentIndex <
        _questionStore.questionList!.questions!.length) {
      int index = _singleQuestionStore.currentIndex + 1;
      if (index == _questionStore.questionList!.questions!.length) {
        Overlay.of(context).insert(questionListOverlay);
        return;
      }

      print('Size of selected images: ${_selectedImages.length}');
      _singleQuestionStore.setImageAnswer(
          _singleQuestionStore.currentIndex, _selectedImages);

      _singleQuestionStore.changeQuestion(index);
      _hintStore.reset();
      _hintStore.setHint(_questionStore.questionList!.questions![index].guide);
      _hintStore.setTerm(_questionStore.questionList!.questions![index].term);
    }
  }

  //Others:---------------------------------------------------------------------
  Question? getCurrentQuestion() {
    int index = _singleQuestionStore.currentIndex;

    if (_questionStore.questionList == null) return null;
    if (_questionStore.questionList!.questions == null) return null;
    if (_questionStore.questionList!.questions!.isEmpty) return null;

    List<Question> questions = _questionStore.questionList!.questions!;
    return questions[index];
  }

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

  double borderPositionHandler(double pos, double border) {
    if (pos < 30) {
      return 30;
    }
    if (pos > border - 60) {
      return border - 60;
    }
    return pos;
  }

  void showGuidance(String guide) {}

  //Initialize overlay:---------------------------------------------------------
  void _initListOverlay(BuildContext context) async {
    questionListOverlay = OverlayEntry(builder: (BuildContext overlayContext) {
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
                //TODO: Handle submit

                if (!submit) {
                  questionListOverlay.remove();
                } else {
                  _singleQuestionStore.setImageAnswer(
                      _singleQuestionStore.currentIndex, _selectedImages);
                  _singleQuestionStore.printAllAnswer();
                  questionListOverlay.remove();
                  Navigator.of(context).pushReplacementNamed(Routes.result,
                      arguments: isFromMain != null
                          ? {
                              'main': true,
                            }
                          : null);
                }
              },
              selectedImages: _selectedImages,
            ),
          )
        ],
      );
    });
  }

  Question questionHolder = Question(
      questionId: '',
      ordinalNumber: 1,
      content: '',
      questionType: 'FILL_IN_THE_BLANK',
      options: [],
      blankAnswer: '',
      solution: '',
      guide: '',
      term: '');
}
