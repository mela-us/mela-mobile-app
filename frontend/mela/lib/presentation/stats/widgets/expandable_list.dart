import 'package:flutter_mobx/flutter_mobx.dart';
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
        return Column(
          children: [
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