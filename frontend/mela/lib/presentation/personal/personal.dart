import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/core/widgets/icon_widget/error_icon_widget.dart';
import 'package:mela/presentation/personal/level_selector.dart';
import 'package:mela/presentation/personal/notification_setting/notification_setting.dart';
import 'package:mela/presentation/personal/widgets/headings/personal_heading.dart';
import 'package:mela/presentation/signup_login_screen/login_or_signup_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import '../../constants/assets.dart';
import '../../constants/app_theme.dart';
import '../../di/service_locator.dart';
import '../signup_login_screen/store/user_login_store/user_login_store.dart';
import '../stats_history/stats.dart';
import '../stats_topic_personal/stats_topic_personal.dart';
import '../streak/store/streak_store.dart';
import '../streak/streak_dialog.dart';
import 'store/personal_store.dart';
import 'personal_info.dart';
import 'widgets/dialogs/signout_dialog.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> with SingleTickerProviderStateMixin {
  final PersonalStore _store = getIt<PersonalStore>();
  final UserLoginStore _loginStore = getIt<UserLoginStore>();
  final StreakStore _streakStore = getIt<StreakStore>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadData();

    _tabController = TabController(length: 2, vsync: this);
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
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.textInBg1),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Observer (
          builder: (context) {
            if (_store.errorGettingInfo) {
              return const ErrorIconWidget(
                message: "Đã có lỗi xảy ra. Vui lòng thử lại",
              );
            }
            return _buildBody(context);
          }
      )
    );
  }

  Widget _buildListTile(BuildContext context, String asset, String title,
      VoidCallback onTap, bool disable) {
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
            style: disable
                ? Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Colors.black26)
                : Theme.of(context)
                    .textTheme
                    .subTitle
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

  Widget _buildBody(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: PersonalHeading(
                onLevelSelect: _navigateToLevelSelector,
                onNavigateToStats: _navigateToDetailedStats,
                onShowStreak: _showStreakDialog,
                tabController: _tabController,
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDetailedStatsTab(context),
                  _buildOptionsTab(context),
                ],
              ),
            ),
          ],
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
        pageBuilder: (context, animation, secondaryAnimation) =>
            LevelSelectorScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
          const end = Offset.zero; // Kết thúc ở vị trí gốc
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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

  void _navigateToDetailedStats() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            StatisticsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
          const end = Offset.zero; // Kết thúc ở vị trí gốc
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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

  //TABS
  Widget _buildOptionsTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          ..._buildOptions(context),
        ],
      ),
    );
  }

  Widget _buildDetailedStatsTab(BuildContext context) {
    return const StatsTopicPersonal();
  }

  //OPTION LIST (info, signout...)
  List<Widget> _buildOptions(BuildContext context) {
    return [
      _buildListTile(context, Assets.personal_info, 'Thông tin cá nhân', () {
        if (!_store.progressLoading) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const PersonalInfo(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
                const end = Offset.zero; // Kết thúc ở vị trí gốc
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
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
      }, false),
      _buildListTile(context, Assets.personal_notification, 'Thông báo', () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const NotificationSettingsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
              const end = Offset.zero; // Kết thúc ở vị trí gốc
              const curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
      }, false),
      _buildListTile(context, Assets.personal_term, 'Các điều khoản', () {
        // Navigate to terms and conditions page
      }, true),
      _buildListTile(context, Assets.personal_support, 'Trung tâm hỗ trợ',
          () async {
        final Uri url = Uri.parse('https://datn-math-learning-with-ai.atlassian.net/servicedesk/customer/portal/1');
        if (await canLaunchUrl(url)) {
          await launchUrl(
            url,
            mode: LaunchMode.externalApplication,
          );
        } else {
          // Xử lý không mở được
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Không thể mở liên kết.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }, false),
      _buildListTile(context, Assets.personal_signout, 'Đăng xuất', () {
        if (!_store.progressLoading) {
          _showLogoutConfirmationDialog(context);
        }
      }, false),
    ];
  }
}
