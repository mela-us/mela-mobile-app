import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/stat/progress.dart';
import '../store/stats_store.dart';
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

        return ListView.builder(
          itemCount: list!.length,
          itemBuilder: (context, index) {
            return ExpandableItem(item: list![index]);
          },
        );
      },
    );
  }
}