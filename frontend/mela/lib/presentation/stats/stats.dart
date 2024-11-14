import 'package:flutter/material.dart';
import '../../constants/assets.dart';
import '../../constants/app_theme.dart';
import 'widgets/expandable_list.dart';
import 'store/stats_store.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late final StatisticsStore _store;

  @override
  void initState() {
    super.initState();
    _store = StatisticsStore();
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
            style: Theme.of(context).textTheme.heading
                .copyWith(color: Theme.of(context).colorScheme.textInBg1),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: Theme.of(context).colorScheme.appBackground,
              ),
            )
          ],
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.buttonYesBgOrText,
            unselectedLabelColor: Theme.of(context).colorScheme.textInBg1,
            indicatorColor: Theme.of(context).colorScheme.buttonYesBgOrText,
            tabs: const [
              Tab(text: "Tiểu học"),
              Tab(text: "Trung học"),
              Tab(text: "Phổ thông"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ExpandableList(store: _store),
            ExpandableList(store: _store),
            ExpandableList(store: _store),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.appBackground,
      ),
    );
  }
}