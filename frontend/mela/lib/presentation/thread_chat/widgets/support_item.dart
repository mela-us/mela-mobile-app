import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

class SupportItem extends StatelessWidget {
  final IconData icon;
  final String textSupport;
  final Function() onTap;
  const SupportItem(
      {super.key,
      required this.icon,
      required this.textSupport,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4,left: 4,bottom: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                textSupport,
                style: Theme.of(context).textTheme.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
