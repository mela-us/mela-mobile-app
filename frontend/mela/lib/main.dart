import 'package:flutter/material.dart';
import 'package:mela/themes/default/text_styles.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Expanded(child: TextStandard.SubTitle('Hello', Colors.black)),
        ),
      ),
    );
  }
}
