import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/core/widgets/progress_indicator_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/forgot_password_screen/store/create_new_password_store/create_new_password_store.dart';
import 'package:mela/presentation/forgot_password_screen/store/enter_otp_store.dart/enter_otp_store.dart';
import 'package:mela/presentation/forgot_password_screen/widgets/button_in_forgot.dart';
import 'package:mela/utils/check_inputs/check_input.dart';
import 'package:mela/utils/routes/routes.dart';

class CreateNewPasswordInForgotPasswordScreen extends StatelessWidget {
  CreateNewPasswordInForgotPasswordScreen({super.key});
  //controllers:-----------------------------------------------------------------
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();
  final EnterOTPStore _enterOTPStore = getIt<EnterOTPStore>();
  final CreateNewPasswordStore _createNewPasswordStore =
      getIt<CreateNewPasswordStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tạo mật khẩu mới",
              style: Theme.of(context)
                  .textTheme
                  .heading
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              _enterOTPStore.tokenResetPasswordFromSever = "";
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            //Main Content
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Hãy nhập mật khẩu mới",
                      style: Theme.of(context).textTheme.subTitle.copyWith(
                          color: Theme.of(context).colorScheme.secondary)),
                  const SizedBox(height: 30),
                  //Password TextField
                  Observer(
                    builder: (context) {
                      return TextFormField(
                        onChanged: (value) =>
                            _createNewPasswordStore.setErrorPassword(value),
                        controller: _passwordController,
                        validator: (value) {
                          return CheckInput.validatePassword(value);
                        },
                        obscureText: !_createNewPasswordStore.isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Nhập mật khẩu của bạn',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .subHeading
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16),
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
                            icon: Icon(_createNewPasswordStore.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => _createNewPasswordStore
                                .togglePasswordVisibility(),
                          ),
                          errorText:
                              _createNewPasswordStore.passwordError.isNotEmpty
                                  ? _createNewPasswordStore.passwordError
                                  : null,
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  //Confirmed Password TextField
                  Observer(
                    builder: (context) {
                      return TextFormField(
                        onChanged: (value) =>
                            _createNewPasswordStore.setErrorConfirmedPassword(
                                _passwordController.text, value),
                        controller: _confirmedPasswordController,
                        validator: (value) {
                          return CheckInput.validatePassword(value);
                        },
                        obscureText:
                            !_createNewPasswordStore.isConfirmedPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Nhập lại mật khẩu của bạn',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .subHeading
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16),
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
                            icon: Icon(_createNewPasswordStore
                                    .isConfirmedPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => _createNewPasswordStore
                                .toggleConfirmedPasswordVisibility(),
                          ),
                          errorText: _createNewPasswordStore
                                  .confirmedPasswordError.isNotEmpty
                              ? _createNewPasswordStore.confirmedPasswordError
                              : null,
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 60),
                  ButtonInForgot(
                      textButton: "Tiếp tục",
                      onPressed: () async {
                        _createNewPasswordStore
                            .setErrorPassword(_passwordController.text);
                        _createNewPasswordStore.setErrorConfirmedPassword(
                            _passwordController.text,
                            _confirmedPasswordController.text);

                        FocusScope.of(context).unfocus();
                        if (_createNewPasswordStore.passwordError.isNotEmpty ||
                            _createNewPasswordStore
                                .confirmedPasswordError.isNotEmpty) {
                          return;
                        }
                        try {
                          await _createNewPasswordStore
                              .changePasswordInForgotPasswordScreen(
                                  _passwordController.text);
                          _confirmedPasswordController.clear();
                          _passwordController.clear();
                          if (context.mounted) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.loginOrSignupScreen,
                                (Route<dynamic> route) => false);
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      })
                ],
              ),
            ),

            //Loading Screen
            Observer(
              builder: (context) {
                return Visibility(
                  visible: _createNewPasswordStore.isLoadingChangePassword,
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
        )));
  }
}
