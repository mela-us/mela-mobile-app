import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mela/presentation/streak/store/streak_store.dart';
import '../../../constants/app_theme.dart';
import '../../constants/assets.dart';
import '../../di/service_locator.dart';

class StreakDialog extends StatefulWidget {
  final VoidCallback onCancel;

  const StreakDialog({
    super.key,
    required this.onCancel,
  });

  @override
  _StreakDialogState createState() => _StreakDialogState();
}

class _StreakDialogState extends State<StreakDialog> {
  //store
  final StreakStore _store = getIt<StreakStore>();

  @override
  Widget build(BuildContext context) {
    const size = 100.0;

    final streak = _store.streak?.current ?? 0;
    final longest = _store.streak?.longest ?? 0;

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 12.0, bottom: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                              children: [
                                Image.asset(Assets.mela_streak, height: size + 2, width: size),
                                const SizedBox(height: 8),
                              ]
                          ),
                          Text(
                            '$streak',
                            style: Theme.of(context).textTheme.subTitle.copyWith(
                              fontSize: (streak / 10 >= 1)
                                  ? ((streak / 100 >= 1) ? 50 : 70)
                                  : 88,
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
                              fontSize: (streak / 10 >= 1)
                                  ? ((streak / 100 >= 1) ? 50 : 70)
                                  : 88,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Asap',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Chuỗi $streak ngày học liên tục.',
                    style: Theme.of(context).textTheme.heading.copyWith(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  if (streak == 0 && longest == 0)
                    Text(
                      'Hãy bắt đầu một hành trình mới!',
                      style: Theme.of(context).textTheme.heading.copyWith(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  if (streak == 0 && longest != 0)
                    Text(
                      'Hãy bắt đầu lại một hành trình mới cùng MELA nhé',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  if (streak > 10 && streak < 50)
                    Text(
                      'Ấn tượng đó, học tập là không ngừng... cố gắng',
                      style: Theme.of(context).textTheme.heading.copyWith(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  if (streak > 50)
                    Text(
                      'Quá sức ấn tượng!',
                      style: Theme.of(context).textTheme.heading.copyWith(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Chuỗi dài nhất: ',
                        style: Theme.of(context).textTheme.heading.copyWith(
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(Assets.mela_streak, height: size/3 + 2, width: size/3),
                          Text(
                            '$streak',
                            style: Theme.of(context).textTheme.subTitle.copyWith(
                              fontSize: (streak / 10 >= 1)
                                  ? ((streak / 100 >= 1) ? 14 : 20)
                                  : 26,
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
                              fontSize: (streak / 10 >= 1)
                                  ? ((streak / 100 >= 1) ? 14 : 20)
                                  : 26,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Asap',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: widget.onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        'OK',
                        style: Theme.of(context)
                            .textTheme
                            .subHeading
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )).animate().fadeIn(duration: 300.ms).slideY(begin: 1, end: 0);
  }
}
