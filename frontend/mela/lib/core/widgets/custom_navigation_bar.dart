import 'package:flutter/material.dart';
import '../../constants/app_theme.dart';
import '../../constants/assets.dart';

class CustomNavigationBar extends StatefulWidget {
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
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.9, end: 1.4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    widget.onTap(index);
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Theme.of(context).colorScheme.appBackground,
      padding: const EdgeInsets.only(bottom: 8),
      height: 68,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Assets.nav_topic, 'CHỦ ĐỀ', 0, context),
          _buildNavItem(Assets.nav_stats, 'THỐNG KÊ', 1, context),
          SizedBox(width: 60), // Placeholder for the center item
          _buildNavItem(Assets.nav_chat, 'CHAT AI', 3, context),
          _buildNavItem(Assets.nav_personal, 'CÁ NHÂN', 4, context),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      String iconPath, String label, int index, BuildContext context) {
    return InkWell(
      onTap: () => _onTap(index),
      borderRadius: BorderRadius.circular(
          12), // Optional: Add rounded corners to the InkWell
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8), // Optional: Add padding inside the InkWell
        child: ScaleTransition(
          scale: index == widget.currentIndex
              ? _animation
              : const AlwaysStoppedAnimation(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 24,
                height: 24,
                color: widget.currentIndex == index
                    ? Theme.of(context).colorScheme.buttonYesBgOrText
                    : Theme.of(context).colorScheme.textInBg2,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.miniCaption.copyWith(
                      fontSize: 9,
                      color: widget.currentIndex == index
                          ? Theme.of(context).colorScheme.buttonYesBgOrText
                          : Theme.of(context).colorScheme.textInBg2,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
