import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

class ButtonIndividualExercise extends StatelessWidget {
  final Widget leadingIcon;
  final String textButton;
  final void Function() onPressed;
  const ButtonIndividualExercise(
      {super.key,
      required this.leadingIcon,
      required this.textButton,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            //Button arrow
            Positioned(
              left: 12,
              child: leadingIcon,
            ),
            //Button Text
            Center(
              child: Text(
                textButton,
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
