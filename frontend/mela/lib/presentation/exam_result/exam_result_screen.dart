import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/core/widgets/practice_app_bar_widget.dart';
import 'package:mela/domain/entity/exam/exam.dart';
import 'package:mela/presentation/examination/store/exam_store.dart';
import 'package:mela/presentation/examination/store/single_exam_store.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mela/utils/locale/app_localization.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';

import '../../constants/assets.dart';
import '../../di/service_locator.dart';

import '../../domain/params/history/exercise_progress_params.dart';

class ExamResultScreen extends StatefulWidget {
  const ExamResultScreen({super.key});

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  final ExamStore _questionStore = getIt<ExamStore>();
  final SingleExamStore _singleQuestionStore = getIt<SingleExamStore>();
  final TimerStore _timerStore = getIt<TimerStore>();

  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!_questionStore.saving) {
      // _questionStore.submitAnswer(
      //     getCorrect(),
      //     DateTime.now().subtract(_timerStore.elapsedTime),
      //     DateTime.now()
      // );

      //calculaate point here
      _questionStore.updateProgress(
          DateTime.now().subtract(_timerStore.elapsedTime), DateTime.now());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_questionStore.saving) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.appBackground,
            body: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RotatingImageIndicator(),
                  const SizedBox(height: 12),
                Text(
                  "Đang chấm bài...",
                  style: Theme.of(context).textTheme.subTitle.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Bạn đợi một chút nhé!",
                  style: Theme.of(context).textTheme.subTitle.copyWith(
                    fontSize: 18,
                  ),
                )
                ]
            )),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.appBackground,
          appBar: PracticeAppBar(
            pressedBack: () async {
              if (mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.allScreens, (route) => false);
              }
            },
          ),
          body: _buildBody(context),
        );
      },
    );
  }

  //Build components:-----------------------------------------------------------
  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //image -> Text -> Text -> Row (2 box -> text) -> Button
      children: [
        //image
        _buildResultImage(),
        const SizedBox(height: 25),

        _buildTitle(context),
        const SizedBox(height: 10),

        _buildDescription(context),
        const SizedBox(height: 44),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPointContainer(context),
            const SizedBox(width: 11),
            _buildTimeContainer(context),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                bottom: 34,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: _buildReviewButton(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Build items:----------------------------------------------------------------
  Widget _buildResultImage() {
    if (calculatePoint() >= 6) {
      return Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Center(
            child: Image.asset(
              Assets.success_image,
              height: 150,
              width: 150,
            ),
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Center(
            child: Image.asset(
              Assets.failure_image,
              height: 150,
              width: 150,
            ),
          ));
    }
  }

  Widget _buildTitle(BuildContext context) {
    return Center(
      child: Text(
        getTitleText(),
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(color: Theme.of(context).colorScheme.textInBg1),
      ),
    );
  }

  String getTitleText() {
    final score = calculatePoint();
    if (score == 10) return "Hoàn hảo!! Đỉnh nóc kịch trần";
    if (score >= 9) return "Xuất sắc!";
    if (score >= 8) return "Bạn đã hoàn thành tốt bài kiểm tra";
    if (score >= 6) return "Bạn đã hoàn thành bài kiểm tra!";
    return "Chưa như mong đợi";
  }

  Widget _buildDescription(BuildContext context) {
    return Center(
      child: Text(
        getDescriptionText(),
        style: Theme.of(context)
            .textTheme
            .normal
            .copyWith(color: Theme.of(context).colorScheme.textInBg2),
      ),
    );
  }

  String getDescriptionText() {
    final score = calculatePoint();
    if (score >= 9) return "Hãy giữ vững phong độ này nhé";
    if (score >= 6) return "Hãy cố gắng hơn nữa nhé, bạn có thể làm tốt hơn";
    return "Bạn hãy cố gắng trau dồi thêm nhé. Đừng nản chí!";
  }

  Widget _buildPointContainer(BuildContext context) {
    return _buildValueContainer(
      context,
      AppLocalizations.of(context).translate('result_point_title'),
      "${getCorrect()}/${_questionStore.exam!.questions.length}",
      calculatePoint() >= 8
          ? Theme.of(context).colorScheme.buttonChooseBackground
          : Colors.redAccent,
    );
  }

  Widget _buildTimeContainer(BuildContext context) {
    return _buildValueContainer(
      context,
      AppLocalizations.of(context).translate('result_time_title'),
      getTime(),
      Theme.of(context).colorScheme.buttonYesBgOrText,
    );
  }

  Widget _buildReviewButton(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).pushNamed(Routes.examReviewScreen),
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.buttonYesBgOrText,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 19),
              child: Text(
                AppLocalizations.of(context).translate('result_btn_review'),
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
      ),
    );
  }

  Container _buildValueContainer(
      BuildContext context, String name, String value, Color color) {
    return Container(
      width: 111,
      height: 111,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .normal
                  .copyWith(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
            child: Container(
                height: 70,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    value,
                    style: Theme.of(context)
                        .textTheme
                        .subHeading
                        .copyWith(color: color),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  //Others:---------------------------------------------------------------------

  double calculatePoint() {
    int correct = 0;
    //Can't be null
    List<ExamQuestionModel> questions = _questionStore.exam!.questions;
    List<String> userAnswers = _singleQuestionStore.userAnswers;

    correct = getCorrect();
    return correct / questions.length * 10.0;
  }

  String getTime() {
    Duration elapsedTime = _timerStore.elapsedTime;
    String hours = elapsedTime.inHours.toString().padLeft(2, '0');
    String minutes = (elapsedTime.inMinutes).toString().padLeft(2, '0');
    String seconds = (elapsedTime.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  int getCorrect() {
    final results = _questionStore.exerciseResult?.answers ?? [];
    int correct = 0;
    for (int i = 0; i < results.length; i++) {
      if (results[i].isCorrect) {
        correct++;
      }
    }
    return correct;
  }

  List<ExerciseAnswer> getAnswerResultList() {
    List<ExamQuestionModel> questions = _questionStore.exam!.questions;
    List<String> userAnswers = _singleQuestionStore.userAnswers;
    final List<ExerciseAnswer> answerList = [];

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      final userAnswer = userAnswers[i];

      final bool isCorrect = question.isCorrect(userAnswer);
      String? blankAnswer;
      int? selectedOption;

      if (question.options.isEmpty) {
        blankAnswer = userAnswer.trim();
      } else {
        // Convert A/B/C/D → 1/2/3/4
        selectedOption = question.charToNumber(userAnswer.trim());
      }

      answerList.add(
        ExerciseAnswer(
          questionId: question.questionId ?? '',
          isCorrect: isCorrect,
          blankAnswer: blankAnswer,
          selectedOption: selectedOption,
        ),
      );
    }

    return answerList;
  }
}
