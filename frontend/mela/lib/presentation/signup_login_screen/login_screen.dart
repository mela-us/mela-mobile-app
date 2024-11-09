import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/screens/signup_login_screen/widgets/login_or_sign_up_button.dart';
import 'package:mela/screens/signup_login_screen/widgets/third_party_button.dart';

import '../../constants/global.dart';
import '../../core/widgets/progress_indicator_widget.dart';
import '../../themes/default/colors_standards.dart';
import '../../themes/default/text_styles.dart';
import '../../utils/routes/routes.dart';
import 'store/user_login_store.dart';

class LoginScreen extends StatelessWidget {
  void Function() onChangeToSignUp;
  LoginScreen({super.key, required this.onChangeToSignUp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // Added Center widget here
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: _FormContent(onChangeToSignUp: onChangeToSignUp),
          ),
        ),
      ),
      backgroundColor: ColorsStandards.AppBackgroundColor,
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
  //stores:---------------------------------------------------------------------
  final UserLoginStore _userLoginStore = getIt<UserLoginStore>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          buildContentInLoginScreen(),
          Observer(builder: (context) {
            return _userLoginStore.isLoggedIn
                ? navigateToCourseScreen(context)
                : const SizedBox.shrink();
          }),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _userLoginStore.isLoading,
                child: AbsorbPointer(
                  absorbing: true,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Theme.of(context).colorScheme.primary
                            .withOpacity(0.8),
                      ),
                      const CustomProgressIndicatorWidget(),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildContentInLoginScreen() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      constraints: const BoxConstraints(maxWidth: 380),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title and Subtitle
            TextStandard.BigTitle(
                "Đăng nhập", ColorsStandards.textColorInBackground1),
            const SizedBox(height: 5),
            TextStandard.SubTitle("Đăng nhập để tiếp tục hành trình của bạn",
                ColorsStandards.textColorInBackground2),
            const SizedBox(height: 35),

            //Email TextField
            TextFormField(
              controller: _emailController,
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
                labelText: null,
                hintText: 'Nhập địa chỉ email',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 25,
                  color: ColorsStandards.textColorInBackground2,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: ColorsStandards.backgroundTextFormColor,
                focusColor: ColorsStandards.backgroundTextFormColor,
                filled: true,
              ),
            ),
            const SizedBox(height: 16),

            //Password TextField
            Observer(
              builder: (context) {
                return TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập dữ liệu';
                    }

                    if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 kí tự';
                    }
                    return null;
                  },
                  obscureText: !_userLoginStore.isPasswordVisible,
                  decoration: InputDecoration(
                      labelText: null,
                      hintText: 'Nhập mật khẩu của bạn',
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 25,
                        color: ColorsStandards.textColorInBackground2,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: ColorsStandards.backgroundTextFormColor,
                      focusColor: ColorsStandards.backgroundTextFormColor,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(_userLoginStore.isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          _userLoginStore.togglePasswordVisibility();
                        },
                      )),
                );
              },
            ),
            const SizedBox(height: 16),

            //Accept Terms and Conditions
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextStandard.Normal(
                      "Quên mật khẩu?", ColorsStandards.textColorInBackground2),
                ],
              ),
            ),
            SizedBox(height: 30),

            // //Button Login
            ButtonLoginOrSignUp(
                textButton: "Đăng nhập",
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      await _userLoginStore.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Login failed: ${e.toString()}')),
                      );
                    }
                  }
                }),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextStandard.Normal("Hoặc tiếp tục với",
                    ColorsStandards.textColorInBackground2),
              ],
            ),
            const SizedBox(height: 16),
            //Sign Up by Third Party
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThirdPartyButton(
                    pathLogo: "assets/icons/google_icon.png", onPressed: () {}),
                const SizedBox(width: 20),
                ThirdPartyButton(
                    pathLogo: "assets/icons/facebook_icon.png",
                    onPressed: () {}),
              ],
            ),
            const SizedBox(height: 30),

            //Return sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextStandard.SubTitle("Chưa có tài khoản",
                    ColorsStandards.textColorInBackground2),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onChangeToSignUp,
                  child: TextStandard.SubTitle(
                    "ĐĂNG KÝ",
                    ColorsStandards.buttonYesColor1,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget navigateToCourseScreen(BuildContext context) {
    print("FlutterSa: Navigate to course screen");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.coursesScreen, (Route<dynamic> route) => false);
    });
    return Container();
  }
}
