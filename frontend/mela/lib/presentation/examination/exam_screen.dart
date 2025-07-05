import 'package:flutter/material.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/examination/store/countdown_store.dart';
import 'package:mela/presentation/examination/store/current_question_store.dart';
import 'package:mela/presentation/examination/store/exam_store.dart';
import 'package:mobx/mobx.dart';

class ExamScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final CountdownStore countdownStore = getIt<CountdownStore>();
  final CurrentQuestionStore currentQuestionStore =
      getIt<CurrentQuestionStore>();
  final ExamStore examStore = getIt<ExamStore>();

  @override
  void initState() {
    super.initState();
    // Any initialization logic can go here

    reaction((_) => examStore.loading, (loading) {
      //Not loading
      if (!loading) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Screen'),
      ),
      body: Center(
        child: Text('This is the Exam Screen'),
      ),
    );
  }
}
