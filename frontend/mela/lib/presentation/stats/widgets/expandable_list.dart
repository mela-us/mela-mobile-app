import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/domain/entity/stat/progress.dart';
import '../store/stats_store.dart';
import 'package:flutter/material.dart';
import 'expandable_item.dart';

class ExpandableList extends StatelessWidget {
  final StatisticsStore store;
  final String division;

  const ExpandableList({super.key, required this.store, required this.division});

  @override
  Widget build(BuildContext context) {
    List<Progress>? list = store.progressList?.progressList;
    List<Progress>? filteredList = list?.where((progress) => progress.division == division).toList();
    return Observer(
      builder: (_) {
        return ListView.builder(
          itemCount: filteredList?.length,
          itemBuilder: (context, index) {
            return ExpandableItem(item: filteredList![index], store: store, index: index);
          },
        );
      },
    );
  }
}