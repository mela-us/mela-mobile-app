import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

import '../../../themes/default/colors_standards.dart';
import '../widgets/dialogs/back_dialog.dart';
import '../widgets/ui_items/save_change_button.dart';

class EditEmailScreen extends StatefulWidget {
  final String email;

  const EditEmailScreen({super.key, required this.email});

  @override
  _EditEmailScreenState createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  late TextEditingController _controller;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.email);
    _controller.addListener(_validateInput);
  }

  void _validateInput() {
    final value = _controller.text.trim();
    final isValidEmail = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value);
    final isChanged = value != widget.email;

    setState(() {
      isValid = isValidEmail && isChanged;
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
            _showBackConfirmationDialog(context);
          },
        ),
        title: Text(
          "Email người dùng",
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
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Theme.of(context).colorScheme.onTertiary,
                filled: true,
                hintText: 'Nhập email của bạn', // Thêm gợi ý
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
                //TODO: onPressed handling for saving email
              } : null,
              backgroundColor: isValid ? Theme.of(context).colorScheme.primary : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _showBackConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackDialog(
          onConfirm: () {
            //TODO: edit info logic
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