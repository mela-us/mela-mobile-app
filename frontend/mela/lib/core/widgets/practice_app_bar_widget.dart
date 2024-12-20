import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/utils/locale/app_localization.dart';

import '../../constants/assets.dart';

class PracticeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback pressedBack;
  const PracticeAppBar({super.key, required this.pressedBack, });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: _buildTitle(context),
      backgroundColor: Theme.of(context).colorScheme.appBackground,
      actions: _buildAction(),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: [
          _buildBackButton(context),
          _buildTextTitle(context),
        ],
      ),
    );
  }

  List<Widget> _buildAction(){
    return [];
  }

  Widget _buildBackButton(BuildContext context){
    return GestureDetector(
      onTap: pressedBack,
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


  void _backPreviousScreen(BuildContext context){
    pressedBack;
  }
}
