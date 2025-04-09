import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/core/services/google_sign_in_service.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/signup_login_screen/widgets/third_party_button.dart';
import 'package:mela/presentation/signup_login_screen/widgets/third_party_login_widget.dart';
import 'package:mela/utils/check_inputs/check_input.dart';
import 'package:mobx/mobx.dart';

import '../../utils/routes/routes.dart';
import 'store/login_or_signup_store/login_or_signup_store.dart';
import 'store/user_login_store/user_login_store.dart';
import 'widgets/login_or_sign_up_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
  final UserLoginStore _userLoginStore = getIt<UserLoginStore>();
  final LoginOrSignupStore _loginOrSignupStore = getIt<LoginOrSignupStore>();

  //controllers:-----------------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //disposers:-----------------------------------------------------------------
  late final ReactionDisposer _loginReactionDisposer;
  @override
  void initState() {
    super.initState();

    _loginReactionDisposer =
        reaction((_) => _userLoginStore.isLoggedIn, (bool success) {
      print(
          "---------------------------------------->LoginScreen1 ${_userLoginStore.isLoggedIn ? "true" : "false"}");
      if (success) {
        print(
            "---------------------------------------->LoginScreen2 ${_userLoginStore.isLoggedIn ? "true" : "false"}");
      }
    });
    // _errorLoginReactionDisposer = reaction(
    //     (_) => _userLoginStore.errorStore.errorMessage, (String errorMessage) {
    //   if (errorMessage.isNotEmpty) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(SnackBar(content: Text(errorMessage)));
    //   }
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //for logout from another screen when refreshToken is expired
    print("Vao did change dependencies");
    if (!_userLoginStore.isSetLoginLoading) {
      print("}}}}}}}}}}}}}}}}*****}}}}}}}}}}}}}}");
      _userLoginStore.setIsLogin();
    }
  }

  @override
  void dispose() {
    print("++++++++++++=EMail: ${_emailController.text}");
    print("Password: ${_passwordController.text}");
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginReactionDisposer();
    // _errorLoginReactionDisposer();
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
          Observer(builder: (context) {
            return buildContentInLoginScreen();
          }),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _userLoginStore.isLoadingLogin,
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
      ),
    );
  }

  Widget buildContentInLoginScreen() {
    // if (_userLoginStore.isSetLoginLoading) {
    //   return const Center(
    //     child: CustomProgressIndicatorWidget(),
    //   );
    // }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      constraints: const BoxConstraints(maxWidth: 380),
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
            onChanged: (value) => _userLoginStore.setEmail(value),
            controller: _emailController,
            focusNode: _emailFocus,
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
              errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 14,
                overflow: TextOverflow.visible,
              ),
              errorText: _userLoginStore.emailError.isNotEmpty
                  ? _userLoginStore.emailError
                  : null,
            ),
          ),
          const SizedBox(height: 16),

          //Password TextField
          TextFormField(
            onChanged: (value) => _userLoginStore.setPassword(value),
            controller: _passwordController,
            focusNode: _passwordFocus,
            obscureText: !_userLoginStore.isPasswordVisible,
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
                icon: Icon(_userLoginStore.isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () => _userLoginStore.togglePasswordVisibility(),
              ),
              errorText: _userLoginStore.passwordError.isNotEmpty
                  ? _userLoginStore.passwordError
                  : null,
              errorMaxLines: 10,
              errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 14,
                overflow: TextOverflow.visible,
              ),
            ),
          ),

          const SizedBox(height: 12),

          //Forgot password
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(Routes.enterEmailInForgotPasswordScreen);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Quên mật khẩu?",
                      style: Theme.of(context).textTheme.normal.copyWith(
                          color: Theme.of(context).colorScheme.secondary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          // //Button Login
          ButtonLoginOrSignUp(
              textButton: "Đăng nhập",
              onPressed: () async {
                //set to check enter button without data first time
                _userLoginStore.setEmail(_emailController.text);
                _userLoginStore.setPassword(_passwordController.text);
                if (_userLoginStore.emailError.isEmpty &&
                    _userLoginStore.passwordError.isEmpty) {
                  _emailFocus.unfocus();
                  _passwordFocus.unfocus();

                  try {
                    _userLoginStore.setLoadingLogin(true);
                    await _userLoginStore.login(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (_userLoginStore.isLoggedIn) {
                      // Clean up after successful login
                      _userLoginStore.resetSettingForLogin();
                      _emailController.clear();
                      _passwordController.clear();

                      // Add a small delay before navigation
                      await Future.delayed(const Duration(milliseconds: 300));

                      if (mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.allScreens,
                          (Route<dynamic> route) => false,
                        );
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
                }
              }),

          // const SizedBox(height: 16),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text('Hoặc tiếp tục với',
          //         style: Theme.of(context).textTheme.normal.copyWith(
          //             color: Theme.of(context).colorScheme.secondary)),
          //   ],
          // ),
          // const SizedBox(height: 16),
          // //Sign Up by Third Party
          // // Row(
          // //   mainAxisAlignment: MainAxisAlignment.center,
          // //   children: [
          // //     ThirdPartyButton(
          // //         pathLogo: Assets.googleIcon,
          // //         onPressed: () async {
          // //           final googleSignInService = GoogleSignInService();
          // //           await googleSignInService.handleSignIn();
          // //           print("Google Sign In Thanh Cong");
          // //         }),
          // //     const SizedBox(width: 20),
          // //     ThirdPartyButton(pathLogo: Assets.facebookIcon, onPressed: () {}),
          // //   ],
          // // ),
          // ThirdPartyLoginWidget(
          //     pathLogo: Assets.googleIcon,
          //     onPressed: () async {
          //       final googleSignInService = GoogleSignInService();
          //       try {
          //         final googleLoginRequest =
          //             await googleSignInService.handleSignIn();
          //         if (googleLoginRequest?.idToken == null ||
          //             googleLoginRequest?.accessToken == null) {
          //           return;
          //         }
          //         _userLoginStore.setLoadingLogin(true);
          //         await _userLoginStore.loginWithGoogle(
          //             googleLoginRequest?.idToken,
          //             googleLoginRequest?.accessToken);

          //         if (_userLoginStore.isLoggedIn) {
          //           // Clean up after successful login
          //           _userLoginStore.resetSettingForLogin();
          //           _emailController.clear();
          //           _passwordController.clear();

          //           // Add a small delay before navigation
          //           await Future.delayed(const Duration(milliseconds: 300));

          //           if (mounted) {
          //             ScaffoldMessenger.of(context).showSnackBar(
          //               const SnackBar(
          //                 content: Text("Đăng nhập thành công với Google"),
          //                 duration: const Duration(milliseconds: 800),
          //               ),
          //             );
          //             // Navigator.of(context).pushNamedAndRemoveUntil(
          //             //   Routes.allScreens,
          //             //   (Route<dynamic> route) => false,
          //             // );
          //           }
          //         }
          //       } catch (e) {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(
          //             content: Text(e.toString()),
          //             duration: const Duration(milliseconds: 800),
          //           ),
          //         );
          //       } finally {
          //         _userLoginStore.setLoadingLogin(false);
          //       }
          //     },
          //     title: "Đăng nhập với Google"),
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
                  print("Tapped in LoginScreen");
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
    );
  }
}
