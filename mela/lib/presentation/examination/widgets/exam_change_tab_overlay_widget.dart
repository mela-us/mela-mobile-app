import 'package:flutter/material.dart';
import '../../../constants/assets.dart';

class ExamChangeTabOverlayWidget extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ExamChangeTabOverlayWidget({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          width: 390,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
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
                  "Xác nhận thoát?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Image
              _buildImage(),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Text(
                  "Quá trình và điểm số khi làm kiểm tra sẽ không được lưu lại khi bạn thoát.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),

              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onConfirm,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Thoát',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color:
                            Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onCancel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Theme.of(context).colorScheme.tertiary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Tiếp tục',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Image.asset(
        Assets.exit_image,
        width: 160,
        height: 120,
      ),
    );
  }
}
