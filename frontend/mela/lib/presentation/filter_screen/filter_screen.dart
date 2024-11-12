import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/filter_screen/store/filter_store.dart';
import 'package:mela/presentation/filter_screen/widgets/checkbox_row.dart';
import 'package:mela/presentation/search_screen/store/search_store.dart';
import 'package:sembast/sembast.dart';

import 'widgets/filter_button.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final FilterStore _filterStore = getIt<FilterStore>();
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final SearchStore _searchStore = getIt<SearchStore>();

  final List<Map<String, dynamic>> rangeChoices = [
    {"label": "0%-50%", "start": 0.0, "end": 50.0},
    {"label": "20%-80%", "start": 20.0, "end": 80.0},
    {"label": "80%-100%", "start": 80.0, "end": 100.0},
  ];
  @override
  void initState() {
    super.initState();
    if (_filterStore.isFilterButtonPressed) {
      startController.text = _filterStore.startPercentage.toInt().toString();
      endController.text = _filterStore.endPercentage.toInt().toString();
    }
  }

  @override
  void dispose() {
    startController.dispose();
    endController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (!_filterStore.isFilterButtonPressed) {
                _filterStore.resetFilter();
              }
              Navigator.pop(context);
            }),
        title: Text('Lọc'),
        actions: [
          TextButton(
            onPressed: () {
              _filterStore.resetFilter();
              _searchStore.setIsFiltered(false);
              _filterStore.setIsFilteredButtonPressed(false);
              startController.clear();
              endController.clear();
            },
            child: Text('Đặt lại', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Cấp độ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxRow(
                  label: "Tiểu học",
                  isSelected: _filterStore.isPrimarySelected,
                  onToggle: _filterStore.togglePrimary),
              CheckboxRow(
                  label: "Trung học",
                  isSelected: _filterStore.isSecondarySelected,
                  onToggle: _filterStore.toggleSecondary),
              CheckboxRow(
                  label: "Phổ thông",
                  isSelected: _filterStore.isHighSchoolSelected,
                  onToggle: _filterStore.toggleHighSchool),
              const SizedBox(height: 16),
              const Text('Tiến trình',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              CheckboxRow(
                  label: "Chưa học",
                  isSelected: _filterStore.isNotStartedSelected,
                  onToggle: _filterStore.toggleNotStarted),
              CheckboxRow(
                  label: "Đang học",
                  isSelected: _filterStore.isInProgressSelected,
                  onToggle: _filterStore.toggleInProgress),
              CheckboxRow(
                  label: "Đã hoàn thành",
                  isSelected: _filterStore.isCompletedSelected,
                  onToggle: _filterStore.toggleCompleted),
              const SizedBox(height: 16),
              const Text('Điều chỉnh tiến trình',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildRangeSelection(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRangeChoices(),
                ],
              ),
              const SizedBox(height: 16),
              FilterButton(
                textButton: "Áp dụng",
                onPressed: () {
                  
                  // _searchStore.filterCourses();
                  _filterStore.setIsFilteredButtonPressed(true);
                  _searchStore.setIsFiltered(true);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildRangeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPercentageField("Từ", _filterStore.startPercentage, (value) {
          _filterStore.changeStartPercentage(double.tryParse(value)!);
          _filterStore.resetSelectedRangeIndex();
        }),
        Text("------", style: TextStyle(fontSize: 20, color: Colors.teal)),
        _buildPercentageField("Đến", _filterStore.endPercentage, (value) {
          _filterStore.changeEndPercentage(double.tryParse(value)!);
          _filterStore.resetSelectedRangeIndex();
        }),
      ],
    );
  }

  Widget _buildPercentageField(
      String label, double? value, Function(String) onChanged) {
    return Container(
      width: 80,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: label == "Từ" ? startController : endController,
        decoration: InputDecoration.collapsed(hintText: label),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.done,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        onChanged: (value) {
          if (value.isEmpty) {
            if (label == "Từ") {
              onChanged('0');
            } else {
              onChanged('100');
            }
            return;
          }
          int numValue = int.tryParse(value)!;
          if (numValue >= 0 && numValue <= 100) {
            onChanged(value);
          } else if (numValue > 100) {
            if (label == "Từ") {
              startController.text = "0";
              onChanged("0");
            } else {
              endController.text = "100";
              onChanged("100");
            }
          }
        },
      ),
    );
  }

  Widget _buildRangeChoices() {
    return Wrap(
      spacing: 8,
      children: List<Widget>.generate(
        rangeChoices.length,
        (index) => ChoiceChip(
          label: Text(rangeChoices[index]["label"]!),
          selected: _filterStore.selectedRangeIndex == index,
          onSelected: (selected) {
            if (selected) {
              _filterStore.setSelectedRangeIndex(index);
              _filterStore.changeStartPercentage(rangeChoices[index]["start"]);
              _filterStore.changeEndPercentage(rangeChoices[index]["end"]);
              startController.text =
                  _filterStore.startPercentage.toInt().toString();
              endController.text =
                  _filterStore.endPercentage.toInt().toString();
            } else {
              _filterStore.resetSelectedRangeIndex();
              _filterStore.changeStartPercentage(0.0);
              _filterStore.changeEndPercentage(100.0);
              startController.clear();
              endController.clear();
            }
          },
        ),
      ),
    );
  }
}
