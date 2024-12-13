import 'package:flutter/material.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/courses_screen/store/topic_store/topic_store.dart';
import 'package:mela/presentation/home_screen/home_screen.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/stats/stats.dart';
import 'package:mela/presentation/personal/personal.dart';

import '../core/widgets/custom_navigation_bar.dart';
import 'chat/chat_screen.dart';
import 'courses_screen/courses_screen.dart';

class AllScreens extends StatefulWidget {
  @override
  _AllScreensState createState() => _AllScreensState();
}

class _AllScreensState extends State<AllScreens> {
  // Index for the currently selected tab
  final _levelStore = getIt<LevelStore>();
  int _currentIndex = 0;

  // List of screens for each tab
  final List<Widget> _screens = [
    HomeScreen(),
    StatisticsScreen(),
    ChatScreen(),
    PersonalScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      //eg: turnoff wifi,have errorString in _topicStore, change other tab, then turn on wifi, go back coureses screen, it will need to set errorString to empty
      _levelStore.resetErrorString();
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: CustomNavigationBar(
            currentIndex: _currentIndex,
            screens: _screens,
            onTap: onTabTapped));
  }
}
