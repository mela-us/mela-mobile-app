import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/icon_widget/error_icon_widget.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import '../../core/widgets/icon_widget/empty_icon_widget.dart';
import '../../domain/entity/stat/progress_list.dart';
import 'widgets/expandable_list.dart';

import 'store/stats_store.dart';
import '../../di/service_locator.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> with TickerProviderStateMixin {
  final StatisticsStore _store = getIt<StatisticsStore>();
  List<String> levelNames = ["Lớp 1", "Lớp 2", "Lớp 3", "Lớp 4", "Lớp 5"];
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
      final levels = _store.levelList?.levelList ?? [];
      //
      levelNames.clear();
      for (var level in levels) {
        levelNames.add(level.levelName);
      }
      if (levelNames.isNotEmpty) {
        _tabController = TabController(length: levelNames.length, vsync: this);
        _tabController.addListener(_onTabChanged);
        await _loadData(levels[0].levelId);
      }
      setState(() {
        _isLoadingLevels = false;
      });
    }
  }

  void _onTabChanged() {
    final levels = _store.levelList?.levelList ?? [];
    if (_tabController.indexIsChanging) return;
    _loadData(levels[_tabController.index].levelId);
  }

  Future<void> _loadData(String level) async {
    await _store.getProgressList(level);
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
      return Scaffold(
        body: Center(child: Container()),
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
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pushNamed(Routes.searchStats);
        //     },
        //     icon: const Icon(Icons.search),
        //     color: Theme.of(context).colorScheme.onPrimary,
        //   ),
        // ],
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
          if (_store.progressLoading || _store.levelLoading) {
            return const Center(child: RotatingImageIndicator());
          }
          if (!_store.success && !_store.progressLoading && !_store.levelLoading) {
            return const Center(
              child: ErrorIconWidget(message: "Đã có lỗi xảy ra. Vui lòng thử lại"),
            );
          }

          final list = _store.progressList?.progressList ?? [];
          //final list = getMockStats().progressList ?? [];
          if (list.isEmpty) {
            return const EmptyIconWidget(
              mainMessage: "*Tiếng dế kêu*\nBạn chưa bắt đầu hành trình ở lớp này!",
              secondaryMessage: "Bạn có thể bắt đầu ở Trang chủ.",
              offset: 120,
            );
          }
          return ExpandableList(list: list);
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.appBackground,
    );
  }
}

ProgressList getMockStats() {
  const responseData ={
    "message": "Get statistic successfully!",
    "total": 1,
    "data": [
      {
        "type": "EXCERCISE",
        "latestDate": "2025-03-26T07:56:49.512",
        "topicName": "Hình học",
        "lectureName": "Vị trí và hình khối",
        "exercise": {
          "exerciseName": "Vị trí và hình khối",
          "latestScore": 80,
          "scoreRecords": [
            {
              "date": "2025-03-26T07:52:29.918",
              "score": 80
            },
            {
              "date": "2025-03-26T06:51:43.987",
              "score": 60
            },
            {
              "date": "2025-03-26T06:51:43.987",
              "score": 50
            },
            {
              "date": "2025-03-26T06:51:43.987",
              "score": 70
            },
          ]
        },
        "section": null,
      },
      {
        "type": "SECTION",
        "latestDate": "2025-03-26T07:56:49.512",
        "topicName": "Hình học",
        "lectureName": "Vị trí và hình khối",
        "exercise": null,
        "section": {
          "sectionName": "Vị trí và hình khối",
          "date": "2025-03-26T07:56:49.512"
        }
      },
      {
        "type": "SECTION",
        "latestDate": "2025-03-26T07:56:49.512",
        "topicName": "Số học",
        "lectureName": "Số và phép cộng, trừ trong phạm vi 10",
        "exercise": null,
        "section": {
          "sectionName": "Số và phép cộng, trừ trong phạm vi 10",
          "date": "2025-03-26T07:56:49.512"
        }
      },
      {
        "type": "EXERCISE",
        "latestDate": "2025-03-26T07:52:29.918",
        "topicName": "Hình học",
        "lectureName": "Hình học và đo lường",
        "exercise": {
          "exerciseName": "Hình học và Đo lường",
          "latestScore": 80,
          "scoreRecords": [
            {
              "date": "2025-03-26T07:52:29.918",
              "score": 80
            },
            {
              "date": "2025-03-26T06:51:43.987",
              "score": 90
            },
            {
              "date": "2025-03-26T06:51:43.987",
              "score": 80
            },
            {
              "date": "2025-03-26T06:51:43.987",
              "score": 70
            },
            {
              "date": "2025-03-26T06:51:43.987",
              "score": 60
            },
            {
              "date": "2025-03-26T06:51:43.987",
              "score": 40
            },
            {
              "date": "2025-03-26T06:51:43.987",
              "score": 50
            },
          ]
        },
        "section": null
      },
      {
        "type": "SECTION",
        "latestDate": "2025-03-25T13:47:57.723",
        "topicName": "Hình học",
        "lectureName": "Vị trí và hình khối",
        "exercise": null,
        "section": {
          "sectionName": "Hình khối nâng cao",
          "date": "2025-03-25T13:47:57.723"
        }
      },
    ]
  };
  print("================================MockStats");
  print(responseData);
  return ProgressList.fromJson(responseData);
}