import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/search_screen/store/search_store.dart';

import '../../../utils/routes/routes.dart';

class SearchingBar extends StatefulWidget {
  SearchingBar({super.key});

  @override
  State<SearchingBar> createState() => SearchingBarState();
}

class SearchingBarState extends State<SearchingBar> {
  //warning: using SearchingBarState not _SearchingBarState to can use in searchBarKy in search_screen.dart
  SearchStore _searchStore = getIt<SearchStore>();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.addListener(onTextChange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void onTextChange() async {
    if (controller.text.isEmpty) {
      _searchStore.resetIsSearched();
      await _searchStore.getHistorySearchList();
    }
  }

  void performSearch(String value) async {
    // if search in first time, isSearch is false, we need to change it to true
    //but if  search in second time, continuing from first time, isSearch is true, we don't need to change it
    print("performSearch: $value");
    if (value.isNotEmpty) {
      if (!_searchStore.isSearched) {
        _searchStore.toggleIsSearched();
      }
      await _searchStore.getLecturesAfterSearch(value);
    } else {
      _searchStore.resetIsSearched();
      await _searchStore.getHistorySearchList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Icon(Icons.search, size: 30),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm',
                    border: InputBorder.none,
                  ),
                  onSubmitted: performSearch,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              //Filter Button
              !_searchStore.isLoadingSearch
                  ? _searchStore.isSearched
                      ? Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: _searchStore.isFiltered
                                    ? Colors.blue
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: _searchStore.isFiltered
                                    ? null
                                    : Border.all(
                                        color: Colors.blue,
                                        width: 1,
                                      )),
                            child: IconButton(
                              icon: Icon(
                                Icons.tune,
                                color: _searchStore.isFiltered
                                    ? Colors.white
                                    : Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(Routes.filterScreen);
                              },
                            ),
                          ),
                      )
                      : Container()
                  : Container(),
            ],
          ),
        ),
      );
    });
  }
}
