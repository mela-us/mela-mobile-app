import 'package:flutter/material.dart';

class CheckboxRow extends StatelessWidget {
  String label;
  bool isSelected;
  Function() onToggle;
  CheckboxRow({super.key, required this.label, required this.isSelected, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: null,
            checkColor: Colors.white,
            activeColor: Colors.blue,
          ),
          Text(label),
        ],
      ),
    );
  }
}