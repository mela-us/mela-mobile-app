import 'package:flutter/material.dart';

class ThirdPartyButton extends StatelessWidget {
  final String pathLogo;
  final void Function() onPressed;
  const ThirdPartyButton(
      {super.key, required this.pathLogo, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        child: Center(
          child: Image.asset(
            pathLogo, // Replace with your logo path
            width: 25,
            height: 25,
          ),
        ),
      ),
    );
  }
}
