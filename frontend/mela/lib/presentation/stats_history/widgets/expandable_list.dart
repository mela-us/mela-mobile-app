import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/stat/progress.dart';
import 'package:flutter/material.dart';
import '../../../constants/assets.dart';
import '../../../core/widgets/icon_widget/empty_icon_widget.dart';
import 'expandable_item.dart';
import 'filter_state.dart';

class ExpandableList extends StatefulWidget {
  final List<Progress>? list;

  const ExpandableList({super.key, required this.list});

  @override
  State<ExpandableList> createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  FilterState filter = FilterState();

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Progress> get filteredList {
    var filtered = widget.list ?? [];

    // Filter by type
    if (filter.typeFilter != TypeFilter.all) {
      filtered = filtered
          .where((p) => p.type.toLowerCase() == filter.typeFilter.name)
          .toList();
    }

    // Filter by progress status
    if (filter.progressStatus == ProgressStatus.gain) {
      filtered = filtered.where((p) => p.isGain).toList();
    } else if (filter.progressStatus == ProgressStatus.drop) {
      filtered = filtered.where((p) => p.isDrop).toList();
    } else if (filter.progressStatus == ProgressStatus.unchanged) {
      filtered = filtered.where((p) => !p.isGain && !p.isDrop).toList();
    }

    // if (filter.typeFilter == TypeFilter.exercise) {}

    // Filter by date
    DateTime now = DateTime.now();
    DateTime? fromDate;
    if (filter.dateFilter == DateFilter.today) {
      fromDate = DateTime(now.year, now.month, now.day);
    } else if (filter.dateFilter == DateFilter.last7Days) {
      fromDate = now.subtract(const Duration(days: 7));
    } else if (filter.dateFilter == DateFilter.last30Days) {
      fromDate = now.subtract(const Duration(days: 30));
    }

    if (fromDate != null) {
      filtered = filtered.where((p) {
        final date = DateTime.tryParse(p.latestDate);
        if (date == null) return false;
        return date.isAfter(fromDate!);
      }).toList();
    }

    // Sort
    filtered.sort((a, b) {
      final aDate = DateTime.tryParse(a.latestDate);
      final bDate = DateTime.tryParse(b.latestDate);
      if (aDate == null || bDate == null) return 0;
      return filter.sortOrder == SortOrder.asc
          ? aDate.compareTo(bDate)
          : bDate.compareTo(aDate);
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter row
        _buildFilterRow(),
        // List view
        Expanded(
          child: filteredList.isEmpty
              ? const Center(
            child: EmptyIconWidget(
                mainMessage: "Oops. Không có gì phù hợp tiêu chí bạn chọn.",
                secondaryMessage: "Vui lòng chọn tiêu chí khác",
                offset: 100,
            ),
          )
              : ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ExpandableItem(item: filteredList[index]),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ),

      ],
    );
  }

  InputDecoration buildDropdownDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary),
      ),
    );
  }

  Text buildText(String text) {
    return Text( //Tên chủ đề
      text,
      style: Theme.of(context).textTheme.subTitle.copyWith(color: Theme.of(context).colorScheme.onPrimary)
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 22, right: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: Row(
          children: [
            // Sort order
            IntrinsicWidth(
              child: DropdownButtonFormField<SortOrder>(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 1.0),
                  child: Image.asset(
                    Assets.stats_show,
                    width: 10,
                    height: 10,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                value: filter.sortOrder,
                onChanged: (val) => setState(() => filter.sortOrder = val!),
                decoration: buildDropdownDecoration(),
                items: SortOrder.values
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: buildText(e.label),
                  ),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(width: 10),

            // Date filter
            IntrinsicWidth(
              child: DropdownButtonFormField<DateFilter>(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 1.0),
                  child: Image.asset(
                    Assets.stats_show,
                    width: 10,
                    height: 10,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                value: filter.dateFilter,
                onChanged: (val) => setState(() => filter.dateFilter = val!),
                decoration: buildDropdownDecoration(),
                items: DateFilter.values
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0), // Giảm vertical padding
                    child: buildText(e.label),
                  ),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(width: 10),

            // Type filter
            IntrinsicWidth(
              child: DropdownButtonFormField<TypeFilter>(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 1.0), // 8 là khoảng trống hai bên
                  child: Image.asset(
                    Assets.stats_show,
                    width: 10,
                    height: 10,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                value: filter.typeFilter,
                onChanged: (val) => setState(() {
                  filter.typeFilter = val!;
                  if (val == TypeFilter.exercise) {
                    scrollToRightEnd();
                  }
                }),
                decoration: buildDropdownDecoration(),
                items: TypeFilter.values
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: buildText(e.label),
                  ),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(width: 10),
            // Progress status
            if (filter.typeFilter == TypeFilter.exercise) IntrinsicWidth(
              child: DropdownButtonFormField<ProgressStatus>(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 1.0), // 8 là khoảng trống hai bên
                  child: Image.asset(
                    Assets.stats_show,
                    width: 10,
                    height: 10,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                value: filter.progressStatus,
                onChanged: (val) => setState(() => filter.progressStatus = val!),
                decoration: buildDropdownDecoration(),
                items: ProgressStatus.values
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: buildText(e.label),
                  ),
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollToRightEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}
