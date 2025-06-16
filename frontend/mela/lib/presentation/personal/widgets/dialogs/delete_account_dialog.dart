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
  _DeleteAccountConfirmationDialogState createState() =>
      _DeleteAccountConfirmationDialogState();
}

class _DeleteAccountConfirmationDialogState
    extends State<DeleteAccountConfirmationDialog> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            width: double.infinity,
            child: Text(
              'Xóa tài khoản',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Text(
              'Bạn có chắc chắn muốn xóa tài khoản và toàn bộ quá trình học tập của bạn? Chức năng này sẽ không thể thu hồi!',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          // Text(
          //   'Bạn có chắc chắn muốn xóa tài khoản và toàn bộ quá trình học tập của bạn? Chức năng này sẽ không thể thu hồi!',
          //   style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.black),
          // ),
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
                  style: Theme.of(context)
                      .textTheme
                      .subTitle
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onCancel();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Hủy',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _isChecked ? widget.onDelete : null;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Xóa tài khoản',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: [
          //     ElevatedButton(
          //       onPressed: _isChecked ? widget.onDelete : null,
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.red, // Đổi màu nút thành đỏ
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30.0),
          //         ),
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 6.0),
          //         child: Text(
          //           'Xóa tài khoản',
          //           style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.white),
          //         ),
          //       ),
          //     ),
          //     OutlinedButton(
          //       onPressed: widget.onCancel,
          //       style: OutlinedButton.styleFrom(
          //         side: const BorderSide(color: Colors.white), // Set border color
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(30.0),
          //         ),
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 6.0),
          //         child: Text(
          //           'Hủy',
          //           style: Theme.of(context).textTheme.subHeading.copyWith(color: Theme.of(context).colorScheme.tertiary),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 1, end: 0);
  }
}
