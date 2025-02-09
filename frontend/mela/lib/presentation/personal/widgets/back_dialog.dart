import 'package:flutter/material.dart';
import '../../../constants/app_theme.dart';

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
        padding: const EdgeInsets.all(24.0),
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
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Thoát',
                      style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onCancel,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Hủy',
                      style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}