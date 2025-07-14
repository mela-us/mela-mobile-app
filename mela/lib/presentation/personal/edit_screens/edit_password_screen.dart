import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

import '../../../themes/default/colors_standards.dart';
import '../widgets/dialogs/back_dialog.dart';
import '../widgets/ui_items/save_change_button.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordController.addListener(_validateInput);
    _confirmPasswordController.addListener(_validateInput);
  }

  void _validateInput() {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final isValidPassword = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$').hasMatch(password);
    final isMatch = password == confirmPassword;

    setState(() {
      isValid = isValidPassword && isMatch;
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validateInput);
    _confirmPasswordController.removeListener(_validateInput);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStandards.AppBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsStandards.AppBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _showLogoutConfirmationDialog(context);
          },
        ),
        title: Text(
          "Sửa mật khẩu",
          style: Theme.of(context)
              .textTheme
              .subHeading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Khoảng cách từ đầu màn hình
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Theme.of(context).colorScheme.onTertiary,
                filled: true,
                hintText: 'Nhập mật khẩu mới', // Gợi ý cho ô nhập mật khẩu
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
              obscureText: true, // Ẩn mật khẩu
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Theme.of(context).colorScheme.onTertiary,
                filled: true,
                hintText: 'Xác nhận mật khẩu', // Gợi ý cho ô nhập xác nhận mật khẩu
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
              obscureText: true, // Ẩn mật khẩu
            ),
            const SizedBox(height: 10),
            SaveChangeButton(
              textButton: "Lưu",
              onPressed: isValid ? () async {
                //TODO: onPressed handling for saving password
              } : null,
              backgroundColor: isValid ? Theme.of(context).colorScheme.primary : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackDialog(
          onConfirm: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}