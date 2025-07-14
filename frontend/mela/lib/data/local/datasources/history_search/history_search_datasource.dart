import 'package:mela/core/data/local/sembast/sembast_client.dart';
import 'package:mela/data/local/constants/db_constants.dart';
import 'package:mela/domain/entity/history_search/history_search.dart';
import 'package:sembast/sembast.dart';

class HistoryDataSource {
  final _historyStore = intMapStoreFactory.store(DBConstants.HistoryStore);
  final SembastClient _sembastClient;

  HistoryDataSource(this._sembastClient);

  Future<void> insert(HistorySearch history) async {
    //test
    // print("------------------->History added IN DB Trc khi thêm");
    // await getAllHistory();
    await _historyStore.add(_sembastClient.database, history.toMap());
    //test
    // print("------------------->History added IN DB Sau khi them");
    // await getAllHistory();
  }

  Future<List<HistorySearch>> getAllHistory() async {
    final recordSnapshots = await _historyStore.find(
      _sembastClient.database,
      finder: Finder(sortOrders: [SortOrder('id', false)]),
    );

    final histories = recordSnapshots.map((snapshot) {
      final history = HistorySearch.fromMap(snapshot.value);
      return history;
    }).toList();
    //test
    // print("History get IN DB");
    // for (HistorySearch history in histories) {
    //   print(history.id.toString() + "--------" + history.searchText);
    // }
    return histories;
  }

  Future<void> delete(HistorySearch history) async {
    // print("------------------->History delete IN DB Trc xoa thêm");
    // await getAllHistory();
    final finder = Finder(filter: Filter.equals('id', history.id));
    await _historyStore.delete(
      _sembastClient.database,
      finder: finder,
    );
    //test
    // print("------------------------>History Deleted IN DB sua khi xoa");
    // await getAllHistory();
  }

  Future deleteAll() async {
    await _historyStore.drop(
      _sembastClient.database,
    );
  }
}
