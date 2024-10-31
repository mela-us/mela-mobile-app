import 'package:flutter/material.dart';
import 'package:mela/screens/signup_login_screen/widgets/login_or_sign_up_button.dart';
import 'package:mela/screens/signup_login_screen/widgets/third_party_button.dart';

import '../../constants/global.dart';

class LoginScreen extends StatelessWidget {
  void Function() onChangeToSignUp;
  LoginScreen({super.key,required this.onChangeToSignUp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // Added Center widget here
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              child: _FormContent(onChangeToSignUp: onChangeToSignUp),
            ),
          ),
        ),
      ),
      backgroundColor: Global.AppBackgroundColor,
    );
  }
}

class _FormContent extends StatefulWidget {
  void Function() onChangeToSignUp;
  _FormContent({Key? key, required this.onChangeToSignUp}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 340),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title and Subtitle
            Text(
              "Đăng nhập",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.bold,
                  color: Global.textColorInBackground1),
            ),
            const SizedBox(height: 5),
            Text(
              "Đăng nhập để tiếp tục hành trình của bạn",
              style: Global.subTitle.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 35),

            //Email TextField
            TextFormField(
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập dữ liệu';
                }

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Nhập địa chỉ email phù hợp';
                }

                return null;
              },
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Nhập địa chỉ email',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 25,
                  color: Global.textColorInBackground2,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Global.backgroundTextFormColor,
                filled: true,
              ),
            ),
            const SizedBox(height: 16),

            //Password TextField
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập dữ liệu';
                }

                if (value.length < 6) {
                  return 'Mật khẩu phải có ít nhất 6 kí tự';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu của bạn',
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    size: 25,
                    color: Global.textColorInBackground2,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fillColor: Global.backgroundTextFormColor,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
            ),
            const SizedBox(height: 16),

            //Accept Terms and Conditions
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Quên mật khẩu?",
                    style: Global.normalText,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            //Button Login
            ButtonLoginOrSignUp(
                textButton: "Đăng nhập",
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    /// navigate to home screen
                  }
                }),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hoặc tiếp tục với",
                  style: Global.normalText,
                ),
              ],
            ),
            const SizedBox(height: 16),
            //Sign Up by Third Party
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThirdPartyButton(
                    pathLogo: "lib/assets/icons/google_icon.png",
                    onPressed: () {}),
                const SizedBox(width: 20),
                ThirdPartyButton(
                    pathLogo: "lib/assets/icons/facebook_icon.png",
                    onPressed: () {}),
              ],
            ),
            const SizedBox(height: 30),

            //Return sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Chưa có Tài khoản?", style: Global.subTitle),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onChangeToSignUp,
                  child: Text(
                    "ĐĂNG KÝ",
                    style: Global.subTitle.copyWith(
                      color: Global.buttonYesColor1,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


