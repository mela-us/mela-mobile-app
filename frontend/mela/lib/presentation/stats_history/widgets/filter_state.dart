enum DateFilter { today, all, last7Days, last30Days }
enum TypeFilter { all, exercise, section, test }
enum ProgressStatus { all, gain, drop, unchanged }
enum SortOrder { asc, desc }

class FilterState {
  DateFilter dateFilter;
  DateTime? customFrom;
  DateTime? customTo;
  TypeFilter typeFilter;
  ProgressStatus progressStatus;
  SortOrder sortOrder;

  FilterState({
    this.dateFilter = DateFilter.last30Days,
    this.customFrom,
    this.customTo,
    this.typeFilter = TypeFilter.all,
    this.progressStatus = ProgressStatus.all,
    this.sortOrder = SortOrder.desc,
  });
}

extension DateFilterExt on DateFilter {
  String get label {
    switch (this) {
      case DateFilter.today:
        return 'Hôm nay';
      case DateFilter.all:
        return 'Tất cả';
      case DateFilter.last7Days:
        return '7 ngày';
      case DateFilter.last30Days:
        return '30 ngày';
    }
  }
}

extension TypeFilterExt on TypeFilter {
  String get label {
    switch (this) {
      case TypeFilter.all:
        return 'Mọi hoạt động';
      case TypeFilter.exercise:
        return 'Hoạt động bài tập';
      case TypeFilter.section:
        return 'Hoạt động bài học';
      case TypeFilter.test:
        return 'Hoạt động kiểm tra';
    }
  }
}

extension ProgressStatusExt on ProgressStatus {
  String get label {
    switch (this) {
      case ProgressStatus.all:
        return 'Tất cả';
      case ProgressStatus.gain:
        return 'Có tiến bộ';
      case ProgressStatus.drop:
        return 'Giảm sút';
      case ProgressStatus.unchanged:
        return 'Không đổi';
    }
  }
}

extension SortOrderExt on SortOrder {
  String get label {
    switch (this) {
      case SortOrder.asc:
        return 'Sớm nhất';
      case SortOrder.desc:
        return 'Gần đây nhất';
    }
  }
}
