import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/signup_login_screen/store/login_or_signup_store/login_or_signup_store.dart';
import 'package:mobx/mobx.dart';

import '../../constants/assets.dart';
import '../../core/widgets/progress_indicator_widget.dart';
import '../../di/service_locator.dart';
import 'store/user_signup_store/user_signup_store.dart';
import 'widgets/login_or_sign_up_button.dart';
import 'widgets/third_party_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          // Added Center widget here
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
  final UserSignupStore _userSignupStore = getIt<UserSignupStore>();
  final LoginOrSignupStore _loginOrSignupStore = getIt<LoginOrSignupStore>();

  //controllers:-----------------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //disposers:-----------------------------------------------------------------
  late final ReactionDisposer _signupReactionDisposer;
  @override
  void initState() {
    super.initState();
    _signupReactionDisposer =
        reaction((_) => _userSignupStore.isSignupSuccessful, (bool success) {
      if (success) {
        _loginOrSignupStore.toggleChangeScreen();
        _userSignupStore.resetSettingForSignnup();
      }
    });
  }

  @override
  void dispose() {
    _signupReactionDisposer();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildMainContentInSignupScreen(),
            Observer(
              builder: (context) {
                return Visibility(
                  visible: _userSignupStore.isSignupLoading,
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
        ));
  }

  Widget _buildMainContentInSignupScreen() {
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
            Text('Đăng ký tài khoản',
                style: Theme.of(context)
                    .textTheme
                    .bigTitle
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 5),
            Text('Tạo tài khoản để bắt đầu hành trình học tập với Mela',
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
            Observer(builder: (context) {
              return TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập dữ liệu';
                  }

                  // if (value.length < 6) {
                  //   return 'Mật khẩu ít nhất 6 kí tự';
                  // }
                  return null;
                },
                obscureText: !_userSignupStore.isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Nhập mật khẩu của bạn',
                  prefixIcon: Icon(Icons.lock_outline_rounded,
                      size: 25, color: Theme.of(context).colorScheme.secondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Theme.of(context).colorScheme.onTertiary,
                  filled: true,
                  suffixIcon: IconButton(
                      icon: Icon(_userSignupStore.isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        _userSignupStore.togglePasswordVisibility();
                      }),
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),

            //Accept Terms and Conditions
            Observer(
              builder: (context) => GestureDetector(
                onTap: () {
                  _userSignupStore.toggleAccepted();
                },
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _userSignupStore.isAccepted
                            ? Colors.green
                            : Colors.transparent,
                        border: Border.all(
                          color: _userSignupStore.isAccepted
                              ? Colors.green
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text("Chấp nhận các Điều khoản và Điều kiện",
                          style: Theme.of(context).textTheme.normal.copyWith(
                              color: Theme.of(context).colorScheme.secondary)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            //Button Signup
            ButtonLoginOrSignUp(
                textButton: "Đăng ký",
                onPressed: () async {
                  if (!_userSignupStore.isAccepted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Vui lòng chấp nhận điều khoản và điều kiện'),
                        duration: const Duration(seconds: 1, milliseconds: 500),
                      ),
                    );
                    return;
                  }
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      print("sdsdsdsds");
                      print(_emailController.text);
                      await _userSignupStore.signUp(
                        _emailController.text,
                        _passwordController.text,
                      );
                      _emailController.clear();
                      _passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đăng ký thành công')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                }),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hoặc tiếp tục với",
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
                    pathLogo: Assets.googleIcon, onPressed: () {}),
                const SizedBox(width: 20),
                ThirdPartyButton(
                    pathLogo: Assets.facebookIcon, onPressed: () {}),
              ],
            ),
            const SizedBox(height: 30),

            //Return login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Đã có tài khoản?",
                    style: Theme.of(context).textTheme.subTitle.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () {
                    _loginOrSignupStore.toggleChangeScreen();
                    _userSignupStore.resetSettingForSignnup();
                  },
                  child: Text("ĐĂNG NHẬP",
                      style: Theme.of(context).textTheme.subTitle.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          decoration: TextDecoration.underline)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
