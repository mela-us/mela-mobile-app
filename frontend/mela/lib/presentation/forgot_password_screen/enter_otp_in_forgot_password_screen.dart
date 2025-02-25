import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/forgot_password_screen/store/enter_email_store/enter_email_store.dart';
import 'package:mela/presentation/forgot_password_screen/store/enter_otp_store.dart/enter_otp_store.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/progress_indicator_widget.dart';
import 'package:mela/presentation/forgot_password_screen/widgets/button_in_forgot.dart';

class EnterOTPInForgotPasswordScreen extends StatefulWidget {
  const EnterOTPInForgotPasswordScreen({super.key});

  @override
  State<EnterOTPInForgotPasswordScreen> createState() =>
      _EnterOTPInForgotPasswordScreen();
}

class _EnterOTPInForgotPasswordScreen
    extends State<EnterOTPInForgotPasswordScreen> {
  final TextEditingController _otpController = TextEditingController();
  final EnterOTPStore _otpStore = getIt<EnterOTPStore>();
  final EnterEmailStore _enterEmailStore = getIt<EnterEmailStore>();

  @override
  void initState() {
    super.initState();
    _otpStore.startTimer();
  }

  @override
  void dispose() {
    _otpStore.disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Xác thực OTP",
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            _enterEmailStore.email = "";
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Title
                Text(
                  "Mã xác thực đã được gởi đến ${_enterEmailStore.email}",
                  style: Theme.of(context)
                      .textTheme
                      .subTitle
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 30),

                //Pin code field
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 60,
                    fieldWidth: 44,
                    activeFillColor: Theme.of(context).colorScheme.onTertiary,
                    inactiveFillColor: Theme.of(context).colorScheme.onTertiary,
                    selectedFillColor: Theme.of(context).colorScheme.onTertiary,
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    inactiveColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                  ),
                  enableActiveFill: true,
                  onChanged: (value) {
                    if (mounted) {
                      _otpStore.setOTP(value);
                    }
                  },
                  // onCompleted: (value) {},
                ),
                const SizedBox(height: 20),

                //Send OTP again
                Observer(builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Gửi lại mã sau ${_otpStore.timeLeft} giây',
                          style: Theme.of(context).textTheme.subTitle),
                      const SizedBox(width: 2),
                      _otpStore.canResend
                          ? TextButton(
                              onPressed: _otpStore.resendOTP,
                              child: Text('Gửi lại mã',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subTitle
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary)),
                            )
                          : const SizedBox.shrink(),
                    ],
                  );
                }),
                const SizedBox(height: 40),
                ButtonInForgot(
                  textButton: "Xác nhận",
                  onPressed: () async {
                    try {
                      if (_otpStore.otp.length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Vui lòng nhập đủ 6 chữ số')),
                        );
                        return;
                      }
                      await _otpStore.verifyOTP();
                      _otpController.clear();
                      //pop this screen and navigate to create new password screen
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(
                          Routes.createNewPasswordInForgotPasswordScreen);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          //Loading
          Observer(
            builder: (_) => Visibility(
              visible: _otpStore.isLoading,
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
            ),
          ),
        ],
      ),
    );
  }
}
