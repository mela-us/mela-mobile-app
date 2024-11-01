import 'package:flutter/material.dart';

import '../../../constants/global.dart';
import '../../../themes/default/colors_standards.dart';

class ThirdPartyButton extends StatelessWidget {
  final String pathLogo;
  void Function() onPressed;
  ThirdPartyButton(
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
          color: ColorsStandards.buttonYesColor2,
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
