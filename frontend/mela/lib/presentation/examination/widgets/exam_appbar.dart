import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/examination/store/exam_store.dart';
import 'package:mela/presentation/examination/widgets/exam_quit_overlay_widget.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mela/presentation/question/widgets/question_quit_overlay_widget.dart';
import 'package:mobx/mobx.dart';

import '../../../constants/assets.dart';
import '../../../utils/locale/app_localization.dart';

class ExamAppBar extends StatefulWidget implements PreferredSizeWidget {
  final OverlayEntry questionListOverlay;
  final FocusNode focusNode;
  const ExamAppBar(
      {super.key, required this.questionListOverlay, required this.focusNode});

  @override
  State<ExamAppBar> createState() => _ExamAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}

class _ExamAppBarState extends State<ExamAppBar> {
  final TimerStore _timerStore = getIt<TimerStore>();
  final ExamStore _questionStore = getIt<ExamStore>();

  late OverlayEntry quitDialogOverlay;
  late OverlayEntry _questionListOverlay;

  late FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initQuitDialog();
    _focusNode = widget.focusNode;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //Reaction to quit
    reaction((_) => _questionStore.isQuit, (quit) {
      if (quit == QuitOverlayResponse.quit ||
          quit == QuitOverlayResponse.stay) {
        quitDialogOverlay.remove();
        _questionStore.setQuit(QuitOverlayResponse.wait);
      } else {
        //Do nothing
      }
    }, fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: _buildTitle(context),
      backgroundColor: Theme.of(context).colorScheme.appBackground,
      actions: _buildAction(context),
      automaticallyImplyLeading: false,
    );
  }

  //Build component:------------------------------------------------------------
  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimens.horizontal_padding),
      child: Row(
        children: [
          _buildBackButton(context),
          _buildTextTitle(context),
        ],
      ),
    );
  }

  //Build items:----------------------------------------------------------------
  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _backPreviousScreen(context),
      child: Image.asset(
        Assets.arrow_back_longer,
        width: 26,
        height: 20,
      ),
    );
  }

  Widget _buildTextTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 11.79),
      child: Text(
        "Bài thi",
        style: Theme.of(context)
            .textTheme
            .heading
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Widget _buildClockTimer(BuildContext context) {
    return Observer(
        builder: (_) => Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //clock icon
                  Image.asset(
                    Assets.clock,
                    width: 30,
                    height: 30,
                  ),

                  //text handler with observer
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${getHour(_timerStore.elapsedTime)}:'
                      '${getMinute(_timerStore.elapsedTime)}:'
                      '${getSecond(_timerStore.elapsedTime)}',
                      style: Theme.of(context).textTheme.subTitle.copyWith(
                          color:
                              Theme.of(context).colorScheme.buttonYesBgOrText),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _buildQuestionList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: IconButton(
        onPressed: _listButtonPressedEvent,
        icon: Icon(
          Icons.list_outlined,
          size: 30,
          color: Theme.of(context).colorScheme.buttonYesBgOrText,
        ),
      ),
    );
  }

  //Support methods:------------------------------------------------------------
  String getHour(Duration elapsedTime) {
    return elapsedTime.inHours.toString().padLeft(2, '0');
  }

  String getMinute(Duration elapsedTime) {
    return (elapsedTime.inMinutes % 60).toString().padLeft(2, '0');
  }

  String getSecond(Duration elapsedTime) {
    return (elapsedTime.inSeconds % 60).toString().padLeft(2, '0');
  }

  List<Widget> _buildAction(BuildContext context) {
    return [
      _buildClockTimer(context),
      const SizedBox(width: 10),
      _buildQuestionList(context),
      const SizedBox(width: Dimens.practiceRightContainer - 7)
    ];
  }

  //Event handlers:-------------------------------------------------------------
  void _backPreviousScreen(BuildContext context) {
    Overlay.of(context).insert(quitDialogOverlay);
  }

  void _listButtonPressedEvent() {
    _focusNode.unfocus();
    Overlay.of(context).insert(_questionListOverlay);
  }

  //Initialize overlay dialog:--------------------------------------------------
  void _initQuitDialog() {
    quitDialogOverlay = OverlayEntry(builder: (BuildContext overlayContext) {
      return Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.53),
          ),
          Align(
            alignment: Alignment.center,
            child: ExamQuitOverlayWidget(),
          )
        ],
      );
    });
    _questionListOverlay = widget.questionListOverlay;
  }
}
