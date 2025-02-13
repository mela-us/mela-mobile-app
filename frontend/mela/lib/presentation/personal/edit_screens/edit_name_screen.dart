import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/personal/store/personal_store.dart';
import 'package:mela/utils/routes/routes.dart';

import '../../../themes/default/colors_standards.dart';
import '../personal_info.dart';
import '../widgets/back_dialog.dart';
import '../widgets/save_change_button.dart';

class EditNameScreen extends StatefulWidget {
  final String name;
  final String email;
  final String dob;
  final String? imageUrl;


  const EditNameScreen({super.key, required this.name, required this.email, required this.dob, this.imageUrl});

  @override
  _EditNameScreenState createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  late TextEditingController _controller;
  final PersonalStore _personalStore = getIt<PersonalStore>();
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.name);
    _controller.addListener(_validateInput);
  }

  void _validateInput() {
    final value = _controller.text.trim();
    final isValidName = value.isNotEmpty && value.length <= 50 && RegExp(r'^[a-zA-ZÀ-Ỹà-ỹ0-9\s]+$').hasMatch(value);
    final isChanged = value != widget.name;

    setState(() {
      isValid = isValidName && isChanged;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_validateInput);
    _controller.dispose();
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
            _showBackConfirmationDialog(context, _controller.text.trim());
          },
        ),
        title: Text(
          "Tên người dùng",
          style: Theme.of(context)
              .textTheme
              .subHeading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Thay đổi để bắt đầu từ trên cùng
          children: [
            const SizedBox(height: 20), // Khoảng cách từ đầu màn hình
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
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
            const SizedBox(height: 10),
            SaveChangeButton(
              textButton: "Lưu",
              onPressed: isValid ? () async {
                try {
                  await _personalStore.updateName(_controller.text);
                  await _personalStore.getUserInfo();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PersonalInfo(
                        name: _controller.text,
                        email: widget.email,
                        dob: widget.dob,
                        imageUrl: widget.imageUrl,
                      ),
                    ),
                  );
                } catch (e) {
                  if (e is DioException) {
                    if (e.response?.statusCode == 401) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.loginScreen, (route) => false
                      );
                    }
                  }
                  print(e.toString());
                }
              } : null,
              backgroundColor: isValid ? Theme.of(context).colorScheme.primary : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _showBackConfirmationDialog(BuildContext context, String input) {
    if (input == widget.name) {
      Navigator.of(context).pop();
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackDialog(
          onConfirm: () async{
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            //pop twice until back to personal info
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}