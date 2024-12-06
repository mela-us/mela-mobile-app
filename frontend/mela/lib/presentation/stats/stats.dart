import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';

import '../../core/stores/error/error_store.dart';
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
  final ErrorStore _errorStore = getIt<ErrorStore>();
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
    return DefaultTabController(
      length: 3,
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
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.tertiary,
            unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary, width: 2),
            ),
            tabs: const [
              Tab(text: "Tiểu học"),
              Tab(text: "Trung học"),
              Tab(text: "Phổ thông"),
            ],
          ),
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
                  style: Theme.of(context).textTheme.subTitle
                      .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                ),
              );
            }
            else {
              return TabBarView(
              children: [
                  ExpandableList(list: filterProgressByDivision("Tiểu học")),
                  ExpandableList(list: filterProgressByDivision("Trung học")),
                  ExpandableList(list: filterProgressByDivision("Phổ thông")),
                ],
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



