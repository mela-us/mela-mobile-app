import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../constants/app_theme.dart';

class DeleteAccountConfirmationDialog extends StatefulWidget {
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const DeleteAccountConfirmationDialog({
    super.key,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  _DeleteAccountConfirmationDialogState createState() => _DeleteAccountConfirmationDialogState();
}

class _DeleteAccountConfirmationDialogState extends State<DeleteAccountConfirmationDialog> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bạn có chắc chắn muốn xóa tài khoản và toàn bộ quá trình học tập của bạn? Chức năng này sẽ không thể thu hồi!',
              style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.black),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                  // Tùy chỉnh màu sắc cho checkbox
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  checkColor: Colors.white,
                ),
                Expanded(
                  child: Text(
                    'Tôi đã hiểu và muốn xóa tài khoản',
                    style: Theme.of(context).textTheme.subTitle.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: _isChecked ? widget.onDelete : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Đổi màu nút thành đỏ
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      'Xóa tài khoản',
                      style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white), // Set border color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      'Hủy',
                      style: Theme.of(context).textTheme.subHeading.copyWith(color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 1, end: 0);
  }
}