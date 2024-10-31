import 'package:flutter/material.dart';

import '../../../constants/global.dart';

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
          backgroundColor: Global.buttonYesColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  textButton,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Asap',
                      fontWeight: FontWeight.bold,
                      color: Global.buttonYesColor2),
                ),
              ),
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Global.buttonYesColor2,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Global.buttonYesColor1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
