class HistorySearch {
  int? id;
  final String searchText;

  HistorySearch({this.id, required this.searchText});

  Map<String, dynamic> toMap() {
    return {
      'searchText': searchText,
    };
  }

  static HistorySearch fromMap(Map<String, dynamic> map) {
    return HistorySearch(
      searchText: map['searchText'] as String,
    );
  }
}
