import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/presentation/detailed_stats_and_comments/detailed_stats_and_comments.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/home_screen/widgets/level_item.dart';
import 'package:mela/presentation/tutor/stores/tutor_store.dart';
import 'package:mela/presentation/tutor/widgets/grade_items.dart';
import 'package:mobx/mobx.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  _TutorScreenState createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  bool _isGradeSelected = false;

  TutorStore _tutorStore = getIt<TutorStore>();
  @override
  void initState() {
    super.initState();
    if (_tutorStore.levelList == null &&
        _tutorStore.fetchLevelsFuture.status != FutureStatus.pending) {
      _tutorStore.getLevels();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gia sư AI',
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.textInBg1),
        ),
      ),
      body: !_isGradeSelected ? _buildGradeSelection() : _buildInitialScreen(),
    );
  }

  Widget _buildGradeSelection() {
    return Observer(builder: (BuildContext context) {
      return _tutorStore.loading
          ? const Center(child: CircularProgressIndicator())
          : _tutorStore.levelList == null
              ? const Center(
                  child: Text('Không có lớp nào'),
                )
              : Padding(
                  padding: const EdgeInsets.all(Dimens.horizontal_padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Chọn lớp học',
                        style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context).colorScheme.textInBg1),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Chọn lớp học mà bạn muốn gia sư AI giúp đỡ.',
                        style: Theme.of(context).textTheme.content.copyWith(
                            color: Theme.of(context).colorScheme.textInBg2),
                      ),
                      const SizedBox(height: 20),
                      Expanded(child: _buildGridView()),
                    ],
                  ),
                );
    });
  }

  Widget _buildInitialScreen() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide.none,
              ),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              indicatorColor: Theme.of(context).colorScheme.tertiary,
              labelColor: Theme.of(context).colorScheme.tertiary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
              tabs: const [
                Tab(
                  text: 'Tổng quan',
                ),
                Tab(text: 'Luyện tập'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Overview Tab
                Padding(
                  padding: const EdgeInsets.all(Dimens.horizontal_padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thông tin lớp học',
                        style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context).colorScheme.textInBg1),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Khối lớp của bạn: Lớp 5',
                        style: Theme.of(context).textTheme.content.copyWith(
                            color: Theme.of(context).colorScheme.textInBg2),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Biểu đồ dữ liệu',
                        style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context).colorScheme.textInBg1),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                            color: Theme.of(context).colorScheme.appBackground,
                            // child: Center(
                            //   child: Text(
                            //     'Biểu đồ sẽ hiển thị ở đây',
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .content
                            //         .copyWith(
                            //             color: Theme.of(context)
                            //                 .colorScheme
                            //                 .textInBg2),
                            //   ),
                            // ),
                            child: const DetailedStatsAndCommentsScreen(
                              name: "Tên học sinh",
                              imageUrl: "",
                            )),
                      ),
                    ],
                  ),
                ),
                // Practice Tab
                Padding(
                  padding: const EdgeInsets.all(Dimens.horizontal_padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Danh sách bài tập',
                        style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context).colorScheme.textInBg1),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Các bài tập được cho là phù hợp để cải thiện kỹ năng giải toán của bạn.',
                        style: Theme.of(context).textTheme.content.copyWith(
                            color: Theme.of(context).colorScheme.textInBg2),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5, // Replace with actual exercise count
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(
                                  'Bài tập ${index + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .content
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .textInBg1),
                                ),
                                subtitle: Text(
                                  'Mô tả bài tập ${index + 1}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .content
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .textInBg2),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  color:
                                      Theme.of(context).colorScheme.textInBg2,
                                ),
                                onTap: () {
                                  // Handle exercise selection
                                  print('Selected exercise ${index + 1}');
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 0,
        childAspectRatio: 1,
        mainAxisExtent: 80, // set the height of each item
      ),
      itemCount: _tutorStore.levelList!.levelList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            String levelName =
                _tutorStore.levelList!.levelList[index].levelName;
            int levelInt = int.parse(levelName.split(" ")[1]);
            handleGradeSelection(levelInt);
          },
          child: AbsorbPointer(
            child: LevelItem(
              level: _tutorStore.levelList!.levelList[index],
            ),
          ),
        );
      },
    );
  }

  void handleGradeSelection(int grade) {
    // Handle the selected grade here
    // For example, navigate to another screen or show a dialog
    print('Selected grade: $grade');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Chọn lớp thành công',
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Theme.of(context).colorScheme.textInBg1),
          ),
          content: Text(
              'Bạn đã chọn lớp $grade. Đừng lo lắng, bạn luôn có thể thay đổi lớp học trong phần "Cá nhân".',
              style: Theme.of(context)
                  .textTheme
                  .content
                  .copyWith(color: Theme.of(context).colorScheme.textInBg2)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Bài kiểm tra đầu vào',
                        style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context).colorScheme.textInBg1),
                      ),
                      content: Text(
                          'Mela chuẩn bị cho bạn một bài kiểm tra đầu vào nhằm thu thập dữ liệu. Tiến hành nhé?',
                          style: Theme.of(context).textTheme.content.copyWith(
                              color: Theme.of(context).colorScheme.textInBg2)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            //TODO: CHANGE TO STORE LATER
                            setState(() {
                              _isGradeSelected = true;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Lúc khác',
                            style: Theme.of(context)
                                .textTheme
                                .buttonStyle
                                .copyWith(color: Colors.redAccent),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              //TODO: CHANGE TO STORE LATER
                              _isGradeSelected = true;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Bắt đầu',
                            style: Theme.of(context)
                                .textTheme
                                .buttonStyle
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .buttonYesBgOrText),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.buttonStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}
