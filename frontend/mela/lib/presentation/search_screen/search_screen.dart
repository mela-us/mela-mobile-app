import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/progress_indicator_widget.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/filter_screen/store/filter_store.dart';
import 'package:mela/presentation/lectures_in_topic_screen/widgets/lecture_item.dart';
import 'package:mela/presentation/search_screen/widgets/search_bar.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';

import 'store/search_store.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchStore _searchStore = getIt<SearchStore>();
  final FilterStore _filterStore = getIt<FilterStore>();
  final GlobalKey<SearchingBarState> searchBarKey =
      GlobalKey<SearchingBarState>();
  late final ReactionDisposer _unAuthorizedReactionDisposer;
  @override
  void initState() {
    super.initState();
    //routeObserver.subscribe(this, ModalRoute.of(context));

    //for only refresh token expired
    _unAuthorizedReactionDisposer = reaction(
      (_) => _searchStore.isUnAuthorized,
      (value) {
        if (value) {
          _searchStore.isUnAuthorized = false;
          _searchStore.resetErrorString();
          //Remove all routes in stack
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.loginOrSignupScreen, (route) => false);
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //first time running
    if (!_searchStore.isLoadingHistorySearch) {
      _searchStore.getHistorySearchList();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _unAuthorizedReactionDisposer();
  }

  Future handleHistoryItemClick(String searchText) async {
    // Update the search bar text
    print("searchBarKey.currentState is not null $searchText");
    searchBarKey.currentState?.controller.text = searchText;
    // Perform the search
    await searchBarKey.currentState?.performSearch(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tìm kiếm",
            style: Theme.of(context)
                .textTheme
                .heading
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        leading: IconButton(
          onPressed: () async {
            if (_searchStore.isSearched) {
              _searchStore.resetIsSearched();
              _filterStore.resetFilter();
              _searchStore.setIsFiltered(false);
              _searchStore.resetErrorString();
              await _searchStore.getHistorySearchList();
              return;
            }
            //if not isSearched, pop the screen
            Navigator.of(context).pop();
            _searchStore.resetIsSearched();
            _searchStore.setIsFiltered(false);
            _filterStore.resetFilter();
            _searchStore.resetErrorString();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Search bar
          SearchingBar(key: searchBarKey),

          //ONLY Row History search or number of lectures after searching
          Observer(builder: (context) {
            if (!_searchStore.isSearched) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Lịch sử tìm kiếm",
                        style: Theme.of(context).textTheme.normal.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                    _searchStore.searchHistory!.isEmpty
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () async {
                              await _searchStore.deleteAllHistorySearch();
                            },
                            child: Text("Xóa tất cả",
                                style: Theme.of(context)
                                    .textTheme
                                    .normal
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                          ),
                  ],
                ),
              );
            }
            if (_searchStore.isLoadingSearch) {
              return const SizedBox.shrink();
            }
            if (_searchStore.errorString.isEmpty &&
                _searchStore.lecturesAfterSearchingAndFiltering != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tìm thấy",
                        style: Theme.of(context).textTheme.normal.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                    Text(
                        "${_searchStore.lecturesAfterSearchingAndFiltering!.lectures.length.toString()} kết quả",
                        style: Theme.of(context).textTheme.normal.copyWith(
                            color: Theme.of(context).colorScheme.tertiary)),
                  ],
                ),
              );
            }
            //if error
            return Center(
              child: Text(
                _searchStore.errorString,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }),

          //List history search or list lectures after searching
          Expanded(
            child: Observer(builder: (context) {
              //List history search
              if (!_searchStore.isSearched) {
                //print("Lúc BUILD LẠI TRONG SearchScreen");
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
                        itemBuilder: (_, index) {
                          return Container(
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        String searchText = _searchStore
                                            .searchHistory![index].searchText;

                                        //Must have searchText, not use handleHistoryItemClick with
                                        // _searchStore.searchHistory![index].searchText
                                        //because eg have a,b,c,d when delete in index 2 => searchText = c,
                                        //mobx will rebuild and searchHistory now have a,b,d
                                        //so it continue do await handleHistoryItemClick() at index =2,
                                        //_searchStore.searchHistory![2].searchText = d and display in handleHistoryItemClick is d => not correct,
                                        //correct must be searchText = c

                                        await _searchStore.deleteHistorySearch(
                                            _searchStore.searchHistory![index]);
                                        await handleHistoryItemClick(
                                            searchText);
                                      },
                                      child: Text(
                                        _searchStore
                                            .searchHistory![index].searchText,
                                        style: const TextStyle(fontSize: 12),
                                        softWrap: true,
                                        maxLines: null,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await _searchStore.deleteHistorySearch(
                                          _searchStore.searchHistory![index]);
                                    },
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

              if (_searchStore.isLoadingSearch) {
                return const Center(child: CustomProgressIndicatorWidget());
              }
              if (_searchStore.errorString.isNotEmpty ||
                  _searchStore.lecturesAfterSearchingAndFiltering == null) {
                return Center(
                  child: Text(
                    _searchStore.errorString,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              ///List lectures after searching
              return ListView.builder(
                itemCount: _searchStore
                    .lecturesAfterSearchingAndFiltering!.lectures.length,
                itemBuilder: (context, index) {
                  return LectureItem(
                      lecture: _searchStore
                          .lecturesAfterSearchingAndFiltering!.lectures[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
