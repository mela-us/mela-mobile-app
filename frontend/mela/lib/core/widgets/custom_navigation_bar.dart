import 'package:flutter/material.dart';

import '../../constants/app_theme.dart';
import '../../constants/assets.dart';

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
      color: Theme.of(context).colorScheme.appBackground,
      padding: const EdgeInsets.only(bottom: 12),
      height: 68,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Assets.nav_topic, 'CHỦ ĐỀ', 0, context),
          _buildNavItem(Assets.nav_stats, 'THỐNG KÊ', 1, context),
          _buildNavItem(Assets.nav_chat, 'CHAT AI', 2, context),
          _buildNavItem(Assets.nav_personal, 'CÁ NHÂN', 3, context),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index, BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: currentIndex == index
                ? Theme.of(context).colorScheme.buttonYesBgOrText
                : Theme.of(context).colorScheme.textInBg2,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.miniCaption.copyWith(
              fontSize: 9,
              color: currentIndex == index
                  ? Theme.of(context).colorScheme.buttonYesBgOrText
                  : Theme.of(context).colorScheme.textInBg2,
            ),
          ),
        ],
      ),
    );
  }
}