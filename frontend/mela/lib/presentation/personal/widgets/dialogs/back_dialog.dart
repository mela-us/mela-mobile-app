import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../constants/app_theme.dart';

class BackDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const BackDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

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
          children: [
            // Căn giữa nội dung văn bản
            Text(
              'Không lưu thay đổi?',
              style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.black),
              textAlign: TextAlign.center, // Căn giữa văn bản
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      'Thoát',
                      style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white), // Set border color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      'Tiếp tục chỉnh sửa',
                      style: Theme.of(context).textTheme.subHeading
                          .copyWith(color: Theme.of(context).colorScheme.tertiary),
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