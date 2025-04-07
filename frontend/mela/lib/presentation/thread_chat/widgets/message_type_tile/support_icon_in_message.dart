import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mela/constants/assets.dart';

class SupportIconInMessage extends StatelessWidget {
  const SupportIconInMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...[
          SvgPicture.asset(
            Assets.like,
            width: 20,
          ),
          const SizedBox(width: 5),
          SvgPicture.asset(
            Assets.unlike,
            width: 20,
          ),
          const SizedBox(width: 5),
          SvgPicture.asset(
            Assets.copy,
            width: 20,
          ),
        ].expand((item) => [item, const SizedBox(width: 5)]).toList(),
      ],
    );
  }
}
