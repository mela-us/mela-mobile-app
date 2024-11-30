

abstract class StatSearchRepository {
  Future<List<String>> getStatSearchHistory();
  Future<void> updateStatSearchHistory(List<String> searchHistory);
}