import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/presentation/streak/store/streak_store.dart';
import '../../constants/assets.dart';
import '../../di/service_locator.dart';

class StreakActionIcon extends StatefulWidget {

  const StreakActionIcon({super.key});

  @override
  State<StreakActionIcon> createState() => _StreakActionIconState();
}

class _StreakActionIconState extends State<StreakActionIcon> {
  
  //store
  final StreakStore _store = getIt<StreakStore>();

  @override
  Widget build(BuildContext context) {

    _store.getStreak();

    print("BUILD STREAK ACTION ICON");

    final double size = 28;

    return Observer(builder: (context) {
      if (_store.isLoading) {
        return RotatingImageIndicator(size: size);
      }
      //
      final streak = _store.streak?.current ?? 0;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Colors.orange.shade700, Colors.red.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Image.asset(
                  Assets.streak_ring,
                  width: size,
                  height: size,
                  fit: BoxFit.fill,
                ).animate(onPlay: (controller) => controller.repeat(),)
                    .rotate(duration: const Duration(seconds: 1), curve: Curves.linear, end: 1.0,)
                    .rotate(duration: const Duration(seconds: 0), end: 1.0, delay: const Duration(seconds: 8),
                ),
              ),
              Text(
                '$streak',
                style: Theme.of(context).textTheme.subTitle.copyWith(
                  fontSize: (streak / 100 >= 1)
                      ? 14
                      : 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Asap',
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Theme.of(context).colorScheme.appBackground,
                ),
              ),
              Text(
                '$streak',
                style: Theme.of(context).textTheme.subTitle.copyWith(
                  fontSize: (streak / 100 >= 1)
                      ? 14
                      : 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Asap',
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
  
}