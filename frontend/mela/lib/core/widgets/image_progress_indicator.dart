import 'package:flutter/material.dart';

import '../../constants/assets.dart';

class RotatingImageIndicator extends StatefulWidget {
  final double size;

  const RotatingImageIndicator({
    super.key,
    this.size = 100.0,
  });

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
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image(
        image: AssetImage(Assets.loading_icon),
        width: widget.size,
        height: widget.size,
        fit: BoxFit.fill,
      ),
    );
  }
}
