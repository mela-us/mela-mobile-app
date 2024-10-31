import 'package:flutter/material.dart';
import 'package:mela/screens/signup_screen/widgets/login_or_sign_up_button.dart';
import 'package:mela/screens/signup_screen/widgets/third_party_button.dart';

import '../../constants/global.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Center(
          // Added Center widget here
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              child: const _FormContent(),
            ),
          ),
        ),
      ),
      backgroundColor: Global.AppBackgroundColor,
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isAccepted = false;

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
              "Đăng ký tài khoản",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Asap',
                  fontWeight: FontWeight.bold,
                  color: Global.textColorInBackground1),
            ),
            const SizedBox(height: 5),
            Text(
              "Tạo tài khoản để bắt đầu hành trình học tập với Mela",
              style: Global.subTitle.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 35),

            //Email TextField
            TextFormField(
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }

                return null;
              },
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
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
                  return 'Please enter some text';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
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
              onTap: () => setState(() => _isAccepted = !_isAccepted),
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isAccepted ? Colors.green : Colors.transparent,
                      border: Border.all(
                        color: _isAccepted ? Colors.green : Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text('Chấp nhận các Điều khoản và Điều kiện',
                        style: Global.normalText),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            //Button Login
            ButtonLoginOrSignUp(
                textButton: "Đăng ký",
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

            //Return login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text("Đã có Tài khoản?",style: Global.subTitle),
                  SizedBox(width: 4,),
                  Text("ĐĂNG NHẬP",style: Global.subTitle.copyWith(color: Global.buttonYesColor1),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
