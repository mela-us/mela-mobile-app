import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/constants/assets_path.dart';
import 'package:mela/screens/question_screen/widgets/ContinueButton.dart';
import 'package:mela/themes/default/text_styles.dart';

class ExitDialog extends StatelessWidget{
  final Function(bool) onStaying;

  const ExitDialog({
    super.key,
    required this.onStaying
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 390,
        height: 480+34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     IconButton(
            //       onPressed: xButtonPressed,
            //       icon: const Icon(Icons.close),
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: Image.asset(
                      AssetsPath.exit_image,
                      width: 242,
                      height: 170.85,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 27.15),
            TextStandard.Heading('Xác nhận thoát!', Color(0xFF202244),),
            SizedBox(height: 17),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 54),
              child: Text(
                textAlign: TextAlign.center,
                'Nếu bỏ dở bạn sẽ không xem được kết quả bài luyện tập này',
                style: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF545454),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: GestureDetector(
                  onTap: () => onStaying(true) ,
                  child: ContinueButton(),
                )
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => onStaying(false),
              //,
              child:TextStandard.Button('Đi ra ngoài', Color(0xFF505050))
            )
          ],
        ),
      ),
    );

    // TODO: implement build
    throw UnimplementedError();
  }


}