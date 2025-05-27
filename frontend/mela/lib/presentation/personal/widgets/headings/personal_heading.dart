import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import '../../../../constants/assets.dart';
import '../../../../di/service_locator.dart';
import '../../../../utils/animation_helper/animation_helper.dart';
import '../../../streak/store/streak_store.dart';
import '../../store/personal_store.dart';

class PersonalHeading extends StatefulWidget {
  const PersonalHeading({super.key, required this.onNavigateToStats, required this.onShowStreak, required this.onLevelSelect});

  final VoidCallback onNavigateToStats;
  final VoidCallback onShowStreak;
  final VoidCallback onLevelSelect;

  @override
  _PersonalHeadingState createState() => _PersonalHeadingState();
}

class _PersonalHeadingState extends State<PersonalHeading> {

  final PersonalStore _store = getIt<PersonalStore>();
  final StreakStore _streakStore = getIt<StreakStore>();

  @override
  Widget build(BuildContext context) {
    return _buildPersonalHeading();
  }

  Widget _buildPersonalHeading() {
    return Observer(
      builder: (context) {
        if (_store.progressLoading || _store.isLoading || _streakStore.isLoading) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
                child: AnimationHelper.buildShimmerPlaceholder(
                  context, 400, 160,
                  base: Colors.white,
                  highlight: Theme.of(context).colorScheme.tertiary,
                )
            ),
          );
        }
        //streak
        final streak = _streakStore.streak?.current ?? 0;
        //url
        final url = _store.user?.imageUrl ?? '';
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              url,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return AnimationHelper.buildShimmerPlaceholder(context, 80, 80);
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  Assets.default_profile_pic,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ).animate().fadeIn(duration: 300.ms),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _store.user?.name ?? "a",
                                        style: Theme.of(context).textTheme.bigTitle.copyWith(
                                          color: Theme.of(context).colorScheme.textInBg1,
                                        ),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      ).animate().fadeIn(duration: 300.ms),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                    children: [
                                      OutlinedButton(
                                        onPressed: widget.onLevelSelect,
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: Size.zero,
                                          side: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                                          visualDensity: VisualDensity.standard,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _store.user?.level ?? 'Lớp 1',
                                              style: Theme.of(context).textTheme.buttonStyle.copyWith(
                                                color: Theme.of(context).colorScheme.tertiary,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Icon(Icons.edit_outlined, size: 18, color: Theme.of(context).colorScheme.tertiary),
                                          ],
                                        ),
                                      ).animate().fadeIn(duration: 300.ms),
                                    ]
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FilledButton(
                                        onPressed: widget.onNavigateToStats,
                                        style: FilledButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: Size.zero,
                                          backgroundColor: Theme.of(context).colorScheme.tertiary,
                                          //visualDensity: VisualDensity.compact,
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Xem lịch sử học tập',
                                              style: Theme.of(context).textTheme.buttonStyle.copyWith(
                                                color: Theme.of(context).colorScheme.appBackground,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).animate().fadeIn(duration: 300.ms),
                                    ),
                                    const SizedBox(width: 5),
                                    _buildStreak(streak)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                      TabBar(
                        labelColor: Theme.of(context).colorScheme.tertiary,
                        unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
                        dividerColor: Colors.transparent,
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.tertiary,
                            width: 2,
                          ),
                        ),
                        tabs: const [
                          Tab(text: 'Đánh giá học tập'),
                          Tab(text: 'Tùy chọn'),
                        ],
                      ),
                    ]
                )
            )
        );
      },
    );
  }

  Widget _buildStreak(int streak) {
    const double size = 30.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: widget.onShowStreak,
          borderRadius: BorderRadius.circular(size / 2),
          child: Stack(
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
                ),
              ),
              Text(
                '$streak',
                style: Theme.of(context).textTheme.subTitle.copyWith(
                  fontSize: (streak / 10 >= 1)
                      ? ((streak / 100 >= 1) ? 13 : 16)
                      : 21,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Asap',
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2.8
                    ..color = Theme.of(context).colorScheme.appBackground,
                ),
              ),
              Text(
                '$streak',
                style: Theme.of(context).textTheme.subTitle.copyWith(
                  fontSize: (streak / 10 >= 1)
                      ? ((streak / 100 >= 1) ? 13 : 16)
                      : 21,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Asap',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}