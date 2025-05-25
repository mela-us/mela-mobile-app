import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../constants/assets.dart';

class DecorativeRing extends StatefulWidget {
  final double size;
  final bool clockwise;
  final int duration;
  final double sigma;

  const DecorativeRing({
    super.key,
    this.size = 500,
    this.clockwise = true,
    this.duration = 60,
    this.sigma = 3.5,
  });

  @override
  _DecorativeRingState createState() => _DecorativeRingState();
}

class _DecorativeRingState extends State<DecorativeRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    )..repeat();

    _rotation = Tween<double>(
      begin: 0,
      end: widget.clockwise ? 1 : -1,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotation,
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.greenAccent, Theme.of(context).colorScheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        blendMode: BlendMode.srcIn,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: widget.sigma, sigmaY: widget.sigma),
          child: Image.asset(
            Assets.streak_ring,
            width: widget.size,
            height: widget.size,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
