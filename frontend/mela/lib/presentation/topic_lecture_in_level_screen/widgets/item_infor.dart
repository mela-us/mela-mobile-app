import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

class ItemInfor extends StatelessWidget {
  String title;
  String content;
  ItemInfor({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(

            children: [
              Image.asset(
                'assets/images/fire.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                textAlign: TextAlign.start,
                title,
                style: Theme.of(context).textTheme.subTitle.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 16),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            textAlign: TextAlign.start,
            content,
            style: Theme.of(context).textTheme.subTitle.copyWith(
                color: Theme.of(context).colorScheme.secondary, fontSize: 14),
          )
        ],
      ),
    );
  }
}
