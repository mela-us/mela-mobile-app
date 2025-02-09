import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/personal/widgets/delete_account_dialog.dart';
import '../../themes/default/colors_standards.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'edit_screens/edit_birthdate_screen.dart';
import 'edit_screens/edit_email_screen.dart';
import 'edit_screens/edit_name_screen.dart';

class PersonalInfo extends StatefulWidget {
  final String name;
  final String email;
  final String dob;

  const PersonalInfo({
    super.key,
    required this.name,
    required this.email,
    required this.dob,
  });

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  void initState() {
    super.initState();
  }

  // Hàm điều hướng đến màn hình chỉnh sửa
  void _navigateToEditName() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditNameScreen(name: widget.name),
      ),
    );
  }

  void _navigateToEditEmail() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditEmailScreen(email: widget.email),
      ),
    );
  }

  void _navigateToEditBirthdate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditBirthdateScreen(birthdate: widget.dob),
      ),
    );
  }

  // Hàm hiển thị hộp thoại xác nhận xóa tài khoản
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteAccountConfirmationDialog(
          onDelete: () {
            //TODO: add delete account logic
            Navigator.of(context).pop(); // Đóng hộp thoại
          },
          onCancel: () {
            Navigator.of(context).pop(); // Đóng hộp thoại
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStandards.AppBackgroundColor,
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
        backgroundColor: ColorsStandards.AppBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                  height: 310.0,
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
                      GestureDetector(
                        onTap: _navigateToEditName,
                        child: Observer(
                          builder: (_) => ListTile(
                            title: Text(
                              "Tên người dùng",
                              style: Theme.of(context)
                                  .textTheme
                                  .subHeading
                                  .copyWith(color: Theme.of(context).colorScheme.primary),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(widget.name),
                                const SizedBox(width: 8.0),
                                const Icon(Icons.arrow_forward_ios, size: 18.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToEditEmail,
                        child: Observer(
                          builder: (_) => ListTile(
                            title: Text(
                              "Email",
                              style: Theme.of(context)
                                  .textTheme
                                  .subHeading
                                  .copyWith(color: Theme.of(context).colorScheme.primary),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(widget.email),
                                const SizedBox(width: 8.0),
                                const Icon(Icons.arrow_forward_ios, size: 18.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToEditBirthdate,
                        child: Observer(
                          builder: (_) => ListTile(
                            title: Text(
                              "Ngày sinh",
                              style: Theme.of(context)
                                  .textTheme
                                  .subHeading
                                  .copyWith(color: Theme.of(context).colorScheme.primary),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(widget.dob),
                                const SizedBox(width: 8.0),
                                const Icon(Icons.arrow_forward_ios, size: 18.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showDeleteAccountDialog, // Gọi hàm hiển thị hộp thoại
                        child: Observer(
                          builder: (_) => ListTile(
                            title: Text(
                              "Xóa tài khoản",
                              style: Theme.of(context)
                                  .textTheme
                                  .subHeading
                                  .copyWith(color: Colors.redAccent),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 8.0),
                                const Icon(Icons.arrow_forward_ios, size: 18.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/icons/default_profile_pic.png'),
                          radius: 50.0,
                        ),
                        const SizedBox(height: 5.0),
                        Observer(builder: (_) => Text("")),
                      ],
                    ),
                    Positioned(
                      bottom: 35,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.asset(
                          "assets/icons/upload_profile_pic.png",
                          width: 35,
                          height: 35,
                        ),
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
}