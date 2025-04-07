import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:mela/constants/app_theme.dart';

class ConvertStringToLatex extends StatefulWidget {
  final String rawText;
  bool isStep;

  ConvertStringToLatex({required this.rawText, this.isStep = false, super.key});

  @override
  State<ConvertStringToLatex> createState() => _ConvertStringToLatexState();
}

class _ConvertStringToLatexState extends State<ConvertStringToLatex> {
  List<InlineSpan> _parseContent(String content) {
    final spanList = <InlineSpan>[];

    // Chuẩn hóa chuỗi
    String normalized = content
      ..replaceAll(RegExp(r'[\r\n]'), '') // Loại bỏ ký tự xuống dòng
          .replaceAll(RegExp(r'\\{2}n'), '') // Loại bỏ \\n sai cú pháp
          .replaceAllMapped(RegExp(r'\\\\'), (_) => '\\');

    final regex = RegExp(r'(\\\[(.+?)\\\]|\\\((.+?)\\\))', dotAll: true);
    final matches = regex.allMatches(normalized);
    int currentIndex = 0;

    for (final match in matches) {
      final matchStart = match.start;
      final matchEnd = match.end;
      final mathContent = match.group(2) ?? match.group(3)!;

      // Thêm văn bản thường trước công thức
      if (matchStart > currentIndex) {
        String textPart = normalized.substring(currentIndex, matchStart);
        spanList.add(TextSpan(text: textPart));
      }

      // Thêm công thức toán học
      spanList.add(WidgetSpan(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.85,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Math.tex(
                mathContent,
                mathStyle: MathStyle.text,
                textScaleFactor: 1.1,
                textStyle: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                  height: 1.4,
                ),

                // textStyle: Theme.of(context).textTheme.content.copyWith(
                //       color: Colors.black,
                //       fontSize: 16,
                //       letterSpacing: 0.5,
                //       height: 1.25,
                //     ),
              ),
            ),
          ),
        ),
        alignment: PlaceholderAlignment.middle,
        baseline: TextBaseline.alphabetic,
      ));

      currentIndex = matchEnd;
    }

    // Thêm phần văn bản còn lại
    if (currentIndex < normalized.length) {
      spanList.add(TextSpan(text: normalized.substring(currentIndex)));
    }

    return spanList;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _parseContent(widget.rawText),
        // style: const TextStyle(fontSize: 16, color: Colors.black, height: 2.0),
        style: widget.isStep
            ? Theme.of(context).textTheme.content.copyWith(
                  color: Color(0xFF5C6BC0),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 0.5,
                  height: 1.4,
                )
            : Theme.of(context).textTheme.content.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  letterSpacing: 0.5,
                  height: 1.6,
                ),
      ),
      textAlign: TextAlign.left,
    );
  }
}
