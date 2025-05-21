import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mela/presentation/personal/level_selector.dart';
import 'package:mela/presentation/personal/widgets/decorative_ring.dart';
import 'package:mela/presentation/signup_login_screen/login_or_signup_screen.dart';
import 'package:mela/utils/animation_helper/animation_helper.dart';
import 'package:vibration/vibration.dart';
import '../../constants/assets.dart';
import '../../constants/app_theme.dart';
import '../../core/widgets/image_progress_indicator.dart';
import '../../di/service_locator.dart';
import '../detailed_stats_and_comments/detailed_stats_and_comments.dart';
import '../signup_login_screen/store/user_login_store/user_login_store.dart';
import '../streak/store/streak_store.dart';
import '../streak/streak_dialog.dart';
import 'store/personal_store.dart';
import 'personal_info.dart';
import 'widgets/signout_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  late ImageProvider _profileImage;
  final PersonalStore _store = getIt<PersonalStore>();
  final UserLoginStore _loginStore = getIt<UserLoginStore>();
  final StreakStore _streakStore = getIt<StreakStore>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _store.getUserInfo();
    await _streakStore.getStreak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.appBackground,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Cá nhân',
          style: Theme.of(context).textTheme.heading
              .copyWith(color: Theme.of(context).colorScheme.textInBg1),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 14,
            right: -9,
            child: DecorativeRing(size: 100, duration: 20, sigma: 1),
          ),
          const Positioned(
            top: 100,
            right: 220,
            child: DecorativeRing(size: 300, clockwise: false),
          ),
          const Positioned(
            top: 280,
            right: -270,
            child: DecorativeRing(),
          ),
          _buildBody(context),
        ]
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String asset, String title, VoidCallback onTap, bool disable) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
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
        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: ListTile(
          leading: Image.asset(asset, width: 18, height: 18),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18.0),
          title: Text(
            title,
            style:
            disable ? Theme.of(context).textTheme.subTitle
                .copyWith(color: Colors.black26)
                : Theme.of(context).textTheme.subTitle
                .copyWith(color: Theme.of(context).colorScheme.textInBg1),
          ),
          onTap: () {
            onTap();
            Vibration.vibrate(duration: 40);
          },
        ),
      ),
    );
  }

  Widget _buildPersonalHeading() {
    return Observer(
      builder: (context) {
        if (_store.progressLoading || _streakStore.isLoading) {
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 15.0),
              child: Center(
                  child: AnimationHelper.buildShimmerPlaceholder(
                      context, 400, 114,
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
              child: Row(
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
                        return AnimationHelper.buildShimmerPlaceholder(context, 75, 75);
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
                                _store.user?.name ?? 'Người học không tên',
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
                              onPressed: () {
                                _navigateToLevelSelector();
                              },
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
                                onPressed: () {
                                  final name = _store.user?.name ?? 'Người học không tên';
                                  _navigateToDetailedStats(name, url);
                                },
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
                                      'Xem đánh giá học tập',
                                      style: Theme.of(context).textTheme.buttonStyle.copyWith(
                                        color: Theme.of(context).colorScheme.appBackground,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ).animate().fadeIn(duration: 300.ms),
                            ),
                            const SizedBox(width: 10),
                            _buildStreak(streak)
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
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
          onTap: () {
            _showStreakDialog();
          },
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


  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildPersonalHeading(),
                      const SizedBox(height: 10.0),
                      _buildListTile(
                          context,
                          Assets.personal_info,
                          'Thông tin cá nhân',
                              () {
                            if (!_store.progressLoading) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => PersonalInfo(
                                    name: _store.user?.name ?? 'Người học không tên',
                                    email: _store.user?.email ?? '',
                                    dob: _store.user?.dob ?? '',
                                    imageUrl: _store.user?.imageUrl ?? '',
                                  ),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
                                    const end = Offset.zero; // Kết thúc ở vị trí gốc
                                    const curve = Curves.easeInOut;

                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);

                                    return ClipRect(
                                      child: SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }, false
                      ),
                      _buildListTile(
                          context,
                          Assets.personal_term,
                          'Các điều khoản',
                              () {
                            // Navigate to terms and conditions page
                          }, true
                      ),
                      _buildListTile(
                          context,
                          Assets.personal_support,
                          'Trung tâm hỗ trợ',
                              () {
                            // Navigate to support center page
                          }, true
                      ),
                      _buildListTile(
                          context,
                          Assets.personal_signout,
                          'Đăng xuất',
                              () {
                            if (!_store.progressLoading) {
                              _showLogoutConfirmationDialog(context);
                            }
                          }, false
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LogoutConfirmationDialog(
          onLogout: () {
            Vibration.vibrate(duration: 40);
            _store.logout();
            _loginStore.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginOrSignupScreen()),
                  (Route<dynamic> route) => false,
            );
          },
          onCancel: () {
            Vibration.vibrate(duration: 40);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showStreakDialog() {
    if (_streakStore.isLoading) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreakDialog(
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _navigateToLevelSelector() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LevelSelectorScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
          const end = Offset.zero; // Kết thúc ở vị trí gốc
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return ClipRect(
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  void _navigateToDetailedStats(String name, String url) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DetailedStatsAndCommentsScreen(
          name: name,
          imageUrl: url,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
          const end = Offset.zero; // Kết thúc ở vị trí gốc
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return ClipRect(
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }
}

