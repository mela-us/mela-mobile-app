import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/buid_no_internet_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/examination/exam_screen.dart';
import 'package:mela/presentation/home_screen/home_screen.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:mela/presentation/stats_history/stats.dart';
import 'package:mela/presentation/personal/personal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import '../constants/assets.dart';
import '../core/widgets/custom_navigation_bar.dart';
import '../utils/notifications/notification_service.dart';
import 'chat/chat_screen.dart';
import 'examination/controller/exam_screen_controller.dart';
import 'examination/widgets/exam_change_tab_overlay_widget.dart';

class AllScreens extends StatefulWidget {
  @override
  _AllScreensState createState() => _AllScreensState();
}

class _AllScreensState extends State<AllScreens> {
  bool middle_tab_chosen = true;
  // Index for the currently selected tab
  final _levelStore = getIt<LevelStore>();
  int _currentIndex = 2;
  int _previousIndex = -1;
  // late PageController _pageController;
  // List of screens for each tab
  final ExamScreenController _examScreenController = ExamScreenController();

  late List<Widget> _screens = [];
  late final StreamSubscription<List<ConnectivityResult>> subscription;

  @override
  void initState() {
    super.initState();
    //
    _screens = [
      ExamScreen(controller: _examScreenController),
      const StatisticsScreen(),
      const HomeScreen(),
      ChatScreen(),
      const PersonalScreen(),
    ];
    //
    // _pageController = PageController();
    _getNotificationPref();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((List<ConnectivityResult> result) {
        final hasConnection = result.contains(ConnectivityResult.mobile) ||
            result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.ethernet);

        if (!hasConnection) {
          print("Sa ====> Không có internet khi thay đổi kết nố ở all Screens");
          showDialogNoInternet();
        } else {
          print("Sa ====> Có internet quay trở lại ở all Screens");
        }
      });
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  void onTabTapped(int index) {
    final isLeavingExam = _currentIndex == 0 && index != 0;

    if (isLeavingExam) {
      _examScreenController.showExitOverlay?.call(() {
        setState(() {
          _levelStore.resetErrorString();
          _previousIndex = _currentIndex;
          _currentIndex = index;
          middle_tab_chosen = index == 2;
        });
        Vibration.vibrate(duration: 60);
      });

      return;
    }

    setState(() {
      _levelStore.resetErrorString();
      _previousIndex = _currentIndex;
      _currentIndex = index;
      middle_tab_chosen = index == 2;
    });

    Vibration.vibrate(duration: 60);
  }


  void showDialogNoInternet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const BuidNoInternetWidget();
      },
    );
  }

  Future<void> _getNotificationPref() async {
    await NotificationService().cancelAllNotifications();

    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool('streak_notifications_enabled') ?? true;

    if (isEnabled) {
      NotificationService()
          .scheduleNotification(hour: 6, minute: 0, notifyFromTomorrow: false);
      NotificationService().scheduleNotification(
          hour: 19, minute: 30, notifyFromTomorrow: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                child: Container(
                  color: Theme.of(context).colorScheme.buttonNoText,
                  child: AnimatedScale(
                    scale: middle_tab_chosen ? 1.0 : 0.7,
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset(
                      Assets.nav_tutor,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
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
        bottomNavigationBar: CustomNavigationBar(
            currentIndex: _currentIndex,
            screens: _screens,
            onTap: onTabTapped));
  }
}
