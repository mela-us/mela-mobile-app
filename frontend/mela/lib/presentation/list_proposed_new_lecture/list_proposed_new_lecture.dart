import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/list_proposed_new_lecture/store/list_proposed_new_lecture_store.dart';
import 'package:mela/presentation/topic_lecture_in_level_screen/widgets/lecture_item.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ListProposedNewLectureScreen extends StatefulWidget {
  ListProposedNewLectureScreen({super.key});

  @override
  State<ListProposedNewLectureScreen> createState() =>
      _ListProposedNewLectureScreenState();
}

class _ListProposedNewLectureScreenState
    extends State<ListProposedNewLectureScreen> {
  ListProposedNewLectureStore _store = getIt<ListProposedNewLectureStore>();

  @override
  void initState() {
    super.initState();
    _store.getProposedNewLecture();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_store.isLoading) {
        return _buildListSkeleton();
      }
      if (_store.lectureList == null) {
        return Center(
          child: Text(
            "Có lỗi xảy ra. Thử lại sau!",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.red),
          ),
        );
      }

      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _store.lectureList!.lectures.length,
        itemBuilder: (context, index) {
          return LectureItem(
            lecture: _store.lectureList!.lectures[index],
          );
        },
      );
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
}
