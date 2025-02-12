import 'package:flutter/material.dart';
import 'package:mela/presentation/signup_login_screen/login_or_signup_screen.dart';
import '../../constants/assets.dart';
import '../../constants/app_theme.dart';
import '../../di/service_locator.dart';
import '../signup_login_screen/store/user_login_store/user_login_store.dart';
import 'store/personal_store.dart';
import 'personal_info.dart';
import 'widgets/signout_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  //Stores:---------------------------------------------------------------------
  final PersonalStore _store = getIt<PersonalStore>();
  final UserLoginStore _loginStore = getIt<UserLoginStore>();
  //State set:------------------------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _store.getUserInfo();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
        child: SizedBox(
          height: 570.0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 430.0,
                  padding: const EdgeInsets.only(top: 70.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Image.asset(Assets.personal_info, width: 18, height: 18),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: Text(
                          'Thông tin cá nhân',
                          style: Theme.of(context).textTheme.buttonStyle
                              .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonalInfo(
                                name: _store.user?.name ?? 'Người học không tên',
                                email: _store.user?.email ?? '',
                                dob: _store.user?.dob ?? '',
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Image.asset(Assets.personal_language, width: 18, height: 18),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: Text(
                          'Ngôn ngữ',
                          style: Theme.of(context).textTheme.buttonStyle
                              .copyWith(color: Theme.of(context).colorScheme.textInBg2),
                        ),
                        onTap: () {
                          // Navigate to language settings page
                        },
                      ),
                      ListTile(
                        leading: Image.asset(Assets.personal_darkmode, width: 18, height: 18),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: Text(
                          'Chế độ tối',
                          style: Theme.of(context).textTheme.buttonStyle
                              .copyWith(color: Theme.of(context).colorScheme.textInBg2),
                        ),
                        onTap: () {
                          // Toggle dark mode
                        },
                      ),
                      ListTile(
                        leading: Image.asset(Assets.personal_term, width: 18, height: 18),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: Text(
                          'Các điều khoản',
                          style: Theme.of(context).textTheme.buttonStyle
                              .copyWith(color: Theme.of(context).colorScheme.textInBg2),
                        ),
                        onTap: () {
                          // Navigate to terms and conditions page
                        },
                      ),
                      ListTile(
                        leading: Image.asset(Assets.personal_support, width: 18, height: 18),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: Text(
                          'Trung tâm hỗ trợ',
                          style: Theme.of(context).textTheme.buttonStyle
                              .copyWith(color: Theme.of(context).colorScheme.textInBg2),
                        ),
                        onTap: () {
                          // Navigate to support center page
                        },
                      ),
                      ListTile(
                        leading: Image.asset(Assets.personal_signout, width: 18, height: 18),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: Text(
                          'Đăng xuất',
                          style: Theme.of(context).textTheme.buttonStyle
                              .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                        ),
                        onTap: () {
                          _showLogoutConfirmationDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(Assets.default_profile_pic),
                      radius: 50.0,
                    ),
                    SizedBox(height: 5.0),
                    Observer(
                      builder: (context) {
                        if (_store.progressLoading || _store.detailedProgressLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Text(
                          _store.user?.name ?? 'Người học không tên',
                          style: Theme.of(context).textTheme.bigTitle
                              .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                        );
                      },
                    ),
                  ],
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
            _store.logout();
            _loginStore.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginOrSignupScreen()), // Màn hình đăng nhập
              (Route<dynamic> route) {
                return false;
              },
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