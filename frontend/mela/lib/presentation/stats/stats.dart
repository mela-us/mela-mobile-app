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

class _StatisticsScreenState extends State<StatisticsScreen> {
  //Stores:---------------------------------------------------------------------
  final StatisticsStore _store = getIt<StatisticsStore>();
  //call to navigate to level
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
    // Set cứng danh sách tab bar
    final List<String> levelNames = ["Lớp 1", "Lớp 2", "Lớp 3", "Lớp 4", "Lớp 5"];

    return DefaultTabController(
      length: levelNames.length, // Đặt số lượng tab cứng
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
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
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Align(
              alignment: levelNames.length <= 3
                  ? Alignment.center // Center tabs when few
                  : Alignment.centerLeft, // Default for scrollable
              child: TabBar(
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
                  "Đã xảy ra lỗi",
                  style: Theme.of(context)
                      .textTheme
                      .subTitle
                      .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                ),
              );
            }

            // Lọc danh sách theo `levelName` hoặc trả về danh sách rỗng
            final Map<String, List<Progress>> filteredLists = {
              for (var levelName in levelNames)
                levelName: filterProgressByDivision(levelName),
            };

            return TabBarView(
              children: levelNames.map((levelName) {
                final list = filteredLists[levelName];
                if (list!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Oops! Bạn chưa học gì ở cấp này cả! Vui lòng chuyển sang \'Chủ đề\' để học!',
                            style: Theme.of(context).textTheme.subTitle
                                .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                            textAlign: TextAlign.center,
                          ),
                          // TextButton(
                          //   onPressed: () {
                          //     Navigator.of(context).push(
                          //       MaterialPageRoute(builder: (context) => const HomeScreen()),
                          //     );
                          //   },
                          //   child: Text(
                          //     'chuyển sang \'Chủ đề\' để học!',
                          //     style: Theme.of(context).textTheme.subTitle
                          //         .copyWith(color: Theme.of(context).colorScheme.buttonYesBgOrText),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  );
                } else {
                  return ExpandableList(list: list);
                }
              }).toList(),
            );
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



