import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/themes/default/text_styles.dart';

class QuestionListDialog extends StatelessWidget{
  final List<String> answers;
  final Function(int) onPickedQuestion;
  final Function(bool) onSubmitted;

  const QuestionListDialog({
    super.key,
    required this.answers,
    required this.onPickedQuestion,
    required this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 390,
        height: 290 + 34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              child: Stack(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 23),
                      child: Text(
                        'Danh sách câu hỏi',
                        style: TextStyle(
                          color: Color(0xFF202244),
                          fontSize: 20,
                          fontFamily: 'Asap',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    top: 15,
                    child: IconButton(
                        onPressed: () => onSubmitted(false),
                        icon: const Icon(Icons.close)
                    ),
                  ),

                ],
              ),
            ),
            //firstLine

            const SizedBox(height: 10),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 130,
              child: SingleChildScrollView(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                    ),
                    itemCount: answers.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => onPickedQuestion(index),
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: answers
                                .elementAt(index)
                                .isEmpty ?
                            Color(0xFFE9E9E9) : Color(0xFFC6DCFF),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: TextStandard.Normal(
                                '${index + 1}',
                                Color(0xFF202244)
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: GestureDetector(
                  onTap: () => onSubmitted(true),
                  child: Container(
                    width: double.infinity,
                    // padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0961F5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 19),
                          child: TextStandard.Button('Nộp bài', Colors.white),
                        ),
                        Positioned(
                          right: 10,
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF0961F5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}