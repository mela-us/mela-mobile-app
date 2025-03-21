import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/core/services/google_sign_in_service.dart';
import 'package:mela/presentation/signup_login_screen/store/login_or_signup_store/login_or_signup_store.dart';
import 'package:mela/presentation/signup_login_screen/store/user_login_store/user_login_store.dart';
import 'package:mela/presentation/signup_login_screen/widgets/third_party_login_widget.dart';
import 'package:mela/utils/check_inputs/check_input.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';

import '../../core/widgets/image_progress_indicator.dart';
import '../../di/service_locator.dart';
import 'store/user_signup_store/user_signup_store.dart';
import 'widgets/login_or_sign_up_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Added Center widget here
        child: SingleChildScrollView(
          physics: MediaQuery.of(context).viewInsets.bottom > 0
              ? const ClampingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: const _FormContent(),
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
  final UserLoginStore _userLoginStore = getIt<UserLoginStore>();
  final LoginOrSignupStore _loginOrSignupStore = getIt<LoginOrSignupStore>();

  //controllers:-----------------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  //disposers:-----------------------------------------------------------------
  late final ReactionDisposer _signupReactionDisposer;
  @override
  void initState() {
    super.initState();
    _signupReactionDisposer = reaction(
        (_) => _userSignupStore.isSignupSuccessful, (bool success) async {
      if (success) {
        // _loginOrSignupStore.toggleChangeScreen();
      }
    });
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _signupReactionDisposer();
    _emailController.dispose();
    _passwordController.dispose();
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
            _buildMainContentInSignupScreen(),
            Observer(
              builder: (context) {
                return Visibility(
                  visible: _userSignupStore.isSignupLoading ||
                      _userLoginStore.isLoadingLogin,
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
                        const RotatingImageIndicator(),
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
          Text('Tạo tài khoản để bắt đầu học tập với Mela',
              style: Theme.of(context)
                  .textTheme
                  .subTitle
                  .copyWith(color: Theme.of(context).colorScheme.secondary)),
          const SizedBox(height: 35),

          //Email TextField
          Observer(
            builder: (context) => TextFormField(
              onChanged: (value) => _userSignupStore.setEmail(value),
              controller: _emailController,
              focusNode: _emailFocus,
              validator: (value) {
                return CheckInput.validateEmail(value);
              },
              decoration: InputDecoration(
                hintText: 'Nhập địa chỉ email',
                hintStyle: Theme.of(context).textTheme.subHeading.copyWith(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
                prefixIcon: const Icon(Icons.email_outlined, size: 25),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Theme.of(context).colorScheme.onTertiary,
                filled: true,
                errorText: _userSignupStore.emailError.isNotEmpty
                    ? _userSignupStore.emailError
                    : null,
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          //Password TextField
          Observer(builder: (context) {
            return TextFormField(
              onChanged: (value) => _userSignupStore.setPassword(value),
              controller: _passwordController,
              focusNode: _passwordFocus,
              validator: (value) {
                return CheckInput.validatePassword(value);
              },
              obscureText: !_userSignupStore.isPasswordVisible,
              decoration: InputDecoration(
                hintText: 'Nhập mật khẩu của bạn',
                hintStyle: Theme.of(context).textTheme.subHeading.copyWith(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
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
                errorText: _userSignupStore.passwordError.isNotEmpty
                    ? _userSignupStore.passwordError
                    : null,
                errorMaxLines: 10,
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  overflow: TextOverflow.visible,
                ),
              ),
            );
          }),
          const SizedBox(height: 12),

          //Accept Terms and Conditions
          Observer(
            builder: (context) => GestureDetector(
              onTap: () {
                _userSignupStore.toggleAccepted();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: Colors.transparent,
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
          ),
          const SizedBox(height: 30),

          //Button Signup
          ButtonLoginOrSignUp(
              textButton: "Đăng ký",
              onPressed: () async {
                _userSignupStore.setPassword(_passwordController.text);
                _userSignupStore.setEmail(_emailController.text);

                _emailFocus.unfocus();
                _passwordFocus.unfocus();

                if (!_userSignupStore.isAccepted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Vui lòng chấp nhận điều khoản và điều kiện'),
                      duration: Duration(seconds: 0, milliseconds: 800),
                    ),
                  );
                  return;
                }

                if (_userSignupStore.emailError.isEmpty &&
                    _userSignupStore.passwordError.isEmpty) {
                  try {
                    _userSignupStore.setIsSignupLoading(true);

                    // First signup
                    await _userSignupStore.signUp(
                      _emailController.text,
                      _passwordController.text,
                    );

                    // Then login
                    await _userLoginStore.login(
                      _emailController.text,
                      _passwordController.text,
                    );

                    // Clean up
                    _userSignupStore.resetSettingForSignnup();
                    _emailController.clear();
                    _passwordController.clear();

                    // Add delay for smooth transition
                    await Future.delayed(const Duration(milliseconds: 300));

                    if (mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.allScreens, (Route<dynamic> route) => false);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đăng ký thành công'),
                          duration: Duration(seconds: 0, milliseconds: 800),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        duration: const Duration(seconds: 0, milliseconds: 800),
                      ),
                    );
                  } finally {
                    _userSignupStore.setIsSignupLoading(false);
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("Hoặc tiếp tục với",
          //         style: Theme.of(context).textTheme.normal.copyWith(
          //             color: Theme.of(context).colorScheme.secondary)),
          //   ],
          // ),
          // const SizedBox(height: 16),
          // //Sign Up by Third Party
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ThirdPartyButton(pathLogo: Assets.googleIcon, onPressed: () {}),
          //     const SizedBox(width: 20),
          //     ThirdPartyButton(
          //         pathLogo: Assets.facebookIcon, onPressed: () {}),
          //   ],
          // ),
          ThirdPartyLoginWidget(
              pathLogo: Assets.googleIcon,
              onPressed: () async {
                final googleSignInService = GoogleSignInService();
                try {
                  final googleLoginRequest =
                      await googleSignInService.handleSignIn();
                  if (googleLoginRequest?.idToken == null ||
                      googleLoginRequest?.accessToken == null) {
                    return;
                  }
                  _userLoginStore.setLoadingLogin(true);
                  await _userLoginStore.loginWithGoogle(
                      googleLoginRequest?.idToken,
                      googleLoginRequest?.accessToken);

                  if (_userLoginStore.isLoggedIn) {
                    // Clean up after successful login
                    _userLoginStore.resetSettingForLogin();
                    _emailController.clear();
                    _passwordController.clear();

                    // Add a small delay before navigation
                    await Future.delayed(const Duration(milliseconds: 300));

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Đăng nhập thành công với Google"),
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //   Routes.allScreens,
                      //   (Route<dynamic> route) => false,
                      // );
                    }
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      duration: const Duration(milliseconds: 800),
                    ),
                  );
                } finally {
                  _userLoginStore.setLoadingLogin(false);
                }
              },
              title: "Đăng nhập với Google"),
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
                  print("Tapped in signup screen");
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
    );
  }
}
