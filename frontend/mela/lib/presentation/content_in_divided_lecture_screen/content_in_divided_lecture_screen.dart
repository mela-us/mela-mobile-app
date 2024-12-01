import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';
import 'package:flutter_html/flutter_html.dart';

class ContentInDividedLectureScreen extends StatelessWidget {
  final DividedLecture currentDividedLecture;
  const ContentInDividedLectureScreen(
      {super.key, required this.currentDividedLecture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentDividedLecture.dividedLectureName,
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Html(data:"<!DOCTYPE html><html lang=\"vi\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Lý thuyết số mũ ngắn</title></head><body><h1>Lý thuyết số mũ ngắn</h1><p>Số mũ ngắn là một cách viết rút gọn phép nhân của một số với chính nó nhiều lần.</p><p><strong>Ví dụ:</strong></p><p><code>2<sup>3</sup> = 2 × 2 × 2 = 8</code></p><p>Trong đó, \"2\" là cơ số và \"3\" là số mũ. Số mũ cho biết số lần nhân cơ số với chính nó.</p><p>Số mũ cũng có thể có các tính chất toán học như:</p><ul><li><strong>Cộng số mũ:</strong> <code>a^m × a^n = a^(m+n)</code></li><li><strong>Nhân với số mũ:</strong> <code>(a^m)^n = a^(m×n)</code></li><li><strong>Số mũ âm:</strong> <code>a^(-n) = 1/a^n</code></li></ul></body></html>"),
        // child: SingleChildScrollView(
        //     child: Html(data: currentDividedLecture.contentInDividedLecture)),
      ),
    );
  }
}
