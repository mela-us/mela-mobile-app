import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/streak/store/streak_store.dart';

import '../../constants/assets.dart';
import '../../di/service_locator.dart';

class StreakScreen extends StatefulWidget {
  final int streak;

  const StreakScreen({super.key, required this.streak});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  late int streak;
  bool hasIncreased = false;

  final StreakStore _streakStore = getIt<StreakStore>();

  @override
  void initState() {
    super.initState();

    _streakStore.toggleUpdate(); //sau khi update xong rồi, toggle trở lại thành false

    _streakStore.getStreak();

    streak = widget.streak;

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        streak += 1;
        hasIncreased = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const imageSize = 140.0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Nội dung giữa, chiếm khoảng trống
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  _buildStreakText()
                      .animate()
                      .slide(
                    begin: const Offset(-3, 0),
                    end: const Offset(0, 0),
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeOut,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(Assets.mela_streak, height: imageSize + 2, width: imageSize).animate().scale(duration: 1.5.seconds),
                          Text(
                            '$streak',
                            style: Theme.of(context).textTheme.heading.copyWith(
                              fontSize: (streak / 10 >= 1)
                                  ? ((streak / 100 >= 1)
                                  ? 60
                                  : 80)
                                  : 100,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2.8
                                ..color = Theme.of(context).colorScheme.appBackground,
                            ),
                          ).animate().scale(duration: 2.5.seconds),
                          Text(
                            '$streak',
                            style: Theme.of(context).textTheme.heading.copyWith(
                              fontSize: (streak / 10 >= 1)
                                  ? ((streak / 100 >= 1)
                                  ? 60
                                  : 80)
                                  : 100,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Asap',
                            ),
                          ).animate().scale(duration: 2.5.seconds),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 0),
                  Stack(
                    children: [
                      Text(
                        'CHUỖI NGÀY HỌC LIÊN TỤC',
                        style: Theme.of(context).textTheme.heading.copyWith(
                          fontSize: 30,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2.8
                            ..color = Theme.of(context).colorScheme.appBackground,
                        ),
                      ),
                      Text(
                        'CHUỖI NGÀY HỌC LIÊN TỤC',
                        style: Theme.of(context).textTheme.heading.copyWith(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ).animate().slide(
                    begin: const Offset(0, 6),
                    end: const Offset(0, 0),
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeOut,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Hãy tiếp tục kéo dài hành trình học tập này nhé!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.heading
                        .copyWith(color: Theme.of(context).colorScheme.primary, fontSize: 18),
                  )
                ],
              ),
            ),
            // Nút ở dưới cùng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  child: Text(
                    'OK. Tuyệt!',
                    style: Theme.of(context).textTheme.buttonStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStreakText() {
    String txt;

    int type = widget.streak % 4;

    if (widget.streak == 1) {
      txt = 'Một cuộc hành trình mới bắt đầu!!!';
    } else {
      if (type == 0) {
        txt = 'Có công mài sắt, Có ngày nên kim!';
      }
      else if (type == 1) {
        txt = 'Đừng bao giờ từ bỏ nhé\nBạn đang làm rất tốt';
      }
      else if (type == 2) {
        txt = 'Cố gắng lên nào, bạn đang làm tốt';
      }
      else if (type == 3 && streak > 10) {
        txt = 'Chuỗi học của bạn thực sự ấn tượng';
      }
      else {
        txt = 'Chăm chỉ thành tài\nMiệt mài tất giỏi';
      }
    }

    return Text(
      txt,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.heading
          .copyWith(color: Theme.of(context).colorScheme.tertiary, fontSize: 40),
    );
  }
}