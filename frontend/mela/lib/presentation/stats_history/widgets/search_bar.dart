import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:sembast/sembast.dart';
import '../../../utils/routes/routes.dart';
import '../store/stat_filter_store.dart';
import '../store/stat_search_store.dart';

class SearchingBar extends StatefulWidget {
  SearchingBar({super.key});

  @override
  State<SearchingBar> createState() => SearchingBarState();
}

class SearchingBarState extends State<SearchingBar> {
  //warning: using SearchingBarState not _SearchingBarState to can use in searchBarKy in search_screen.dart
  StatSearchStore _searchStore = getIt<StatSearchStore>();
  StatFilterStore _filterStore = getIt<StatFilterStore>();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onTextChange);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void onTextChange() async {
    if (controller.text.isEmpty) {
      _searchStore.resetIsSearched();
      await _searchStore.getStatSearchHistory();
    }
  }

  void performSearch(String value) async {
    // if search in first time, isSearch is false, we need to change it to true
    //but if  search in second time, continuing from first time, isSearch is true, we don't need to change it
    if (value.isNotEmpty) {
      if (!_searchStore.isSearched) {
        _searchStore.toggleIsSearched();
      }
      //always set isFiltered to false when user search and reset filter
      _searchStore.setIsFiltered(false);
      _filterStore.resetFilter();
      //await _searchStore.getAfterSearch(value);
      _searchStore.addSearchHistoryItem(value);
    } else {
      _searchStore.resetIsSearched();
      await _searchStore.getStatSearchHistory();
    }
  }

  Widget _buildFilterButton(BuildContext context) {
    if (_searchStore.errorString.isNotEmpty) {
      return Container();
    }

    if (!_searchStore.isSearched) {
      return Container();
    }

    Color buttonColor = _searchStore.isFiltered
        ? Theme.of(context).colorScheme.tertiary
        : Theme.of(context).colorScheme.onTertiary;

    Color iconColor = _searchStore.isFiltered
        ? Theme.of(context).colorScheme.onTertiary
        : Theme.of(context).colorScheme.tertiary;

    BoxBorder? border;
    if (!_searchStore.isFiltered) {
      border = Border.all(
        color: Theme.of(context).colorScheme.tertiary,
        width: 1,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
          border: border,
        ),
        child: IconButton(
          icon: Icon(
            Icons.tune,
            color: iconColor,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.filterStats);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onTertiary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Icon(Icons.search, size: 30),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm',
                    hintStyle: Theme.of(context).textTheme.normal.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.normal.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onSubmitted: performSearch,
                ),
              ),
              const SizedBox(width: 4),
              //Filter Icon
              _buildFilterButton(context),
            ],
          ),
        ),
      );
    });
  }
}