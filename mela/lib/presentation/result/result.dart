import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/core/widgets/practice_app_bar_widget.dart';
import 'package:mela/domain/params/revise/update_review_param.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/home_screen/store/revise_store/revise_store.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:mela/utils/locale/app_localization.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';

import '../../constants/assets.dart';
import '../../di/service_locator.dart';
import '../../domain/entity/question/question.dart';
import '../../domain/params/history/exercise_progress_params.dart';
import '../streak/store/streak_store.dart';
import '../streak/streak_gain_screen.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final QuestionStore _questionStore = getIt<QuestionStore>();
  final SingleQuestionStore _singleQuestionStore = getIt<SingleQuestionStore>();
  final TimerStore _timerStore = getIt<TimerStore>();
  final TopicLectureStore _topicLectureStore = getIt<TopicLectureStore>();
  final LevelStore _levelStore = getIt<LevelStore>();
  final ExerciseStore _exerciseStore = getIt<ExerciseStore>();
  final ReviseStore _reviseStore = getIt<ReviseStore>();
  final StreakStore _streakStore = getIt<StreakStore>();

  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();

    _checkAndUpdateStreak();

    _disposer = reaction<bool>(
      (_) => _streakStore.updateSuccess ?? false,
      (updateSuccess) {
        if (updateSuccess) {
          int streak = _streakStore.streak?.current ?? 0;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StreakScreen(streak: streak)),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!_questionStore.saving) {
      _questionStore.updateProgress(
          DateTime.now().subtract(_timerStore.elapsedTime), DateTime.now());

      if (calculatePoint() >= 8 && _reviseStore.selectedItem != null) {
        if (_reviseStore.selectedItem!.type == ReviewItemType.EXERCISE) {
          //Update exercise progress
          _updateExerciseProgress();
        }
      }
    }
    super.didChangeDependencies();
  }

  Future<void> _updateExerciseProgress() async {
    try {
      await _reviseStore.updateReview(
        UpdateReviewParam(
          isDone: true,
          reviewId: _reviseStore.selectedItem!.reviewId,
          itemId: _reviseStore.selectedItem!.itemId,
          ordinalNumber: _reviseStore.selectedItem!.ordinalNumber,
          itemType: _reviseStore.selectedItem!.type,
        ),
      );

      _reviseStore.setSelectedItem(null);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Lỗi không xác định, hãy thử lại.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final bool? isFromMain = args?['main'];
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
        } else if (_levelStore.loading ||
            _topicLectureStore.isGetTopicLectureLoading ||
            _exerciseStore.isGetExercisesLoading) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.appBackground,
            body: const Center(child: RotatingImageIndicator()),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.appBackground,
          appBar: PracticeAppBar(
            pressedBack: () async {
              //await _topicStore.getAreLearningLectures();
              if (_topicLectureStore.currentLevel != null) {
                await _topicLectureStore.getListTopicLectureInLevel();
              }
              if (_exerciseStore.currentLecture != null) {
                await _exerciseStore.getExercisesByLectureId();
              }
              //await _levelStore.getAreLearningLectures();
              if (context.mounted) {
                if (isFromMain != null && isFromMain) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.allScreens, (route) => false);
                } else {
                  Navigator.of(context).pop();
                }
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

  void _checkAndUpdateStreak() {
    if (calculatePoint() >= 8) {
      _streakStore.updateStreak();
    }
  }

  //Build items:----------------------------------------------------------------
  Widget _buildResultImage() {
    if (calculatePoint() >= 8) {
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
        calculatePoint() >= 8
            ? AppLocalizations.of(context).translate('result_title')
            : "Bài tập chưa đạt!!!",
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(color: Theme.of(context).colorScheme.textInBg1),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Center(
      child: Text(
        calculatePoint() >= 8
            ? AppLocalizations.of(context).translate('result_description')
            : "Cần đúng tối thiểu 80% số câu.",
        style: Theme.of(context)
            .textTheme
            .normal
            .copyWith(color: Theme.of(context).colorScheme.textInBg2),
      ),
    );
  }

  Widget _buildPointContainer(BuildContext context) {
    return _buildValueContainer(
      context,
      AppLocalizations.of(context).translate('result_point_title'),
      "${getCorrect()}/${_questionStore.questionList!.questions!.length}",
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
        Navigator.of(context).pushNamed(Routes.review),
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
    List<Question> questions = _questionStore.questionList!.questions!;

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
    List<Question> questions = _questionStore.questionList!.questions!;
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
