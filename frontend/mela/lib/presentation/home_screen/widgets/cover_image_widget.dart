import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import '../../../themes/default/colors_standards.dart';

class CoverImageWidget extends StatelessWidget {
  final void Function() onPressed;
  const CoverImageWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final containerWidth = screenWidth * 0.85;
    final containerHeight =
        containerWidth * (290 / 384); // Maintain aspect ratio
    final imageHeight = containerWidth * (257 / 384); // Scale image height
    final buttonWidth = containerWidth * (250 / 384); // Scale button width
    final buttonHeight = containerHeight * (34 / 290); // Scale button height

    final fontSize = buttonWidth * (16 / 250);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Layer 0: Container
        Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inverseSurface,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        // Layer 1: Image
        Positioned(
          top: 0,
          child: Column(
            children: [
              Image.asset(
                'assets/images/cover.jpeg',
                width: containerWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        // Layer 2: Button "Học toán hàng ngày với Mela"
        Positioned(
          bottom: containerHeight * (10 / 290),
          child: SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsStandards.buttonYesColor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                'Học toán hàng ngày với Mela',
                style: Theme.of(context).textTheme.content.copyWith(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: fontSize,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
