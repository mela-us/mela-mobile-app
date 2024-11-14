import 'package:mobx/mobx.dart';

part 'stats_store.g.dart';

class StatisticsStore = _StatisticsStore with _$StatisticsStore;

abstract class _StatisticsStore with Store {
  @observable
  ObservableList<Item> items = ObservableList<Item>();

  _StatisticsStore() {
    items.addAll(createItems());
  }

  @action
  void updateItemProgress(int index, int newProgress) {
    if (index >= 0 && index < items.length) {
      items[index].currentProgress = newProgress;
    }
  }
}

class Item {
  String title;
  int currentProgress;
  int total;

  Item({
    required this.title,
    required this.currentProgress,
    required this.total,
  });
}

List<Item> createItems() {
  return [
    Item(title: 'Số học', currentProgress: 3, total: 10),
    Item(title: 'Đại số', currentProgress: 3, total: 10),
    Item(title: 'Hình học', currentProgress: 2, total: 10),
    Item(title: 'Lý thuyết số', currentProgress: 1, total: 10),
    Item(title: 'Xác suất thống kê', currentProgress: 7, total: 10),
    Item(title: 'Vị phần', currentProgress: 4, total: 10),
    Item(title: 'Dãy số', currentProgress: 20, total: 30),
  ];
}