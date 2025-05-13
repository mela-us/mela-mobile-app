import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/detailed_stats_and_comments/widgets/radar_stat_chart.dart';
import 'package:mela/presentation/detailed_stats_and_comments/widgets/tile_list.dart';

import '../../domain/entity/stat/detailed_stat.dart';

class DetailedStatsAndCommentsScreen extends StatefulWidget {
  final String name;
  final String? imageUrl;

  const DetailedStatsAndCommentsScreen({
    super.key,
    required this.name,
    this.imageUrl,
  });

  @override
  _DetailedStatsAndCommentsScreenState createState() =>
      _DetailedStatsAndCommentsScreenState();
}

class _DetailedStatsAndCommentsScreenState
    extends State<DetailedStatsAndCommentsScreen> {
  late List<DetailedStat> list;
  late String url;

  @override
  Widget build(BuildContext context) {
    url = widget.imageUrl ?? "";
    list = getMock();
    // return Scaffold(
    //   appBar: AppBar(
    //     scrolledUnderElevation: 0,
    //     title: Padding(
    //       padding: const EdgeInsets.only(left: 10),
    //       child: Text("Thống kê",
    //           style: Theme.of(context)
    //               .textTheme
    //               .heading
    //               .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
    //     ),
    //     leading: IconButton(
    //       icon: const Icon(Icons.arrow_back),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //   ),
    //   body:
    //   backgroundColor: Theme.of(context).colorScheme.appBackground,
    // );

    return SingleChildScrollView(
        child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: url.isNotEmpty
                    ? NetworkImage(url)
                    : const AssetImage('assets/icons/default_profile_pic.png')
                        as ImageProvider<Object>,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Observer(
          builder: (context) {
            if (list.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Oops! Hành trình của bạn chưa bắt đầu\nHãy bắt đầu học!',
                        style: Theme.of(context).textTheme.subTitle.copyWith(
                            color: Theme.of(context).colorScheme.textInBg1),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            //return RadarStatChart(stats: list);
            return TileList(list: list);
          },
        ),
      ],
    ));
  }
}

List<DetailedStat> getMock() {
  return [
    DetailedStat(
      topic: 'Đại số',
      comments: '''
Bạn nắm khá tốt các phép biến đổi và giải phương trình.  
- Cần luyện thêm các bài toán thực tế.  
- Có tiềm năng đạt mức khá giỏi nếu duy trì phong độ.
''',
      excellence: 82.5,
    ),
    DetailedStat(
      topic: 'Hình học',
      comments: '''
Khả năng tưởng tượng hình khối còn hạn chế. Cần rèn luyện thêm tư duy không gian.
''',
      excellence: 68.0,
    ),
    DetailedStat(
      topic: 'Xác suất - Thống kê',
      comments: '''
Hiểu các khái niệm cơ bản nhưng áp dụng công thức còn chưa linh hoạt.  
- Nên luyện các bài toán ứng dụng thực tế.  
- Có thể học theo sơ đồ tư duy để dễ ghi nhớ.
''',
      excellence: 57.0,
    ),
    DetailedStat(
      topic: 'Tư duy',
      comments: '''
Nắm chắc đạo hàm và tích phân.  
- Khả năng giải quyết bài toán ở mức độ khá trở lên.  
- Cần luyện thêm bài tích hợp kiến thức để nâng cao.
''',
      excellence: 89.0,
    ),
    DetailedStat(
      topic: 'Số học',
      comments: '''
Cần phải thiện nhiều
''',
      excellence: 40.5,
    ),
  ];
}
