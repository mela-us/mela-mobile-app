import 'package:flutter/material.dart';
import '../../../themes/default/colors_standards.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
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
