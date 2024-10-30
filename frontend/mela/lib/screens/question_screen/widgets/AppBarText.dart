import 'package:flutter/cupertino.dart';

import '../../../constants/global.dart';

class AppBarText extends StatelessWidget{
  final String text;

  const AppBarText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Global.AppBarContentColor,
        fontFamily: 'Asap',
        fontWeight: FontWeight.bold,
        fontSize: 21,
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}