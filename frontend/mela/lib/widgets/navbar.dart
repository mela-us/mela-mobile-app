import 'package:flutter/material.dart';

import '../themes/default/colors_standards.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final List<Widget> screens;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.screens,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsStandards.AppBackgroundColor,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem("assets/icons/nav_topic.png", 'Chủ đề', 0),
          _buildNavItem("assets/icons/nav_stat.png", 'Thống kê', 1),
          _buildNavItem("assets/icons/nav_chat.png", 'Chat AI', 2),
          _buildNavItem("assets/icons/nav_personal.png", 'Cá nhân', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    return GestureDetector(
      onTap: () => onTap(index), // Call the callback
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: currentIndex == index ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
                fontSize: 12,
                color: currentIndex == index ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}