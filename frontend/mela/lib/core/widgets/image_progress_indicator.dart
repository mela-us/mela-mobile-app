import 'package:flutter/material.dart';

import '../../constants/assets.dart';

class RotatingImageIndicator extends StatefulWidget {
  const RotatingImageIndicator({super.key});

  @override
  _RotatingImageIndicatorState createState() => _RotatingImageIndicatorState();
}

class _RotatingImageIndicatorState extends State<RotatingImageIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Duration for one full rotation
      vsync: this,
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller, // The animation controller for rotation
      child: Image(
        image: AssetImage(Assets.loading_icon), // Replace with your image path
        width: 100.0, // Set your desired width
        height: 100.0, // Set your desired height
      ),
    );
  }
}