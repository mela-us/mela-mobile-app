import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import '../../../themes/default/colors_standards.dart';

class CoverImageWidget extends StatelessWidget {
  const CoverImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Layer 0:
        Container(
          width: 384,
          height: 290,
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
                width: 384,
                height: 257,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        // Layer 2: Button "Học toán hàng ngày với Mela"
        Positioned(
          bottom: 10,
          child: SizedBox(
            width: 250,
            height: 34,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsStandards.buttonYesColor1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                'Học toán hàng ngày với Mela',
                style: Theme.of(context)
                    .textTheme
                    .content
                    .copyWith(color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
