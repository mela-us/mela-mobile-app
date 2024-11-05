import 'package:flutter/material.dart';
import 'package:mela/widgets/navbar.dart';
import '../ai_chat_screen/ai_chat_screen.dart';
import '../courses_screen/courses_screen.dart';
import '../personal_screen/personal_screen.dart';
import '../statistics_screen/statistics_screen.dart';

// Import other screens as needed

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const CoursesScreen(),
    const StatisticsScreen(),
    const AiChatScreen(),
    const PersonalScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex], // Display the current screen
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentIndex,
        screens: screens,
        onTap: onTabTapped,
      ),
    );
  }
}