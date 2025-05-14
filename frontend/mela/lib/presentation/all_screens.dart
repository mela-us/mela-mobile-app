import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/home_screen/home_screen.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/stats/stats.dart';
import 'package:mela/presentation/personal/personal.dart';
import 'package:mela/presentation/tutor/tutor_screen.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:vibration/vibration.dart';

import '../constants/assets.dart';
import '../core/widgets/custom_navigation_bar.dart';
import 'chat/chat_screen.dart';

class AllScreens extends StatefulWidget {
  @override
  _AllScreensState createState() => _AllScreensState();
}

class _AllScreensState extends State<AllScreens> {
  bool tutor_chosen = false;
  // Index for the currently selected tab
  final _levelStore = getIt<LevelStore>();
  int _currentIndex = 0;
  int _previousIndex = -1;
  late PageController _pageController;
  // List of screens for each tab
  final List<Widget> _screens = [
    HomeScreen(),
    StatisticsScreen(),
    TutorScreen(),
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
      _previousIndex = _currentIndex;
      _currentIndex = index;
      if (index != 2) {
        tutor_chosen = false;
      } else {
        tutor_chosen = true;
      }
    });
    Vibration.vibrate(duration: 60);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Transform.translate(
          offset: const Offset(0, 15),
          child: SizedBox(
            width: 60,
            height: 60,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.appBackground,
              foregroundColor: Theme.of(context).colorScheme.textInBg1,
              shape: const CircleBorder(),
              elevation: 2.0,
              onPressed: () {
                onTabTapped(2);
              },
              child: ClipOval(
                child: Image.asset(
                  tutor_chosen ? Assets.nav_tutor_focus : Assets.nav_tutor,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final slideDirection =
                _currentIndex > _previousIndex ? Offset(1, 0) : Offset(-1, 0);

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
        // bottomNavigationBar: BottomAppBar(
        //   shape: CircularNotchedRectangle(),
        //   notchMargin: 6,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       IconButton(onPressed: () {}, icon: Icon(Icons.home)),
        //       IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        //       SizedBox(width: 48), // chừa chỗ cho FAB
        //       IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        //       IconButton(onPressed: () {}, icon: Icon(Icons.info)),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: CustomNavigationBar(
            currentIndex: _currentIndex,
            screens: _screens,
            onTap: onTabTapped));
  }
}
