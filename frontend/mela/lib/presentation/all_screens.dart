import 'package:flutter/material.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/home_screen/home_screen.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/stats/stats.dart';
import 'package:mela/presentation/personal/personal.dart';

import '../core/widgets/custom_navigation_bar.dart';
import 'chat/chat_screen.dart';

class AllScreens extends StatefulWidget {
  @override
  _AllScreensState createState() => _AllScreensState();
}

class _AllScreensState extends State<AllScreens> {
  // Index for the currently selected tab
  final _levelStore = getIt<LevelStore>();
  int _currentIndex = 0;
  int _previousIndex = -1;
  late PageController _pageController;
  // List of screens for each tab
  final List<Widget> _screens = [
    HomeScreen(),
    StatisticsScreen(),
    ChatScreen(),
    PersonalScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void onTabTapped(int index) {
    setState(() {
      //eg: turnoff wifi,have errorString in _topicStore, change other tab, then turn on wifi, go back coureses screen, it will need to set errorString to empty
      _levelStore.resetErrorString();

      // _pageController.animateToPage(
      //   index,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeInOut,
      // );
      _previousIndex = _currentIndex;
      _currentIndex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final slideDirection = _currentIndex > _previousIndex ?
                Offset(1, 0) : Offset(-1, 0);

            return ClipRect(
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: slideDirection,
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _screens[_currentIndex], // Load trực tiếp màn hình đích
        ),
        bottomNavigationBar: CustomNavigationBar(
            currentIndex: _currentIndex,
            screens: _screens,
            onTap: onTabTapped));
  }
}
