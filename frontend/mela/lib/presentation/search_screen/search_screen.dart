import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/core/widgets/progress_indicator_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/filter_screen/store/filter_store.dart';
import 'package:mela/presentation/lectures_in_topic_screen/widgets/lecture_item.dart';
import 'package:mela/presentation/search_screen/widgets/search_bar.dart';

import 'store/search_store.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchStore _searchStore = getIt<SearchStore>();
  FilterStore _filterStore = getIt<FilterStore>();
  final GlobalKey<SearchingBarState> searchBarKey =
      GlobalKey<SearchingBarState>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_searchStore.isLoadingHistorySearch) {
      _searchStore.getHistorySearchList();
    }
  }

  void handleHistoryItemClick(String searchText) {
    // Update the search bar text
    if (searchBarKey.currentState == null) {
      print("searchBarKey.currentState is null");
      return;
    }
    print("searchBarKey.currentState is not null");
    searchBarKey.currentState?.controller.text = searchText;
    // Perform the search
    searchBarKey.currentState?.performSearch(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm kiếm"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            _searchStore.resetIsSearched();
            _searchStore.setIsFiltered(false);
            _filterStore.resetFilter();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          SearchingBar(key: searchBarKey),
          Expanded(
            child: Observer(builder: (context) {
              if (!_searchStore.isSearched) {
                return _searchStore.isLoadingHistorySearch
                    ? AbsorbPointer(
                        absorbing: true,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.2),
                            ),
                            const CustomProgressIndicatorWidget(),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _searchStore.searchHistory!.length,
                        itemBuilder: (context, index) {
                          return Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        print("OnTap in item");
                                        handleHistoryItemClick(
                                            _searchStore.searchHistory![index]);
                                      },
                                      child: Text(
                                        _searchStore.searchHistory![index],
                                        style: TextStyle(fontSize: 12),
                                        softWrap: true,
                                        maxLines: null,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.close,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ));
                        },
                      );
              }
              return _searchStore.isLoadingSearch
                  ? const Center(child: CustomProgressIndicatorWidget())
                  : ListView.builder(
                      itemCount:
                          _searchStore.lecturesAfterSearching!.lectures.length,
                      itemBuilder: (context, index) {
                        return LectureItem(
                            lecture: _searchStore
                                .lecturesAfterSearching!.lectures[index]);
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }
}
