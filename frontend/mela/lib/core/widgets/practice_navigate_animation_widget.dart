import 'package:flutter/cupertino.dart';

class PracticeNavigateAnimation extends PageRouteBuilder{
  final Widget nextScreen;

  PracticeNavigateAnimation({required this.nextScreen}) : super(
    pageBuilder: (context, ani, secAni) => nextScreen,
    transitionsBuilder: (context, ani, secAni,
        child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(
          begin: begin,
          end: end
      ).chain(CurveTween(curve: curve));
      var offsetAnimation = ani.drive(tween);

      return ClipRect(
        child: SlideTransition(
          position: offsetAnimation,
          child: child,
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 800),
  );

}
