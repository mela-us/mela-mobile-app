import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/core/widgets/practice_app_bar_widget.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/store/topic_lecture_store.dart';
import 'package:mela/utils/locale/app_localization.dart';
import 'package:mela/utils/routes/routes.dart';

import '../../constants/assets.dart';
import '../../di/service_locator.dart';
import '../../domain/entity/question/question.dart';
import '../../domain/params/history/exercise_progress_params.dart';
import '../streak/store/streak_store.dart';
import '../streak/streak_gain_screen.dart';

class ResultScreen extends StatefulWidget{
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

  final StreakStore _streakStore = getIt<StreakStore>();

  @override
  void didChangeDependencies() {
    if (!_questionStore.saving) {
      // _questionStore.submitAnswer(
      //     getCorrect(),
      //     DateTime.now().subtract(_timerStore.elapsedTime),
      //     DateTime.now()
      // );
      _questionStore.updateProgress(
          getAnswerResultList(),
          DateTime.now().subtract(_timerStore.elapsedTime),
          DateTime.now()
      );
    }

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    //
    _checkAndUpdateStreak();
    //
    return Observer(
      builder: (context) {
        if (_questionStore.saving) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.appBackground,
            body: const Center(child: RotatingImageIndicator()),
          );
        }
        else if (_levelStore.loading ||
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
            if (_topicLectureStore.currentLevel != null){
              await _topicLectureStore.getListTopicLectureInLevel();
            }
            if (_exerciseStore.currentLecture != null){
              await _exerciseStore.getExercisesByLectureId();
            }
            await _levelStore.getAreLearningLectures();
            if (mounted){
              Navigator.of(context).pop();
            }
          },
          ),
          body: _buildBody(context),
        );
      },
    );
  }

  //Build components:-----------------------------------------------------------
  Widget _buildBody(BuildContext context){
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

  Future<void> _checkAndUpdateStreak() async {
    if (calculatePoint() >= 8){
      int prevStreak = _streakStore.streak?.current ?? 0;
      await _streakStore.updateStreak();
      await _streakStore.getStreak();
      int nextStreak = _streakStore.streak?.current ?? 0;
      //
      if (nextStreak > prevStreak) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  StreakScreen(prevStreak: prevStreak)
          ),
        );
      }
    }
  }

  //Build items:----------------------------------------------------------------
  Widget _buildResultImage(){
    if (calculatePoint() >= 8){
      return Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Center(
            child: Image.asset(
              Assets.success_image,
              height: 150,
              width: 150,
            ),
          )
      );
    }
    else {
      return Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Center(
            child: Image.asset(
              Assets.failure_image,
              height: 150,
              width: 150,
            ),
          )
      );
    }
  }

  Widget _buildTitle(BuildContext context){
    return Center(
      child: Text(
        calculatePoint() >= 8
            ? AppLocalizations.of(context).translate('result_title')
            : "Bài tập chưa đạt!!!",
        style: Theme.of(context).textTheme.title
            .copyWith(color: Theme.of(context).colorScheme.textInBg1),
      ),
    );
  }

  Widget _buildDescription(BuildContext context){
    return Center(
      child: Text(
        calculatePoint() >= 8
            ? AppLocalizations.of(context).translate('result_description')
            : "Cần đúng tối thiểu 80% số câu.",
        style: Theme.of(context).textTheme.normal
            .copyWith(color: Theme.of(context).colorScheme.textInBg2),
      ),
    );
  }

  Widget _buildPointContainer(BuildContext context){
    return _buildValueContainer(
      context,
      AppLocalizations.of(context).translate('result_point_title'),
      "${getCorrect()}/${_questionStore.questionList!.questions!.length}",
        calculatePoint() >= 8 ?
        Theme.of(context).colorScheme.buttonChooseBackground
      : Colors.redAccent,
    );
  }

  Widget _buildTimeContainer(BuildContext context){
    return _buildValueContainer(
      context,
      AppLocalizations.of(context).translate('result_time_title'),
      getTime(),
      Theme.of(context).colorScheme.buttonYesBgOrText,
    );
  }

  Widget _buildReviewButton(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      {
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
                style: Theme.of(context).textTheme.buttonStyle
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
      BuildContext context, String name, String value, Color color){
    return Container(
      width: 111,
      height: 111,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              name,
              style: Theme.of(context).textTheme.normal
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
                    borderRadius: BorderRadius.circular(20)
                ),

                child: Center(
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.subHeading
                        .copyWith(color: color),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  //Others:---------------------------------------------------------------------

  double calculatePoint(){
    int correct = 0;
    //Can't be null
    List<Question> questions = _questionStore.questionList!.questions!;
    List<String> userAnswers = _singleQuestionStore.userAnswers;

    correct = getCorrect();
    return correct/questions.length * 10.0;
  }

  String getTime() {
    Duration elapsedTime = _timerStore.elapsedTime;
    String hours = elapsedTime.inHours.toString().padLeft(2, '0');
    String minutes = (elapsedTime.inMinutes).toString().padLeft(2, '0');
    String seconds = (elapsedTime.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  int getCorrect(){
    List<Question> questions = _questionStore.questionList!.questions!;
    List<String> userAnswers = _singleQuestionStore.userAnswers;
    int correct = 0;
    for (int i= 0; i < questions.length; i ++){
      if (userAnswers[i].isEmpty) {
        print("Empty $i");
        continue;
      }
      if (questions[i].isCorrect(userAnswers[i])){
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
