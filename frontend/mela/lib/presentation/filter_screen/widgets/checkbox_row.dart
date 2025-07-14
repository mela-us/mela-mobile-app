import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

class CheckboxRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onToggle;
  const CheckboxRow(
      {super.key,
      required this.label,
      required this.isSelected,
      required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isSelected,
          onChanged: (value) {
            onToggle();
          },
          checkColor: Theme.of(context).colorScheme.onTertiary,
          activeColor: Theme.of(context).colorScheme.tertiary,
        ),
        GestureDetector(
            onTap: onToggle,
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .subTitle
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            )),
      ],
    );
  }
}
