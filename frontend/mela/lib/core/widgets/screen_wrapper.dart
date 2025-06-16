
import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;

  const ScreenWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width > 600) {
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Material(
              color: Colors.white, // Nền trắng cho ứng dụng
              child: child,
              // child: Navigator(
              //   onGenerateRoute: (settings) =>
              //       MaterialPageRoute(
              //         builder: (context) => child, // Load nội dung app
              //       ),
              // ),
            ),
          ),
        )
      );
    } else {
      return child; // Trả về màn hình gốc nếu nhỏ hơn 600px
    }
  }
}