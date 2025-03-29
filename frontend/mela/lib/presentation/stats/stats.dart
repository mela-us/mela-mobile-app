import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';

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

class _StatisticsScreenState extends State<StatisticsScreen> with SingleTickerProviderStateMixin {
  final StatisticsStore _store = getIt<StatisticsStore>();
  List<String> levelNames = [];
  late TabController _tabController;
  bool _isLoadingLevels = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _store.getLevels();
    if (_store.success && _store.levelList != null) {
      final nameList = _store.levelList?.levelList ?? [];
      levelNames.clear();
      for (var level in nameList) {
        levelNames.add(level.levelName);
      }
      if (levelNames.isNotEmpty) {
        _tabController = TabController(length: levelNames.length, vsync: this);
        _tabController.addListener(_onTabChanged);
        await _loadData(levelNames[0]);
      }
      setState(() {
        _isLoadingLevels = false;
      });
    }
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    _loadData(levelNames[_tabController.index]);
  }

  Future<void> _loadData(String levelName) async {
    await _store.getProgressList(levelName);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingLevels) {
      return const Scaffold(
        body: Center(child: RotatingImageIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text("Thống kê",
              style: Theme.of(context)
                  .textTheme
                  .heading
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.searchStats);
            },
            icon: const Icon(Icons.search),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: levelNames.length > 3,
          labelColor: Theme.of(context).colorScheme.tertiary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
          dividerColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
              width: 2,
            ),
          ),
          tabs: levelNames.map((levelName) => Tab(text: levelName)).toList(),
        ),
      ),
      body: Observer(
        builder: (context) {
          if (_store.progressLoading) {
            return const Center(child: RotatingImageIndicator());
          }
          if (!_store.success) {
            return Center(
              child: Text(
                "Đã có lỗi xảy ra. Vui lòng thử lại",
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.textInBg1),
              ),
            );
          }

          final list = _store.progressList?.progressList ?? [];
          if (list.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Oops! Bạn chưa làm bài tập gì cả! Vui lòng chuyển sang \"Chủ đề\" để học và làm bài tập!',
                      style: Theme.of(context).textTheme.subTitle
                          .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return ExpandableList(list: list);
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.appBackground,
    );
  }
}