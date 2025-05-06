import 'package:flutter/material.dart';

class GradeItems extends StatefulWidget {
  final int inputNumber;

  const GradeItems({super.key, required this.inputNumber});

  @override
  _GradeItemsState createState() => _GradeItemsState();
}

class _GradeItemsState extends State<GradeItems> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/grades/default_level.png', // Replace with your image path
            height: 50,
            width: 50,
          ),
          Text('Lớp ${widget.inputNumber}'),
        ],
      ),
    );
  }
}
