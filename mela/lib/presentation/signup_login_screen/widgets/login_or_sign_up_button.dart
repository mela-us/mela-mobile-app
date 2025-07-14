import 'package:flutter/material.dart';

class ButtonLoginOrSignUp extends StatelessWidget {
  final String textButton;
  final void Function() onPressed;
  const ButtonLoginOrSignUp(
      {super.key, required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            //Button Text
            Center(
              child: Text(
                textButton,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Asap',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),

            //Button arrow
            // Positioned(
            //   right: 0,
            //   child: Container(
            //     width: 48,
            //     height: 48,
            //     decoration: BoxDecoration(
            //       color: Theme.of(context).colorScheme.onTertiary,
            //       shape: BoxShape.circle,
            //     ),
            //     child: Icon(
            //       Icons.arrow_forward,
            //       color: Theme.of(context).colorScheme.tertiary,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
