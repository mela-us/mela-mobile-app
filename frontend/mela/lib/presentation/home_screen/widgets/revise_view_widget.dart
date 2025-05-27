import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/revise/revise_item.dart';
import 'package:mela/presentation/home_screen/store/revise_store/revise_store.dart';
import 'package:mela/presentation/home_screen/widgets/review_item_widget.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ReviseViewWidget extends StatefulWidget {
  ReviseViewWidget({super.key});

  @override
  State<ReviseViewWidget> createState() => _ReviseViewWidgetState();
}

class _ReviseViewWidgetState extends State<ReviseViewWidget> {
  final ReviseStore _reviseStore = getIt<ReviseStore>();

  @override
  void initState() {
    super.initState();
    print("ReviseViewWidget initState");
    try {
      getRevisionData();
    } catch (e) {
      print("Error in ReviseViewWidget initState: $e");
    }
  }

  Future<void> getRevisionData() async {
    await _reviseStore.getRevision();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_reviseStore.loading) {
        return _buildListSkeleton();
      } else {
        return _buildRevisionView();
      }
    });
  }

  Widget _buildListSkeleton() {
    double screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(3, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  child: SkeletonAnimation(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context)
                            .colorScheme
                            .buttonYesBgOrText
                            .withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                //Title and description of the lecture
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonAnimation(
                          child: Container(
                        width: screenWidth,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context)
                              .colorScheme
                              .buttonYesBgOrText
                              .withOpacity(0.1),
                        ),
                      )),
                      const SizedBox(height: 8),
                      // Topic name + level name
                      SkeletonAnimation(
                          child: Container(
                        width: screenWidth * 1 / 2,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context)
                              .colorScheme
                              .buttonYesBgOrText
                              .withOpacity(0.1),
                        ),
                      )),
                      const SizedBox(height: 10),
                      SkeletonAnimation(
                          child: Container(
                        width: screenWidth * 1 / 3,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context)
                              .colorScheme
                              .buttonYesBgOrText
                              .withOpacity(0.1),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoadList() {
    return ListView.builder(
      itemCount: _reviseStore.revisionItemList.length,
      itemBuilder: (context, index) {
        List<ReviseItem> items = _reviseStore.revisionItemList;
        return ReviewItemWidget(
          isFirst: index == 0,
          isLast: index == items.length - 1,
          reviseItem: _reviseStore.revisionItemList[index],
          isPursuing: (index == 0 && !items[0].isDone) ||
              (index != 0 &&
                  !items[index].isDone &&
                  items[index - 1]
                      .isDone), // Check if the lecture is in progress
        );
      },
    );
  }

  Widget _buildRevisionView() {
    return _reviseStore.revisionItemList.isNotEmpty
        ? _buildRoadList()
        : const Center(
            child: Text("Không có bài ôn tập nào"),
          );
  } //comment
}
