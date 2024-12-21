import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/stat/progress.dart';
import 'package:flutter/material.dart';
import 'expandable_item.dart';

class ExpandableList extends StatelessWidget {

  final List<Progress>? list;

  const ExpandableList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (list == null || list!.isEmpty) {
          return Center(
            child: Text(
              "Không có dữ liệu",
              style: Theme.of(context).textTheme.subTitle
                  .copyWith(color: Theme.of(context).colorScheme.textInBg1),
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  "Thống kê Số câu đúng / Số câu đã làm",
                  style: Theme.of(context).textTheme.miniCaption
                      .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ExpandableItem(item: list![index]),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}