import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/suggestion/suggestion.dart';
import 'package:mela/presentation/list_proposed_new_lecture/store/list_proposed_new_suggestion_store.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../../core/widgets/icon_widget/empty_icon_widget.dart';
import 'widgets/section_item.dart';

class ListProposedNewLectureScreen extends StatefulWidget {

  final VoidCallback onScrollToHead;

  const ListProposedNewLectureScreen({super.key, required this.onScrollToHead});

  @override
  State<ListProposedNewLectureScreen> createState() =>
      _ListProposedNewLectureScreenState();
}

class _ListProposedNewLectureScreenState
    extends State<ListProposedNewLectureScreen> {
  ListProposedNewSuggestionStore _store =
      getIt<ListProposedNewSuggestionStore>();

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
      if (_store.suggestionList == null) {
        return Center(
          child: Text(
            "Có lỗi xảy ra. Thử lại sau!",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.red),
          ),
        );
      } else if (_store.suggestionList!.suggestions.isEmpty) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EmptyIconWidget(
              mainMessage: "Không có đề xuất cho hôm nay",
              secondaryMessage: "Bạn có thể chọn \"Học tự do\"",
              offset: 10,
            ),
            TextButton(
              onPressed: widget.onScrollToHead,
              child: Text(
                "Học tự do",
                style: Theme.of(context).textTheme.subHeading.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.tertiary,
                  decorationThickness: 1.5,
                ),
              ),
            )
          ],
        );
      }

      List<List<Section>> value =
          _store.suggestionList!.suggestions.map((suggestion) {
        return suggestion.sectionList;
      }).toList();
      List<Section> myListSection =
          value.expand((sectionList) => sectionList).toList();

      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: myListSection.length,
          itemBuilder: (context, index) {
            final section = myListSection[index];
            return SectionItem(
              section: section,
              isLast: index == myListSection.length - 1,
              isFirst: index == 0,
              isPursuing: (index == 0 && !section.isDone) ||
                  (index > 0 &&
                      myListSection[index - 1].isDone &&
                      !section.isDone),
            );
          },
        ),
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
