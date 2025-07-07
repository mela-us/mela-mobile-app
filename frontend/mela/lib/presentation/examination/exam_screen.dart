import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/domain/entity/exam/exam.dart';
import 'package:mela/presentation/examination/store/exam_store.dart';
import 'package:mela/presentation/examination/store/single_exam_store.dart';
import 'package:mela/presentation/examination/widgets/exam_appbar.dart';
import 'package:mela/presentation/examination/widgets/exam_change_tab_overlay_widget.dart';
import 'package:mela/presentation/examination/widgets/exam_list_overlay_widget.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mela/utils/locale/app_localization.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';

import '../../constants/enum.dart';
import '../../constants/layout.dart';
import '../../di/service_locator.dart';

import '../../../utils/animation_helper/animation_helper.dart';
import 'controller/exam_screen_controller.dart';

class ExamScreen extends StatefulWidget {
  final ExamScreenController controller;

  const ExamScreen({super.key, required this.controller});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  //Stores:---------------------------------------------------------------------
  final TimerStore _timerStore = getIt<TimerStore>();
  final ExamStore _questionStore = getIt<ExamStore>();
  final SingleExamStore _singleExamStore = getIt<SingleExamStore>();
  late OverlayEntry questionListOverlay;
  final FocusNode _focusNode = FocusNode();

  List<File> _selectedImages = [];
  final ImagePicker _imagePicker = ImagePicker();
  //----------------------------------------------------------------------------
  final TextEditingController _controller = TextEditingController();

  //State set:------------------------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //reaction on tab changed
    widget.controller.showExitOverlay = (VoidCallback onConfirm) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => ExamChangeTabOverlayWidget(
          onConfirm: () {
            Navigator.pop(context);
            onConfirm();
          },
          onCancel: () => Navigator.pop(context),
        ),
      );
    };

    //Reaction to questions status.
    reaction((_) => _questionStore.loading, (loading) {
      if (!loading) {
        //can't be null here
        _singleExamStore
            .generateAnswerList(_questionStore.exam!.questions.length);
        _initListOverlay(context);

        _timerStore.resetTimer();
        _timerStore.startTimer();
      }
    }, fireImmediately: true);

    //Reaction to question index change.
    reaction((_) => _singleExamStore.currentIndex, (index) {
      String userAnswer = _singleExamStore.userAnswers[index];
      ExamQuestionModel question = _questionStore.exam!.questions![index];
      if (isQuizQuestion(question)) {
        if (userAnswer.isEmpty) {
          _singleExamStore.setQuizAnswerValue(userAnswer);
        }
        int choiceIndex = getIndexFromLetter(userAnswer);
        String choiceValue = question.options[choiceIndex].content;

        _singleExamStore.setQuizAnswerValue(choiceValue);
      } else {
        //For fill in the blank or subjective question
        if (question.questionType == "ESSAY") {
          setState(() {
            print("Selected images: ${_singleExamStore.userImage[index]}");
            _selectedImages.clear(); // Set current image answer
            _selectedImages.addAll(
                _singleExamStore.userImage[_singleExamStore.currentIndex]);
          });
        } else {
          _controller.text = "";
          _selectedImages.clear(); // Clear selected images for FITB
        }
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
      _questionStore.getExam();
    }

    reaction((_) => _questionStore.isAuthorized, (flag) {
      if (!flag) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
      }
    });

    reaction((_) => _questionStore.exam!.questions, (questions) {
      if (questions != null) {
        //can't be null here
        _singleExamStore
            .generateAnswerList(_questionStore.exam!.questions.length);
        _initListOverlay(context);
      }
    }, fireImmediately: true);

    //Reaction to quit
    reaction((_) => _questionStore.isQuit, (quit) {
      if (quit == QuitOverlayResponse.quit) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.allScreens, (route) => false);
      }
    }, fireImmediately: true);

    _singleExamStore.changeQuestion(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose

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
            appBar: ExamAppBar(
              questionListOverlay: questionListOverlay,
              focusNode: _focusNode,
            ),
            body: SingleChildScrollView(
              child: _buildMainBody(),
            ),
          );
        }
      },
    );
  }

  //Build components:-----------------------------------------------------------
  Widget _buildMainBody() {
    return _buildBodyContent(context);
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
    List<ExamQuestionModel>? questions = _questionStore.exam!.questions;
    int index = _singleExamStore.currentIndex;

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

  Widget _buildQuestionSubTitle(
      BuildContext context, ExamQuestionModel question) {
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
                      'Câu ${_singleExamStore.currentIndex + 1}:',
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
  Widget _buildQuizView(ExamQuestionModel question) {
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
  Widget _buildFillView(ExamQuestionModel question) {
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
                  _singleExamStore.setAnswer(
                      _singleExamStore.currentIndex, value);
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
  Widget _buildSubjectiveView(ExamQuestionModel question) {
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
                      _singleExamStore.setAnswer(
                          _singleExamStore.currentIndex, value);
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
          //       _singleExamStore.setAnswer(
          //           _singleExamStore.currentIndex, value);
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

  Widget _buildNextButton(ExamQuestionModel question) {
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
        groupValue: _singleExamStore.currentQuizAnswer,
        contentPadding: const EdgeInsets.fromLTRB(18, 0, 15, 12),
        controlAffinity: ListTileControlAffinity.trailing,
        //Answer key.
        onChanged: (value) {
          _singleExamStore.setAnswer(
              _singleExamStore.currentIndex, getAnswerFromIndex(index));
          _singleExamStore.setQuizAnswerValue(value!);
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
    if (_singleExamStore.currentIndex < _questionStore.exam!.total) {
      int index = _singleExamStore.currentIndex + 1;
      if (index == _questionStore.exam!.total) {
        Overlay.of(context).insert(questionListOverlay);
        return;
      }

      print('Size of selected images: ${_selectedImages.length}');
      _singleExamStore.setImageAnswer(
          _singleExamStore.currentIndex, _selectedImages);

      _singleExamStore.changeQuestion(index);
    }
  }

  //Others:---------------------------------------------------------------------
  ExamQuestionModel? getCurrentQuestion() {
    int index = _singleExamStore.currentIndex;

    if (_questionStore.exam == null) return null;
    if (_questionStore.exam!.questions.isEmpty) return null;

    List<ExamQuestionModel> questions = _questionStore.exam!.questions;
    return questions[index];
  }

  int getIndexFromLetter(String key) {
    return key.codeUnitAt(0) - 'A'.codeUnitAt(0);
  }

  bool isQuizQuestion(ExamQuestionModel question) {
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
            child: ExamListOverlayWidget(
              isSubmitted: (bool submit) {
                //TODO: Handle submit

                if (!submit) {
                  questionListOverlay.remove();
                } else {
                  _singleExamStore.setImageAnswer(
                      _singleExamStore.currentIndex, _selectedImages);
                  _singleExamStore.printAllAnswer();
                  questionListOverlay.remove();
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.examResultScreen);
                }
              },
              selectedImages: _selectedImages,
            ),
          )
        ],
      );
    });
  }

  ExamQuestionModel questionHolder = ExamQuestionModel(
      questionId: '',
      ordinalNumber: 1,
      content: '',
      questionType: 'FILL_IN_THE_BLANK',
      options: [],
      blankAnswer: '',
      solution: '',
      guide: '');
}
