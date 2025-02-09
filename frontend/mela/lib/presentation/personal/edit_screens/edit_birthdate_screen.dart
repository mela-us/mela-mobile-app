import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

import '../../../themes/default/colors_standards.dart';
import '../widgets/back_dialog.dart';
import '../widgets/save_change_button.dart';

class EditBirthdateScreen extends StatefulWidget {
  final String birthdate; //dd-MM-yyyy

  const EditBirthdateScreen({super.key, required this.birthdate});

  @override
  _EditBirthdateScreenState createState() => _EditBirthdateScreenState();
}

class _EditBirthdateScreenState extends State<EditBirthdateScreen> {
  late TextEditingController _controller;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.birthdate);
    _controller.addListener(_validateInput);
  }

  void _validateInput() {
    final value = _controller.text.trim();
    final isValidDate = RegExp(r'^\d{1,2}-\d{1,2}-\d{4}$').hasMatch(value);
    setState(() {
      isValid = isValidDate;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_validateInput);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('vi', ''), // Đổi ngôn ngữ sang tiếng Việt

      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Theme.of(context).colorScheme.primary,
            colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.tertiary),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            highlightColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Mulish',
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );
    if (picked != null) {
      final formattedDate = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}"; // Định dạng dd-MM-yyyy
      setState(() {
        _controller.text = formattedDate; // Cập nhật chuỗi ngày sinh
        isValid = true; // Đặt isValid thành true khi người dùng chọn một ngày hợp lệ
      });
    }
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
          "Ngày sinh",
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
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context), // Mở hộp thoại chọn ngày
              child: AbsorbPointer(
                child: TextFormField(
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
                    hintText: 'Chọn ngày sinh',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SaveChangeButton(
              textButton: "Lưu",
              onPressed: isValid ? () async {
                String finalBirthdate = _controller.text; // Lưu ngày sinh dưới dạng chuỗi
                //TODO: Xử lý finalBirthdate
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