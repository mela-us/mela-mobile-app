import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';

import '../../domain/entity/stat/progress.dart';
import '../../utils/routes/routes.dart';
import 'widgets/expandable_list.dart';

import 'store/stats_store.dart';
import '../../di/service_locator.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  //Stores:---------------------------------------------------------------------
  final StatisticsStore _store = getIt<StatisticsStore>();
  // final ErrorStore _errorStore = getIt<ErrorStore>();
  //State set:------------------------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _store.getProgressList();
    await _store.getDetailedProgressList();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> levelNames = ["Lớp 1", "Lớp 2", "Lớp 3", "Lớp 4", "Lớp 5"];
    final Map<String, List<Progress>> filteredLists = {
      for (var levelName in levelNames)
        levelName: filterProgressByDivision(levelName),
    };

    // Filter out empty lists
    final List<String> nonEmptyLevels = filteredLists.entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) => entry.key)
        .toList();

    return DefaultTabController(
      length: nonEmptyLevels.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.appBackground,
          elevation: 0,
          title: Text(
            'Thống kê',
            style: Theme.of(context).textTheme.heading.copyWith(
              color: Theme.of(context).colorScheme.textInBg1,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.searchStats);
                },
                icon: const Icon(Icons.search),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          ],
          bottom: nonEmptyLevels.isNotEmpty
              ? PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Align(
              alignment: nonEmptyLevels.length <= 3
                  ? Alignment.center // Center tabs when few
                  : Alignment.centerLeft, // Default for scrollable
              child: TabBar(
                isScrollable: nonEmptyLevels.length > 3,
                labelColor: Theme.of(context).colorScheme.tertiary,
                unselectedLabelColor:
                Theme.of(context).colorScheme.onSecondary,
                dividerColor: Colors.transparent,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 2),
                ),
                tabs: nonEmptyLevels
                    .map((levelName) => Tab(text: levelName))
                    .toList(),
              ),
            ),
          )
              : null,
        ),
        body: Observer(
          builder: (context) {
            if (_store.progressLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (!_store.success) {
              return Center(
                child: Text(
                  "Đã xảy ra lỗi",
                  style: Theme.of(context)
                      .textTheme
                      .subTitle
                      .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                ),
              );
            } else if (nonEmptyLevels.isEmpty) {
              return Center(
                child: Text(
                  "Không có dữ liệu để hiển thị",
                  style: Theme.of(context)
                      .textTheme
                      .subTitle
                      .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                ),
              );
            } else {
              return TabBarView(
                children: nonEmptyLevels
                    .map((levelName) =>
                    ExpandableList(list: filteredLists[levelName]!))
                    .toList(),
              );
            }
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.appBackground,
      ),
    );
  }


  //
  List<Progress> filterProgressByDivision(String levelName) {
    List<Progress>? list = _store.progressList?.progressList;
    return list?.where((progress) => progress.levelName == levelName).toList() ?? [];
  }
}



