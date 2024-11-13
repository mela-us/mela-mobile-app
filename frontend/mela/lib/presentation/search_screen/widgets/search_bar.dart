// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mela/constants/app_theme.dart';
// import 'package:mela/di/service_locator.dart';
// import 'package:mela/presentation/search_screen/store/search_store.dart';

// import '../../../utils/routes/routes.dart';

// class SearchingBar extends StatefulWidget {
//   SearchingBar({super.key});

//   @override
//   State<SearchingBar> createState() => SearchingBarState();
// }

// class SearchingBarState extends State<SearchingBar> {
//   //warning: using SearchingBarState not _SearchingBarState to can use in searchBarKy in search_screen.dart
//   SearchStore _searchStore = getIt<SearchStore>();
//   TextEditingController controller = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(onTextChange);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controller.dispose();
//   }

//   void onTextChange() async {
//     if (controller.text.isEmpty) {
//       _searchStore.resetIsSearched();
//       await _searchStore.getHistorySearchList();
//     }
//   }

//   void performSearch(String value) async {
//     // if search in first time, isSearch is false, we need to change it to true
//     //but if  search in second time, continuing from first time, isSearch is true, we don't need to change it
//     if (value.isNotEmpty) {
//       if (!_searchStore.isSearched) {
//         _searchStore.toggleIsSearched();
//       }
//       await _searchStore.getLecturesAfterSearch(value);
//     } else {
//       _searchStore.resetIsSearched();
//       await _searchStore.getHistorySearchList();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Observer(builder: (_) {
//       return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.onTertiary,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: Row(
//             children: [
//               const Icon(Icons.search, size: 30),

//               //Search TextField
//               const SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: TextField(
//                   controller: controller,
//                   decoration: InputDecoration(
//                     hintText: 'Tìm kiếm',
//                     hintStyle: Theme.of(context).textTheme.normal.copyWith(
//                           color: Theme.of(context).colorScheme.secondary,
//                         ),
//                     border: InputBorder.none,
//                   ),
//                   style: Theme.of(context).textTheme.normal.copyWith(
//                         color: Theme.of(context).colorScheme.secondary,
//                       ),
//                   onSubmitted: performSearch,
//                 ),
//               ),
//               const SizedBox(
//                 width: 4,
//               ),
//               //Filter Icon
//               _searchStore.errorString.isEmpty
//                   ? !_searchStore.isLoadingSearch
//                       ? _searchStore.isSearched
//                           ? Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: _searchStore.isFiltered
//                                         ? Theme.of(context).colorScheme.tertiary
//                                         : Theme.of(context)
//                                             .colorScheme
//                                             .onTertiary,
//                                     borderRadius: BorderRadius.circular(8),
//                                     border: _searchStore.isFiltered
//                                         ? null
//                                         : Border.all(
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .tertiary,
//                                             width: 1,
//                                           )),
//                                 child: IconButton(
//                                   icon: Icon(
//                                     Icons.tune,
//                                     color: _searchStore.isFiltered
//                                         ? Theme.of(context)
//                                             .colorScheme
//                                             .onTertiary
//                                         : Theme.of(context)
//                                             .colorScheme
//                                             .tertiary,
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pushNamed(Routes.filterScreen);
//                                   },
//                                 ),
//                               ),
//                             )
//                           : Container()
//                       : Container()
//                   : Container(),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/search_screen/store/search_store.dart';
import '../../../utils/routes/routes.dart';

class SearchingBar extends StatefulWidget {
  SearchingBar({super.key});

  @override
  State<SearchingBar> createState() => SearchingBarState();
}

class SearchingBarState extends State<SearchingBar> {
  SearchStore _searchStore = getIt<SearchStore>();
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
      await _searchStore.getHistorySearchList();
    }
  }

  void performSearch(String value) async {
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

  Widget _buildFilterButton(BuildContext context) {
    if (_searchStore.errorString.isNotEmpty) {
      return Container();
    }
    
    if (_searchStore.isLoadingSearch) {
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
            Navigator.of(context).pushNamed(Routes.filterScreen);
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
              _buildFilterButton(context),
            ],
          ),
        ),
      );
    });
  }
}
