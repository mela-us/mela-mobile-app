import 'package:flutter/material.dart';
import '../../constants/assets.dart';
import '../../constants/app_theme.dart';
import 'store/personal_store.dart';
import 'personal_info/personal_info.dart';
import 'widgets/signout_dialog.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<Personal> {
  final PersonalStore _store = PersonalStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.appBackground,
      appBar: AppBar(
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
                    boxShadow: [
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
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
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
                                name: _store.userName,
                                email: "long@gmail.com",
                                dob: "01/01/2003",
                                password: "12345678",
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Image.asset(Assets.personal_language, width: 18, height: 18),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
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
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
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
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
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
                      backgroundImage: AssetImage('assets/icons/default_profile_pic.png'),
                      radius: 50.0,
                    ),
                    SizedBox(height: 5.0),
                    Observer(
                      builder: (_) => Text(
                        _store.userName,
                        style: Theme.of(context).textTheme.bigTitle
                            .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                      ),
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
            _store.logout(); // Call logout from the store
            Navigator.of(context).pop(); // Close the dialog
            // Optionally navigate to login/screen
          },
          onCancel: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }
}