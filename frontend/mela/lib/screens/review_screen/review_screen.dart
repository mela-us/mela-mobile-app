import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/models/Notifiers/question_change_notifier.dart';
import 'package:mela/models/QuestionFamily/AQuestion.dart';
import 'package:mela/screens/review_screen/widgets/question_view.dart';
import 'package:provider/provider.dart';

import '../../constants/assets_path.dart';
import '../../constants/global.dart';
import '../../themes/default/text_styles.dart';

class ReviewScreen extends StatefulWidget {
  final List<AQuestion> questions;
  final List<String> answers;
  const ReviewScreen({super.key, required this.questions, required this.answers});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late List<AQuestion> _questions;
  late List<String> _answers;

  int _selectedIndex = 0;
  QAMixNotifier _notifier = QAMixNotifier();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //value initialize
    _questions = widget.questions;
    _answers = widget.answers;
    _selectedIndex = 0;

    //notifier initialize
    _notifier.updateQAMix(
        _questions.elementAt(_selectedIndex),
        _selectedIndex,
        _answers.elementAt(_selectedIndex)
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _basicAppBar(),
      body: ChangeNotifierProvider(
        create: (_) => _notifier,
        child: QuestionView(),
      )
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}


void _backButtonPressed() {
}

AppBar _basicAppBar(){
  return AppBar(
    automaticallyImplyLeading: false,
    title: Padding(
      padding: EdgeInsets.only(left: Global.PracticeLeftPadding),
      child: Row(
        children: [
          GestureDetector(
            onTap: _backButtonPressed,
            child: Image.asset(
              AssetsPath.arrow_back_longer,
              width: 26,
              height: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11.79),
            child: TextStandard.Heading(
                'Luyện tập',
                Global.AppBarContentColor
            ),
          )
        ],
      ),
    ),
    backgroundColor: Global.AppBackgroundColor,
  );
}










