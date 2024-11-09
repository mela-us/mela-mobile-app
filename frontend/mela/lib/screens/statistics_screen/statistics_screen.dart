import 'package:flutter/material.dart';
import '../../themes/default/colors_standards.dart';
import '../../themes/default/text_styles.dart';
import '../signup_login_screen/login_or_signup_screen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStandards.AppBackgroundColor,
      appBar: AppBar(
        title: TextStandard.Heading("Thống kê", ColorsStandards.textColorInBackground1),
        backgroundColor: ColorsStandards.AppBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: Center(
      ),
    );
  }
}