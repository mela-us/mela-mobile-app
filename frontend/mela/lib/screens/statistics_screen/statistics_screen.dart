import 'package:flutter/material.dart';
import '../../themes/default/colors_standards.dart';
import '../../themes/default/text_styles.dart';
import 'widgets/bar_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>  {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorsStandards.AppBackgroundColor,
          elevation: 0,
          title:
          TextStandard.Heading("Thống kê",
              ColorsStandards.textColorInBackground1),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: ColorsStandards.AppBarContentColor,
              ),
            )
          ],
          bottom: TabBar(
            labelColor: ColorsStandards.buttonYesColor1,
            unselectedLabelColor: ColorsStandards.guideTextColor,
            indicatorColor: ColorsStandards.buttonYesColor1,
            tabs: const [
              Tab(text: "Tiểu học"),
              Tab(text: "Trung học"),
              Tab(text: "Phổ thông"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ExpandableList(),
            ExpandableList(),
            ExpandableList(), //retrieve cho từng cấp
          ],
        ),
        backgroundColor: ColorsStandards.AppBackgroundColor,
      ),
    );
  }
}

class ExpandableList extends StatefulWidget {
  List<Item> items = createItems();
  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return ExpandableItem(item: widget.items[index]);
      },
    );
  }
}

class ExpandableItem extends StatefulWidget {
  final Item item;

  ExpandableItem({super.key, required this.item});

  @override
  _ExpandableItemState createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      color: !_isExpanded ? Colors.white : ColorsStandards.AppBackgroundColor,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextStandard.Normal(
                        '${widget.item.title} ${widget.item.currentProgress}/${widget.item.total}',
                        Colors.black,
                      ),
                      Image.asset(
                          _isExpanded ? 'assets/icons/stats_hide.png' : 'assets/icons/stats_show.png',
                          width: 18,
                          height: 18
                      )
                    ],
                  ),
                  const SizedBox(height: 3), // Khoảng cách giữa title và progress bar
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 1.0),
                    child: LinearProgressIndicator(
                      minHeight: 12,
                      value: widget.item.currentProgress * 1.0 / widget.item.total,
                      color: ColorsStandards.buttonYesColor1,
                      backgroundColor: ColorsStandards.guideTextColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                TextStandard.Title('Số chuyên đề đã học', ColorsStandards.textColorInBackground2),
                SizedBox(height: 8),
                BarChartWidget(),
                SizedBox(height: 8),
              ]
            ),
          ),
        ],
      ),
    );
  }
}

List<Item> createItems() {
  return [
    Item(title: 'Số học', content: 'Nội dung số học', currentProgress: 3, total: 10),
    Item(title: 'Đại số', content: 'Nội dung đại số', currentProgress: 3, total: 10),
    Item(title: 'Hình học', content: 'Nội dung hình học', currentProgress: 2, total: 10),
    Item(title: 'Lý thuyết số', content: 'Nội dung lý thuyết số', currentProgress: 1, total: 10),
    Item(title: 'Xác suất thống kê', content: 'Nội dung xác suất thống kê', currentProgress: 7, total: 10),
    Item(title: 'Vị phần', content: 'Nội dung vị phần', currentProgress: 4, total: 10),
    Item(title: 'Dãy số', content: 'Nội dung dãy số', currentProgress: 20, total: 30),
  ];
}

class Item {
  final String title;
  final String content;
  final int currentProgress;
  final int total;

  Item({
    required this.title,
    required this.content,
    required this.currentProgress,
    required this.total,
  });
}