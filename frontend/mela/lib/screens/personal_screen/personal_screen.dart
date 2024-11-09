import 'package:flutter/material.dart';
import 'personal_information_screen.dart';
import '../../themes/default/colors_standards.dart';
import '../../themes/default/text_styles.dart';
import '../signup_login_screen/login_or_signup_screen.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStandards.AppBackgroundColor,
      appBar: AppBar(
        title: TextStandard.Heading("Cá nhân", ColorsStandards.textColorInBackground1),
        backgroundColor: ColorsStandards.AppBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SizedBox(
          height: 570.0, // Increased height to accommodate the avatar
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // White rectangle container
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
                        leading: Image.asset('assets/icons/personal_info.png', width: 18, height: 18),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: TextStandard.Button("Thông tin cá nhân", ColorsStandards.textColorInBackground1),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PersonalInfoScreen(
                                name: "Anh Long",
                                email: "long@gmail.com",
                                dob: "01/01/2003",
                                password: "12345678",
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Image.asset('assets/icons/personal_language.png', width: 18, height: 18),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: TextStandard.Button("Ngôn ngữ", ColorsStandards.textColorInBackground2),
                        onTap: () {
                          // Navigate to language settings page
                        },
                      ),
                      ListTile(
                        leading: Image.asset('assets/icons/personal_darkmode.png', width: 18, height: 18),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: TextStandard.Button("Chế độ tối", ColorsStandards.textColorInBackground2),
                        onTap: () {
                          // Toggle dark mode
                        },
                      ),
                      ListTile(
                        leading: Image.asset('assets/icons/personal_term.png', width: 18, height: 18),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: TextStandard.Button("Các điều khoản", ColorsStandards.textColorInBackground2),
                        onTap: () {
                          // Navigate to terms and conditions page
                        },
                      ),
                      ListTile(
                        leading: Image.asset('assets/icons/personal_support.png', width: 18, height: 18),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: TextStandard.Button("Trung tâm hỗ trợ", ColorsStandards.textColorInBackground2),
                        onTap: () {
                          // Navigate to support center page
                        },
                      ),
                      ListTile(
                        leading: Image.asset('assets/icons/personal_signout.png', width: 18, height: 18),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18.0),
                        title: TextStandard.Button("Đăng xuất", ColorsStandards.textColorInBackground1),
                        onTap: () {
                          _showLogoutConfirmationDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Floating Avatar and User Name
              Positioned(
                top: 0, // Adjusted top position
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/icons/default_profile_pic.png'),
                      radius: 50.0,
                    ),
                    SizedBox(height: 5.0), // Space between Avatar and Name
                    TextStandard.BigTitle("Anh Long", ColorsStandards.textColorInBackground1),
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

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return _buildLogoutConfirmationDialog(context);
    },
  );
}

Widget _buildLogoutConfirmationDialog(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextStandard.SubHeading(
            "Bạn có chắc là bạn muốn đăng xuất?",
            ColorsStandards.textColorInBackground1,
          ),
          SizedBox(height: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginOrSignupScreen()
                  )
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TextStandard.SubHeading(
                    "Đăng Xuất",
                    Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: TextStandard.SubHeading(
                    "Hủy",
                    Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}