import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowcaseCustom extends StatelessWidget {
  final GlobalKey keyWidget;
  final String title;
  final String description;
  final Widget child;
  final bool isHideActionWidget;
  const ShowcaseCustom(
      {super.key,
      required this.keyWidget,
      required this.title,
      required this.description,
      required this.child,
      this.isHideActionWidget = false});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.8;
    return Showcase(
      key: keyWidget,
      title: title,
      description: description,
      child: child,
      overlayColor: Theme.of(context).colorScheme.primary,
      titleTextStyle: Theme.of(context).textTheme.titleSmall!,
      descTextStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      tooltipPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      toolTipMargin: (MediaQuery.of(context).size.width - maxWidth),
      // floatingActionWidget: FloatingActionWidget(child: Icon(Icons.add)),
      tooltipActions: [
        TooltipActionButton(
            type: TooltipDefaultActionType.previous,
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 4,
            ),
            textStyle: Theme.of(context).textTheme.normal.copyWith(
                  color: isHideActionWidget
                      ? Colors.transparent
                      : Colors.blue[300],
                ),
            name: "Trước",
            onTap: isHideActionWidget
                ? null
                : () {
                    ShowCaseWidget.of(context).previous();
                  }),
        TooltipActionButton(
          type: TooltipDefaultActionType.next,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 4,
          ),
          textStyle: Theme.of(context).textTheme.normal.copyWith(
                color: Colors.blue[300],
              ),
          name: 'Tiếp theo',
        ),
      ],
    );
  }
}
