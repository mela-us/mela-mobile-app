import '../../../domain/repository/stat/stat_search_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StatSearchRepositoryImpl extends StatSearchRepository {
  static const String _searchHistoryKey = 'mela_stat_search_history';

  @override
  Future<List<String>> getStatSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_searchHistoryKey) ?? [];
  }

  @override
  Future<void> updateStatSearchHistory(List<String> historySearchList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_searchHistoryKey, historySearchList);
  }
}

// List<Progress>? temp = Global.progressList?.where(
//         (progress) => progress.topicName?.contains(searchText) ?? false
// ).toList();
