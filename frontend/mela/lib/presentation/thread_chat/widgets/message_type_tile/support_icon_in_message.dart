import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mela/constants/assets.dart';

class SupportIconInMessage extends StatelessWidget {
  SupportIconInMessage({super.key});

  ValueNotifier<bool?> isLikedNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isLikedNotifier,
        builder: (context, value, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...[
                InkWell(
                  onTap: () {
                    if (value == null) {
                      isLikedNotifier.value = true;
                      return;
                    }
                    if (value == true) {
                      isLikedNotifier.value = null;
                      return;
                    }
                    if (value == false) {
                      isLikedNotifier.value = true;
                      return;
                    }
                  },
                  child: (value != null && value == true)
                      ? SvgPicture.asset(
                          Assets.liked,
                          width: 20,
                        )
                      : SvgPicture.asset(
                          Assets.like,
                          width: 20,
                        ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    if (value == null) {
                      isLikedNotifier.value = false;
                      return;
                    }
                    if (value == true) {
                      isLikedNotifier.value = false;
                      return;
                    }
                    if (value == false) {
                      isLikedNotifier.value = null;
                      return;
                    }
                  },
                  child: (value != null && value == false)
                      ? SvgPicture.asset(
                          Assets.unliked,
                          width: 20,
                        )
                      : SvgPicture.asset(
                          Assets.unlike,
                          width: 20,
                        ),
                ),
                const SizedBox(width: 5),
                SvgPicture.asset(
                  Assets.copy,
                  width: 20,
                ),
              ].expand((item) => [item, const SizedBox(width: 5)]).toList(),
            ],
          );
        });
  }
}
