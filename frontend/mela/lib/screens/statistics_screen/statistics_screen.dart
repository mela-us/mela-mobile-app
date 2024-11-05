import 'package:flutter/material.dart';
import '../../../themes/default/colors_standards.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
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
