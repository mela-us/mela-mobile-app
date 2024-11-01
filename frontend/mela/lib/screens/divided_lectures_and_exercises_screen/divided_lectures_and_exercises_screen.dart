import 'package:flutter/material.dart';
import 'package:mela/models/lecture.dart';
import 'package:mela/screens/divided_lectures_and_exercises_screen/widgets/exercise_list_item.dart';

import '../../themes/default/colors_standards.dart';
import '../../themes/default/text_styles.dart';

class DividedLecturesAndExercisesScreen extends StatefulWidget {
  final Lecture currentLecture;
  DividedLecturesAndExercisesScreen({super.key, required this.currentLecture});
  @override
  _DividedLecturesAndExercisesScreenState createState() =>
      _DividedLecturesAndExercisesScreenState();
}

class _DividedLecturesAndExercisesScreenState
    extends State<DividedLecturesAndExercisesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStandards.AppBackgroundColor,
      appBar:
          //AppBar
          AppBar(
        title: TextStandard.Heading(widget.currentLecture.lectureName,
            ColorsStandards.textColorInBackground1),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ColorsStandards.backgroundButtonNoChooseColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: ColorsStandards.textColorInBackground1,
                indicator: BoxDecoration(
                  color: ColorsStandards.backgroundButtonChooseColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
                tabs: [
                  //Tab "Lý thuyết"
                  Tab(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text('Lý thuyết',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  //Tab "Luyện tập"
                  Tab(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text('Luyện tập',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                //Tab "Lý thuyết" content
                Center(child: Text("content goes here")),

                //Tab "Luyện tập" content
                ExerciseListItem(currentLecture: widget.currentLecture),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
