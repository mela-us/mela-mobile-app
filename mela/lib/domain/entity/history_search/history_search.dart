class HistorySearch {
  final int id;
  final String searchText;

  HistorySearch({
    required this.id,
    required this.searchText,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'searchText': searchText,
    };
  }

  factory HistorySearch.fromMap(Map<String, dynamic> map) {
    return HistorySearch(
      id: map['id'],
      searchText: map['searchText'],
    );
  }
}
