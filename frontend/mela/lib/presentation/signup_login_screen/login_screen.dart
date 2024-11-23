import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets_path.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mobx/mobx.dart';

import '../../core/widgets/progress_indicator_widget.dart';
import '../../utils/routes/routes.dart';
import 'store/login_or_signup_store/login_or_signup_store.dart';
import 'store/user_login_store/user_login_store.dart';
import 'widgets/login_or_sign_up_button.dart';
import 'widgets/third_party_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: _FormContent(),
          ),
        ),
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  //stores:---------------------------------------------------------------------
  final UserLoginStore _userLoginStore = getIt<UserLoginStore>();
  final LoginOrSignupStore _loginOrSignupStore = getIt<LoginOrSignupStore>();

  //controllers:-----------------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //disposers:-----------------------------------------------------------------
  late final ReactionDisposer _loginReactionDisposer;
  @override
  void initState() {
    super.initState();
    // print("---------------------------------------->LoginScreen: ${_userLoginStore.isLoggedIn ? "true" : "false"}");
    _loginReactionDisposer =
        reaction((_) => _userLoginStore.isLoggedIn, (bool success) {
          // print("---------------------------------------->LoginScreen1 ${_userLoginStore.isLoggedIn ? "true" : "false"}");
      if (success) {
        // print("---------------------------------------->LoginScreen2 ${_userLoginStore.isLoggedIn ? "true" : "false"}");
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.coursesScreen, (Route<dynamic> route) => false);
            _userLoginStore.resetSettingForLogin();
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          buildContentInLoginScreen(),
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
                        color: Theme.of(context)
                            .colorScheme
                            .primary
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      constraints: const BoxConstraints(maxWidth: 380),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title and Subtitle
            Text("Đăng nhập",
                style: Theme.of(context)
                    .textTheme
                    .bigTitle
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 5),
            Text("Đăng nhập để tiếp tục hành trình của bạn",
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.secondary)),
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
                hintText: 'Nhập địa chỉ email',
                prefixIcon: const Icon(Icons.email_outlined, size: 25),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Theme.of(context).colorScheme.onTertiary,
                filled: true,
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
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
                    hintText: 'Nhập mật khẩu của bạn',
                    prefixIcon: Icon(Icons.lock_outline_rounded,
                        size: 25,
                        color: Theme.of(context).colorScheme.secondary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Theme.of(context).colorScheme.onTertiary,
                    filled: true,
                    suffixIcon: IconButton(
                      icon: Icon(_userLoginStore.isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          _userLoginStore.togglePasswordVisibility(),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            //Forgot password
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Quên mật khẩu?",
                      style: Theme.of(context).textTheme.normal.copyWith(
                          color: Theme.of(context).colorScheme.secondary)),
                ],
              ),
            ),
            const SizedBox(height: 30),

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
                Text('Hoặc tiếp tục với',
                    style: Theme.of(context).textTheme.normal.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
              ],
            ),
            const SizedBox(height: 16),
            //Sign Up by Third Party
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThirdPartyButton(
                    pathLogo: AssetsPath.googleIcon, onPressed: () {}),
                const SizedBox(width: 20),
                ThirdPartyButton(
                    pathLogo: AssetsPath.facebookIcon, onPressed: () {}),
              ],
            ),
            const SizedBox(height: 30),

            //Return sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Chưa có tài khoản?",
                    style: Theme.of(context).textTheme.subTitle.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () {
                    _loginOrSignupStore.toggleChangeScreen();
                    _userLoginStore.resetSettingForLogin();
                  },
                  child: Text(
                    "ĐĂNG KÝ",
                    style: Theme.of(context).textTheme.subTitle.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        decoration: TextDecoration.underline),
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
