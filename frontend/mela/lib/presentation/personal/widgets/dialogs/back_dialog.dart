// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../../../constants/app_theme.dart';
//
// class BackDialog extends StatelessWidget {
//   final VoidCallback onConfirm;
//   final VoidCallback onCancel;
//
//   const BackDialog({
//     super.key,
//     required this.onConfirm,
//     required this.onCancel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 10.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Căn giữa nội dung văn bản
//             Text(
//               'Không lưu thay đổi?',
//               style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.black),
//               textAlign: TextAlign.center, // Căn giữa văn bản
//             ),
//             SizedBox(height: 16.0),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 ElevatedButton(
//                   onPressed: onConfirm,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.tertiary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 6.0),
//                     child: Text(
//                       'Thoát',
//                       style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 OutlinedButton(
//                   onPressed: onCancel,
//                   style: OutlinedButton.styleFrom(
//                     side: const BorderSide(color: Colors.white), // Set border color
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 6.0),
//                     child: Text(
//                       'Tiếp tục chỉnh sửa',
//                       style: Theme.of(context).textTheme.subHeading
//                           .copyWith(color: Theme.of(context).colorScheme.tertiary),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ).animate().fadeIn(duration: 300.ms).slideY(begin: 1, end: 0);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BackDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const BackDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TapRegion(
        onTapOutside: (event) {
          onCancel();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                width: double.infinity,
                child: Text(
                  'Xác nhận thoát',
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
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Text(
                  'Không lưu thay đổi?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              // Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          onCancel();
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
                          'Tiếp tục chỉnh sửa',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                              color:
                              Theme.of(context).colorScheme.tertiary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Theme.of(context).colorScheme.tertiary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Thoát',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                              color:
                              Theme.of(context).colorScheme.onTertiary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 1, end: 0);
  }
}
