import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class ConvertStringToLatex extends StatelessWidget {
  final String rawText;
  final bool isStep;
  final bool isAI;

  const ConvertStringToLatex({
    required this.rawText,
    this.isStep = false,
    this.isAI = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isStep
          ? const EdgeInsets.only(bottom: 8.0)
          : const EdgeInsets.only(bottom: 4.0),
      child: _buildRichText(context),
    );
  }

  Widget _buildRichText(BuildContext context) {
    final spans = <InlineSpan>[];
    final regex = RegExp(r'\\\((.+?)\\\)|\\\[(.+?)\\\]');

    int lastEnd = 0;

    for (final match in regex.allMatches(rawText)) {
      // Thêm text trước LaTeX
      if (match.start > lastEnd) {
        final textBefore = rawText.substring(lastEnd, match.start);
        spans.addAll(_buildTextSpans(textBefore, context));
      }

      // Thêm LaTeX
      final mathContent = match.group(1) ?? match.group(2) ?? '';
      spans.add(WidgetSpan(
        child: _buildMathWidget(context, mathContent),
        alignment: PlaceholderAlignment.middle,
      ));

      lastEnd = match.end;
    }

    // Thêm text còn lại
    if (lastEnd < rawText.length) {
      spans.addAll(_buildTextSpans(rawText.substring(lastEnd), context));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 17,
              letterSpacing: 0.65,
              color: isStep
                  ? const Color(0xff5D3891)
                  : isAI
                      ? Colors.black
                      : Colors.white,
              height: 1.8,
            ),
      ),
    );
  }

  List<InlineSpan> _buildTextSpans(String text, BuildContext context) {
    final spans = <InlineSpan>[];
    final boldRegex = RegExp(r'\*\*(.+?)\*\*');

    int lastEnd = 0;

    for (final match in boldRegex.allMatches(text)) {
      // Thêm text trước bold
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }

      // Thêm text bold
      final boldText = match.group(1) ?? '';
      spans.add(TextSpan(
        text: boldText,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));

      lastEnd = match.end;
    }

    // Thêm text còn lại
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return spans;
  }

  Widget _buildMathWidget(BuildContext context, String mathContent) {
    final cleanContent =
        mathContent.replaceAllMapped(RegExp(r'\\{2,}'), (_) => '\\').trim();

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Math.tex(
          cleanContent,
          mathStyle: MathStyle.text,
          textScaleFactor: 1.1,
          textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 17,
                letterSpacing: 0.65,
                height: 1.8,
                color: isStep
                    ? const Color(0xff5D3891)
                    : isAI
                        ? Colors.black
                        : Colors.white,
              ),
        ),
      ),
    );
  }
}