
import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';

import '../../constants/assets.dart';
import '../../utils/locale/app_localization.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.appBackground,
        elevation: 0,
        title: _buildTitle(context),
      ),
      backgroundColor: Theme.of(context).colorScheme.appBackground,
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              ],
            ),
          )
      ),
    );
  }

  //Build component:------------------------------------------------------------
  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimens.horizontal_padding),
      child: Row(
        children: [
          _buildBackButton(context),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: _buildTextTitle(context)
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Build items:----------------------------------------------------------------
  Widget _buildBackButton(BuildContext context){
    return GestureDetector(
      onTap: () => {

      },
      // child: Image.asset(
      //   Assets.arrow_back_longer,
      //   width: 26,
      //   height: 20,
      // ),
      child: SizedBox(
        width: 26,
        height: 26,
        child: Icon(
          Icons.history_rounded,
          color: Theme.of(context).colorScheme.textInBg1,
        ),
      )
    );
  }

  Widget _buildTextTitle(BuildContext context){
    return Center(
      child: Text(
        "Mela AI",
        style: Theme.of(context)
            .textTheme
            .heading
            .copyWith(color: Theme.of(context).colorScheme.textInBg1),
        textAlign: TextAlign.center,
      ),
    );
  }
}



