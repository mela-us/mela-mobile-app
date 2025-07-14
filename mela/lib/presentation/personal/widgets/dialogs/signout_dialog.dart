import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onCancel;

  const LogoutConfirmationDialog({
    Key? key,
    required this.onLogout,
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
                  'Đăng xuất',
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
                  'Bạn có chắc là bạn muốn đăng xuất?',
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
                          'Hủy',
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
                          onLogout();
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
                          'Đăng xuất',
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
