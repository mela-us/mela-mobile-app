import 'package:flutter/material.dart';
import '../../../themes/default/colors_standards.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStandards.AppBackgroundColor,
      body: const SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(
          )
        )
      )
    );
  }
}
