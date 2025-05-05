import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mela/constants/app_theme.dart';

import '../../constants/assets.dart';

class StreakScreen extends StatefulWidget {
  final int prevStreak;

  const StreakScreen({super.key, required this.prevStreak});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  late int streak;
  bool hasIncreased = false;

  @override
  void initState() {
    super.initState();

    streak = widget.prevStreak;

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        streak += 1;
        hasIncreased = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const imageSize = 220.0;

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
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [Theme.of(context).colorScheme.tertiary, Colors.lightBlueAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcIn,
                            child: Image.asset(
                              Assets.streak_ring,
                              width: imageSize,
                              height: imageSize,
                              fit: BoxFit.fill,
                            ),
                          ).animate().scale(duration: 1.5.seconds).rotate(),
                          Text(
                            '$streak',
                            style: Theme.of(context).textTheme.heading.copyWith(
                              fontSize: (streak / 10 >= 1)
                                  ? ((streak / 100 >= 1)
                                      ? 50
                                      : 70)
                                  : 88,
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Asap',
                            ),
                          ).animate().scale(duration: 2.5.seconds),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                    end: const Offset(0, -2),
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
                    Navigator.of(context).pop();
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

    int type = widget.prevStreak % 4;

    if (widget.prevStreak == 0) {
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