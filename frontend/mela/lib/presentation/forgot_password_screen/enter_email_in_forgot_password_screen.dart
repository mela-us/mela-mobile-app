import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/progress_indicator_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/forgot_password_screen/store/enter_email_store/enter_email_store.dart';
import 'package:mela/presentation/forgot_password_screen/widgets/button_in_forgot.dart';
import 'package:mela/utils/check_inputs/check_input.dart';
import 'package:mela/utils/routes/routes.dart';

class EnterEmailInForgotPasswordScreen extends StatelessWidget {
  EnterEmailInForgotPasswordScreen({super.key});
  //controllers:-----------------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final EnterEmailStore _enterEmailStore = getIt<EnterEmailStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quên mật khẩu",
              style: Theme.of(context)
                  .textTheme
                  .heading
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
          leading: IconButton(
            onPressed: () {
              _enterEmailStore.reset();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            //Main Content
            Observer(
              builder: (_) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Nhập email của bạn để lấy mã xác thực",
                        style: Theme.of(context).textTheme.subTitle.copyWith(
                            color: Theme.of(context).colorScheme.secondary)),
                    const SizedBox(height: 30),
                    //Email TextField
                    TextFormField(
                      controller: _emailController,
                      onChanged: (value) => _enterEmailStore.setEmail(value),
                      decoration: InputDecoration(
                        hintText: 'Nhập địa chỉ email',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .subHeading
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16),
                        prefixIcon: const Icon(Icons.email_outlined, size: 25),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Theme.of(context).colorScheme.onTertiary,
                        filled: true,
                        errorText: _enterEmailStore.emailError.isNotEmpty
                            ? _enterEmailStore.emailError
                            : null,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    ButtonInForgot(
                        textButton: "Tiếp tục",
                        onPressed: () async {
                          _enterEmailStore.setEmail(_emailController.text);

                          if (_enterEmailStore.emailError.isEmpty) {
                            FocusScope.of(context).unfocus();
                            try {
                              //call to be to get verify email in db or not ?
                              await _enterEmailStore
                                  .verifyEmail(_emailController.text);
                              _emailController.clear();
                              if (context.mounted) {
                                Navigator.of(context).pushNamed(
                                    Routes.enterOTPInForgotPasswordScreen);
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        })
                  ],
                ),
              ),
            ),

            //Loading Screen
            Observer(
              builder: (context) {
                return Visibility(
                  visible: _enterEmailStore.isLoadingVerifyEmail,
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
}
