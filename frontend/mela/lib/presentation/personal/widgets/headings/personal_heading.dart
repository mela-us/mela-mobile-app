import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import '../../../../constants/assets.dart';
import '../../../../core/widgets/underline_indicator.dart';
import '../../../../di/service_locator.dart';
import '../../../../utils/animation_helper/animation_helper.dart';
import '../../../streak/store/streak_store.dart';
import '../../store/personal_store.dart';

class PersonalHeading extends StatefulWidget  {
  const PersonalHeading({super.key, required this.onNavigateToStats, required this.onShowStreak, required this.onLevelSelect, required this.tabController});

  final VoidCallback onNavigateToStats;
  final VoidCallback onShowStreak;
  final VoidCallback onLevelSelect;

  final TabController tabController;

  @override
  _PersonalHeadingState createState() => _PersonalHeadingState();
}

class _PersonalHeadingState extends State<PersonalHeading> with SingleTickerProviderStateMixin {

  final PersonalStore _store = getIt<PersonalStore>();
  final StreakStore _streakStore = getIt<StreakStore>();

  int _selectedTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = widget.tabController;

    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 16),
                          _buildProfileImage(url,90).animate().fadeIn(duration: 300.ms),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _store.user?.name ?? "Học viên MELA",
                                        style: Theme.of(context).textTheme.bigTitle.copyWith(
                                          color: Theme.of(context).colorScheme.textInBg1,
                                        ),
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                      ).animate().fadeIn(duration: 300.ms),
                                      const SizedBox(height: 4),
                                      _buildLevelSelectButton().animate().fadeIn(duration: 300.ms),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                              children: [
                                const SizedBox(height: 0.8),
                                _buildStreak(streak),
                              ]
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      TabBar(
                        controller: _tabController,
                        onTap: (index) {
                          setState(() {
                            _selectedTab = index;
                          });
                        },
                        labelColor: Theme.of(context).colorScheme.tertiary,
                        unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                        dividerColor: Colors.transparent,
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        indicator: UnderlineIndicator(
                          width: 86,
                          height: 2.5,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              "Đánh giá học tập",
                              style: Theme.of(context).textTheme.subTitle.copyWith(
                                color: _selectedTab == 0
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Tùy chọn cá nhân",
                              style: Theme.of(context).textTheme.subTitle.copyWith(
                                color: _selectedTab == 1
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      )
                    ]
                )
            )
        );
      },
    );
  }

  Widget _buildStreak(int streak) {
    const double size = 32.0;
    double size1 = 28;
    double size10 = 22;
    double size100 = 16;
    return InkWell(
      onTap: widget.onShowStreak,
      borderRadius: BorderRadius.circular(size / 2),
      child: Stack(
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
                  ? ((streak / 100 >= 1) ? size100 : size10)
                  : size1,
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
                  ? ((streak / 100 >= 1) ? size100 : size10)
                  : size1,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontFamily: 'Asap',
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProfileImage(String url, double size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return AnimationHelper.buildShimmerPlaceholder(context, size, size);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            Assets.default_profile_pic,
            width: size,
            height: size,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
  
  Widget _buildLevelSelectButton() {
    return OutlinedButton(
      onPressed: widget.onLevelSelect,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1.5),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
        side: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        visualDensity: VisualDensity.standard,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _store.user?.level ?? 'Chưa chọn lớp',
            style: Theme.of(context).textTheme.buttonStyle.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.edit_outlined, size: 18, color: Theme.of(context).colorScheme.tertiary),
        ],
      ),
    );
  }
  
  Widget _buildNavigateToHistoryButton() {
    return FilledButton(
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
    );
  }

}