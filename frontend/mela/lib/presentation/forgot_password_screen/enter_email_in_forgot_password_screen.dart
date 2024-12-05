import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/progress_indicator_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/forgot_password_screen/store/enter_email_store/enter_email_store.dart';
import 'package:mela/presentation/forgot_password_screen/widgets/button_in_forgot.dart';
import 'package:mela/utils/routes/routes.dart';

class EnterEmailInForgotPasswordScreen extends StatelessWidget {
  EnterEmailInForgotPasswordScreen({super.key});
  //controllers:-----------------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            //Main Content
            Form(
              key: _formKey,
              child: Padding(
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
                    const SizedBox(height: 60),
                    ButtonInForgot(
                        textButton: "Tiếp tục",
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
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
                                SnackBar(content: Text('Loi: ${e.toString()}')),
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
