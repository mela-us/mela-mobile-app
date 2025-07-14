import 'package:flutter/material.dart';

class ThirdPartyLoginWidget extends StatelessWidget {
  final String pathLogo;
  final String title;
  final void Function() onPressed;
  const ThirdPartyLoginWidget(
      {super.key,
      required this.pathLogo,
      required this.onPressed,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.onTertiary,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0,0.2),
              blurRadius: 1,
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              pathLogo, // Replace with your logo path
              width: 25,
              height: 25,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
