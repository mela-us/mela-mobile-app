import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/presentation/filter_screen/store/filter_store.dart';
import 'package:mela/presentation/filter_screen/widgets/checkbox_row.dart';
import 'package:mela/presentation/search_screen/store/search_store.dart';

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
  LectureList filteredLectures = LectureList(lectures: []);
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

  void filterLectures() {
    filteredLectures.lectures.clear();
    filteredLectures = LectureList(
        lectures: []); //Must have to create new filterList to pass to filterList in SeachStore
    //add all lectures that match the filter range progress to filteredLectures
    for (var lecture in _searchStore.lecturesAfterSearching!.lectures) {
      if (lecture.progress >= _filterStore.startPercentage &&
          lecture.progress <= _filterStore.endPercentage) {
        filteredLectures.lectures.add(lecture);
      }
    }
    // print("filterLectures------------------------>2");
    // for (var lecture in filteredLectures.lectures) {
    //   print("lectureId: ${lecture.lectureId}");
    // }
    //Because if all level id be choose = no level id be choose
    if (_filterStore.isPrimarySelected ||
        _filterStore.isSecondarySelected ||
        _filterStore.isHighSchoolSelected) {
      if (!_filterStore.isPrimarySelected) {
        filteredLectures.lectures
            .removeWhere((lecture) => lecture.levelId == 0);
      }
      if (!_filterStore.isSecondarySelected) {
        filteredLectures.lectures
            .removeWhere((lecture) => lecture.levelId == 1);
      }
      if (!_filterStore.isHighSchoolSelected) {
        filteredLectures.lectures
            .removeWhere((lecture) => lecture.levelId == 2);
      }
    }

    if (_filterStore.isNotStartedSelected ||
        _filterStore.isInProgressSelected ||
        _filterStore.isCompletedSelected) {
      if (!_filterStore.isNotStartedSelected) {
        filteredLectures.lectures
            .removeWhere((lecture) => lecture.progress == 0);
      }
      if (!_filterStore.isInProgressSelected) {
        filteredLectures.lectures.removeWhere(
            (lecture) => lecture.progress > 0 && lecture.progress < 100);
      }
      if (!_filterStore.isCompletedSelected) {
        filteredLectures.lectures
            .removeWhere((lecture) => lecture.progress == 100);
      }
    }
    _searchStore.updateLectureAfterSeachingAndFiltering(filteredLectures);
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
        title: Text("Lọc",
            style: Theme.of(context)
                .textTheme
                .heading
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        actions: [
          TextButton(
            onPressed: () {
              _filterStore.resetFilter();
              _searchStore.setIsFiltered(false);
              _filterStore.setIsFilteredButtonPressed(false);
              startController.clear();
              endController.clear();
              _searchStore.updateLectureAfterSeachingAndFiltering(
                  _searchStore.lecturesAfterSearching!);
            },
            child: Text("Đặt lại",
                style: Theme.of(context)
                    .textTheme
                    .content
                    .copyWith(color: Theme.of(context).colorScheme.secondary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Cấp độ
              Text("Cấp độ",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
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

              //Tiến trình
              Text("Tiến trình",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
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

              //Tinh chỉnh tiến trình
              _filterStore.isInProgressSelected
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Điều chỉnh tiến trình",
                              style: Theme.of(context).textTheme.title.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          const SizedBox(height: 4),
                          Text("Đang học (%)",
                              style: Theme.of(context)
                                  .textTheme
                                  .normal
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
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
                        ],
                      ),
                    )
                  : Container(),

                //Button Áp dụng
              FilterButton(
                textButton: "Áp dụng",
                onPressed: () {
                  if(_filterStore.startPercentage>_filterStore.endPercentage){
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Giá trị % "Từ" phải nhỏ hơn')),
                      );
                      return;
                  }
                  filterLectures();
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
        Text("------",
            style: Theme.of(context)
                .textTheme
                .subHeading
                .copyWith(color: Theme.of(context).colorScheme.inversePrimary)),
        _buildPercentageField("Đến", _filterStore.endPercentage, (value) {
          _filterStore.changeEndPercentage(double.tryParse(value)!);
          _filterStore.resetSelectedRangeIndex();
        }),
      ],
    );
  }

  //_buildPercentageField to enter the percentage
  Widget _buildPercentageField(
      String label, double? value, Function(String) onChanged) {
    return Container(
      width: 80,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: label == "Từ" ? startController : endController,
        decoration: InputDecoration.collapsed(
            hintText: label,
            hintStyle: Theme.of(context)
                .textTheme
                .normal
                .copyWith(color: Theme.of(context).colorScheme.inversePrimary)),
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

  //Range choices in Tiến trình
  Widget _buildRangeChoices() {
    return Wrap(
      spacing: 8,
      children: List<Widget>.generate(
        rangeChoices.length,
        (index) => ChoiceChip(
          showCheckmark: false,
          selectedColor: Theme.of(context).colorScheme.inversePrimary,
          label: Text(
            rangeChoices[index]["label"]!,
            style: Theme.of(context)
                .textTheme
                .normal
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
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
