import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/stats_store.dart';
import 'package:flutter/material.dart';
import 'expandable_item.dart';

class ExpandableList extends StatelessWidget {
  final StatisticsStore store;

  const ExpandableList({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListView.builder(
          itemCount: store.items.length,
          itemBuilder: (context, index) {
            return ExpandableItem(item: store.items[index], store: store, index: index);
          },
        );
      },
    );
  }
}