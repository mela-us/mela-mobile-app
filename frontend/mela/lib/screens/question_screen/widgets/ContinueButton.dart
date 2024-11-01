import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/themes/default/text_styles.dart';

class ContinueButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Color(0xFF0961F5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 19),
            //
            child: TextStandard.Button('Luyện tập tiếp', Colors.white),
          ),
          Positioned(
              right: 10,
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
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
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}