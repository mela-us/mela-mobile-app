import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/stats/store/stat_filter_store.dart';
import 'package:mela/presentation/stats/store/stat_search_store.dart';

import 'widgets/checkbox_row.dart';
import 'widgets/filter_button.dart';

class FilterStatScreen extends StatefulWidget {
  @override
  _FilterStatScreenState createState() => _FilterStatScreenState();
}

class _FilterStatScreenState extends State<FilterStatScreen> {
  final StatFilterStore _filterStore = getIt<StatFilterStore>();
  final StatSearchStore _searchStore = getIt<StatSearchStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void filterLectures() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (!_filterStore.isFilterButtonPressed) {
                _filterStore.resetFilter();
              }
              Navigator.pop(context);
            }),
        title: Text("Lọc và sắp xếp",
            style: Theme.of(context)
                .textTheme
                .heading
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        actions: [
          TextButton(
            onPressed: () {
              _filterStore.resetFilter();
              _searchStore.setIsFiltered(false);
              _filterStore.setIsFilteredButtonPressed(false);
            },
            child: Text("Đặt lại",
                style: Theme.of(context)
                    .textTheme
                    .content
                    .copyWith(color: Theme.of(context).colorScheme.secondary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Sắp xếp
              Text("Sắp xếp mức độ hoàn thành",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
              CheckboxRow(
                  label: "Tăng dần",
                  isSelected: _filterStore.isAscendingSelected,
                  onToggle: _filterStore.toggleAscending),
              CheckboxRow(
                  label: "Giảm dần",
                  isSelected: _filterStore.isDescendingSelected,
                  onToggle: _filterStore.toggleDescending),
              const SizedBox(height: 16),
              //Tiến trình
              Text("Tiến trình",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
              CheckboxRow(
                  label: "Đang học",
                  isSelected: _filterStore.isInProgressSelected,
                  onToggle: _filterStore.toggleInProgress),
              CheckboxRow(
                  label: "Đã hoàn thành",
                  isSelected: _filterStore.isCompletedSelected,
                  onToggle: _filterStore.toggleCompleted),
              const SizedBox(height: 16),
              //Button Áp dụng
              FilterButton(
                textButton: "Áp dụng",
                onPressed: () {
                  _filterStore.setIsFilteredButtonPressed(true);
                  _searchStore.setIsFiltered(true);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

