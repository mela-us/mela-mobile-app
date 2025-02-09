import 'package:flutter/material.dart';

class SaveChangeButton extends StatelessWidget {
  final String textButton;
  final Future<void> Function()? onPressed;
  const SaveChangeButton(
      {super.key, required this.textButton, required this.onPressed, required Color backgroundColor});

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
          ],
        ),
      ),
    );
  }
}
