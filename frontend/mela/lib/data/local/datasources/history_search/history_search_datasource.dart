import 'package:mela/core/data/local/sembast/sembast_client.dart';
import 'package:mela/data/local/constants/db_constants.dart';
import 'package:mela/domain/entity/history_search/history_search.dart';
import 'package:sembast/sembast.dart';

class HistoryDataSource {
  final _historyStore = intMapStoreFactory.store(DBConstants.HistoryStore);
  final SembastClient _sembastClient;

  HistoryDataSource(this._sembastClient);

  Future<int> insert(HistorySearch history) async {
    return await _historyStore.add(_sembastClient.database, history.toMap());
  }

  Future<List<HistorySearch>> getAllHistory() async {
    final recordSnapshots = await _historyStore.find(
      _sembastClient.database,
      finder: Finder(sortOrders: [SortOrder('id', false)]),
    );

    return recordSnapshots.map((snapshot) {
      final history = HistorySearch.fromMap(snapshot.value);
      return history;
    }).toList();
  }

  Future<int> delete(HistorySearch history) async {
    final finder = Finder(filter: Filter.byKey(history.id));
    return await _historyStore.delete(
      _sembastClient.database,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _historyStore.drop(
      _sembastClient.database,
    );
  }
}
