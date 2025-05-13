import 'package:flutter/material.dart';
import 'package:mela/presentation/detailed_stats_and_comments/detailed_stats_and_comments.dart';
import 'package:mela/presentation/signup_login_screen/login_or_signup_screen.dart';
import '../../constants/assets.dart';
import '../../constants/app_theme.dart';
import '../../core/widgets/image_progress_indicator.dart';
import '../../di/service_locator.dart';
import '../signup_login_screen/store/user_login_store/user_login_store.dart';
import '../streak/store/streak_store.dart';
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
      body: Center(
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
                            Assets.personal_darkmode,
                            'Thống kê',
                                () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => DetailedStatsAndCommentsScreen(
                                        name: _store.user?.name ?? 'Người học không tên',
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
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildPersonalHeading() {
    return Container(
      height: 200.0,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.topCenter,
      child: Observer(
        builder: (context) {
          if (_store.progressLoading || _streakStore.isLoading) {
            return const Center(child: RotatingImageIndicator());
          }
          //streak
          final streak = _streakStore.streak?.current ?? 0;
          final bestStreak = _streakStore.streak?.longest ?? 0;
          //url
          final url = _store.user?.imageUrl ?? '';
          _profileImage = url.isNotEmpty
              ? NetworkImage(url)
              : const AssetImage('assets/icons/default_profile_pic.png') as ImageProvider<Object>;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  width: 75.0,
                  height: 75.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _profileImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 300.ms),
              const SizedBox(height: 2.0),
              Text(
                _store.user?.name ?? 'Người học không tên',
                style: Theme.of(context).textTheme.bigTitle.copyWith(
                  color: Theme.of(context).colorScheme.textInBg1,
                ),
              ).animate().fadeIn(duration: 300.ms),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStreakColumn(streak, "Chuỗi hiện tại"),
                  _buildStreakColumn(bestStreak, "Chuỗi dài nhất"),
                ]
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildStreakColumn(int streak, String content) {
    final size = 40.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content,
          style: Theme.of(context).textTheme.heading.copyWith(
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                      width: size,
                      height: size,
                      fit: BoxFit.fill,
                    )
                ),
                Text(
                  '$streak',
                  style: Theme.of(context).textTheme.subTitle.copyWith(
                    fontSize: (streak / 10 >= 1)
                        ? ((streak / 100 >= 1)
                        ? 14
                        : 20)
                        : 30,
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
                        ? ((streak / 100 >= 1)
                        ? 14
                        : 20)
                        : 30,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Asap',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LogoutConfirmationDialog(
          onLogout: () {
            _store.logout();
            _loginStore.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginOrSignupScreen()),
                  (Route<dynamic> route) => false,
            );
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}