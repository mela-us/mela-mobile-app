import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/question/store/timer/timer_store.dart';
import 'package:mela/presentation/question/widgets/question_quit_overlay_widget.dart';
import 'package:mobx/mobx.dart';

import '../../../constants/assets.dart';
import '../../../utils/locale/app_localization.dart';
import '../store/question_store.dart';

class QuestionAppBar extends StatefulWidget implements PreferredSizeWidget{
  const QuestionAppBar({super.key});

  @override
  State<QuestionAppBar> createState() => _QuestionAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}

class _QuestionAppBarState extends State<QuestionAppBar> {
  final TimerStore _timerStore = getIt<TimerStore>();
  final QuestionStore _questionStore = getIt<QuestionStore>();

  late OverlayEntry quitDialogOverlay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initQuitDialog();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //Reaction to quit
    reaction((_) => _questionStore.isQuit, (quit){
      if (quit == QuitOverlayResponse.quit || quit == QuitOverlayResponse.stay){
        quitDialogOverlay.remove();
        _questionStore.setQuit(QuitOverlayResponse.wait);
      }
      else {
        //Do nothing
      }
    }, fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {

    return AppBar(
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
  Widget _buildBackButton(BuildContext context){
    return GestureDetector(
      onTap: () => _backPreviousScreen(context),
      child: Image.asset(
        Assets.arrow_back_longer,
        width: 26,
        height: 20,
      ),
    );
  }

  Widget _buildTextTitle(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 11.79),
      child: Text(
        AppLocalizations.of(context).translate('question_title_app_bar'),
        style: Theme.of(context)
            .textTheme
            .heading
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  Widget _buildClockTimer(BuildContext context){
    return Observer(builder: (_) =>
        Padding(
          padding: const EdgeInsets.only(right: Dimens.practiceRightContainer),
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
                  style: Theme.of(context)
                      .textTheme
                      .subTitle
                      .copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .buttonYesBgOrText),
                ),
              ),
            ],
          ),
        )
    );
  }

  //Support methods:------------------------------------------------------------
  String getHour(Duration elapsedTime){
    return elapsedTime.inHours.toString().padLeft(2, '0');
  }

  String getMinute(Duration elapsedTime){
    return (elapsedTime.inMinutes % 60).toString().padLeft(2, '0');
  }

  String getSecond(Duration elapsedTime){
    return (elapsedTime.inSeconds % 60).toString().padLeft(2, '0');
  }

  List<Widget> _buildAction(BuildContext context) {
    return [
      _buildClockTimer(context),
    ];
  }


  //Event handlers:-------------------------------------------------------------
  void _backPreviousScreen(BuildContext context) {
    Overlay.of(context).insert(quitDialogOverlay);
  }

  //Initialize overlay dialog:--------------------------------------------------
  void _initQuitDialog(){
    quitDialogOverlay = OverlayEntry(
        builder: (BuildContext overlayContext){
          return Stack(
            children: [
              Container(
                color: Colors.black.withOpacity(0.53),
              ),
              Positioned(
                bottom: 34,
                left: 19,
                right: 19,
                child: QuestionQuitOverlay(),
              )
            ],
          );
        }
    );
  }
}




