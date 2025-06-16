// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter_math_fork/flutter_math.dart';
// import 'package:markdown/markdown.dart' as md;

// class ConvertStringToLatex extends StatelessWidget {
//   final String rawText;
//   final bool isStep;
//   final bool isAI;

//   const ConvertStringToLatex({
//     required this.rawText,
//     this.isStep = false,
//     this.isAI = true,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: _buildContent(context, rawText),
//     );
//   }

//   List<Widget> _buildContent(BuildContext context, String content) {
//     final lines = content.split('\n');
//     final widgets = <Widget>[];

//     for (final line in lines) {
//       if (line.trim().isEmpty) {
//         widgets.add(const SizedBox(height: 6));
//         continue;
//       }

//       widgets.add(
//         Container(
//           margin: isStep
//               ? const EdgeInsets.only(bottom: 8.0)
//               : const EdgeInsets.only(bottom: 4.0),
//           child: MarkdownBody(
//             data: line,
//             softLineBreak: false, // Ngăn tự động xuống dòng
//             styleSheet:
//                 MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
//               p: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontSize: 17,
//                     letterSpacing: 0.65,
//                     color: isStep
//                         ? const Color(0xff5D3891)
//                         : isAI
//                             ? Colors.black
//                             : Colors.white,
//                     height: 1.8,
//                   ),
//               strong: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontSize: 17,
//                     letterSpacing: 0.65,
//                     height: 1.8,
//                     fontWeight: FontWeight.bold,
//                     color: isStep
//                         ? const Color(0xff5D3891)
//                         : isAI
//                             ? Colors.black
//                             : Colors.white,
//                   ),
//               em: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontSize: 17,
//                     letterSpacing: 0.65,
//                     height: 1.8,
//                     fontStyle: FontStyle.italic,
//                     color: isStep
//                         ? const Color(0xff5D3891)
//                         : isAI
//                             ? Colors.black
//                             : Colors.white,
//                   ),
//             ),
//             builders: {
//               'math': MathBuilder(isStep: isStep, isAI: isAI),
//             },
//             extensionSet: md.ExtensionSet(
//               md.ExtensionSet.gitHubFlavored.blockSyntaxes,
//               [
//                 md.EmojiSyntax(),
//                 ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
//                 MathSyntax(),
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//     return widgets;
//   }
// }

// class MathSyntax extends md.InlineSyntax {
//   MathSyntax() : super(r'\\\((.+?)\\\)|\\\[(.+?)\\\]');

//   @override
//   bool onMatch(md.InlineParser parser, Match match) {
//     final mathContent = match[1] ?? match[2] ?? '';
//     parser.addNode(md.Element('math', [md.Text(mathContent)]));
//     return true;
//   }
// }

// class MathBuilder extends MarkdownElementBuilder {
//   final bool isStep;
//   final bool isAI;

//   MathBuilder({required this.isStep, required this.isAI});

//   @override
//   Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
//     final mathContent = element.textContent
//         .replaceAllMapped(RegExp(r'\\{2,}'), (_) => '\\')
//         .trim();

//     return Builder(
//       builder: (context) => ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.85,
//         ),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           physics:
//               const ClampingScrollPhysics(), // Ngăn bouncing không cần thiết
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Math.tex(
//                 mathContent,
//                 mathStyle: MathStyle.text,
//                 textScaleFactor: 1.1,
//                 textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       fontSize: 17,
//                       letterSpacing: 0.65,
//                       height: 1.8,
//                       color: isStep
//                           ? const Color(0xff5D3891)
//                           : isAI
//                               ? Colors.black
//                               : Colors.white,
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }











//////////=//==============================C2==================================
// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter_math_fork/flutter_math.dart';
// import 'package:markdown/markdown.dart' as md;

// class ConvertStringToLatex extends StatelessWidget {
//   final String rawText;
//   final bool isStep;
//   final bool isAI;

//   const ConvertStringToLatex({
//     required this.rawText,
//     this.isStep = false,
//     this.isAI = true,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: isStep
//           ? const EdgeInsets.only(bottom: 8.0)
//           : const EdgeInsets.only(bottom: 4.0),
//       child: _buildRichText(context),
//     );
//   }

//   Widget _buildRichText(BuildContext context) {
//     final spans = <InlineSpan>[];
//     final regex = RegExp(r'\\\((.+?)\\\)|\\\[(.+?)\\\]');

//     int lastEnd = 0;

//     for (final match in regex.allMatches(rawText)) {
//       // Thêm text trước LaTeX
//       if (match.start > lastEnd) {
//         final textBefore = rawText.substring(lastEnd, match.start);
//         spans.add(TextSpan(text: textBefore));
//       }

//       // Thêm LaTeX
//       final mathContent = match.group(1) ?? match.group(2) ?? '';
//       spans.add(WidgetSpan(
//         child: _buildMathWidget(context, mathContent),
//         alignment: PlaceholderAlignment.middle,
//       ));

//       lastEnd = match.end;
//     }

//     // Thêm text còn lại
//     if (lastEnd < rawText.length) {
//       spans.add(TextSpan(text: rawText.substring(lastEnd)));
//     }

//     return RichText(
//       text: TextSpan(
//         children: spans,
//         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//               fontSize: 17,
//               letterSpacing: 0.65,
//               color: isStep
//                   ? const Color(0xff5D3891)
//                   : isAI
//                       ? Colors.black
//                       : Colors.white,
//               height: 1.8,
//             ),
//       ),
//     );
//   }

//   Widget _buildMathWidget(BuildContext context, String mathContent) {
//     final cleanContent =
//         mathContent.replaceAllMapped(RegExp(r'\\{2,}'), (_) => '\\').trim();

//     return Container(
//       constraints: BoxConstraints(
//         maxWidth: MediaQuery.of(context).size.width * 0.7,
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         child: Math.tex(
//           cleanContent,
//           mathStyle: MathStyle.text,
//           textScaleFactor: 1.1,
//           textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontSize: 17,
//                 letterSpacing: 0.65,
//                 height: 1.8,
//                 color: isStep
//                     ? const Color(0xff5D3891)
//                     : isAI
//                         ? Colors.black
//                         : Colors.white,
//               ),
//         ),
//       ),
//     );
//   }
// }

// // Giữ lại các class cũ để tương thích (nếu cần)
// class MathSyntax extends md.InlineSyntax {
//   MathSyntax() : super(r'\\\((.+?)\\\)|\\\[(.+?)\\\]');

//   @override
//   bool onMatch(md.InlineParser parser, Match match) {
//     final mathContent = match[1] ?? match[2] ?? '';
//     parser.addNode(md.Element('math', [md.Text(mathContent)]));
//     return true;
//   }
// }

// class MathBuilder extends MarkdownElementBuilder {
//   final bool isStep;
//   final bool isAI;

//   MathBuilder({required this.isStep, required this.isAI});

//   @override
//   Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
//     final mathContent = element.textContent
//         .replaceAllMapped(RegExp(r'\\{2,}'), (_) => '\\')
//         .trim();

//     return Builder(
//       builder: (context) => Container(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.7,
//         ),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           physics: const BouncingScrollPhysics(),
//           child: Math.tex(
//             mathContent,
//             mathStyle: MathStyle.text,
//             textScaleFactor: 1.1,
//             textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   fontSize: 17,
//                   letterSpacing: 0.65,
//                   height: 1.8,
//                   color: isStep
//                       ? const Color(0xff5D3891)
//                       : isAI
//                           ? Colors.black
//                           : Colors.white,
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }






//==============================C3==================================
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












//----------C4-------------------
// import 'package:flutter/material.dart';
// import 'package:flutter_math_fork/flutter_math.dart';

// class ConvertStringToLatex extends StatelessWidget {
//   final String rawText;
//   final bool isStep;
//   final bool isAI;

//   const ConvertStringToLatex({
//     required this.rawText,
//     this.isStep = false,
//     this.isAI = true,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: isStep
//           ? const EdgeInsets.only(bottom: 2.0)
//           : const EdgeInsets.only(bottom: 0.0),
//       child: _buildRichText(context),
//     );
//   }

//   Widget _buildRichText(BuildContext context) {
//     final spans = <InlineSpan>[];
//     final regex = RegExp(r'\\\((.+?)\\\)|\\\[(.+?)\\\]');

//     int lastEnd = 0;

//     for (final match in regex.allMatches(rawText)) {
//       // Thêm text trước LaTeX
//       if (match.start > lastEnd) {
//         final textBefore = rawText.substring(lastEnd, match.start);
//         spans.addAll(_buildTextSpans(textBefore, context));
//       }

//       // Thêm LaTeX
//       final mathContent = match.group(1) ?? match.group(2) ?? '';
//       spans.add(WidgetSpan(
//         child: _buildMathWidget(context, mathContent),
//         alignment: PlaceholderAlignment.middle,
//       ));

//       lastEnd = match.end;
//     }

//     // Thêm text còn lại
//     if (lastEnd < rawText.length) {
//       spans.addAll(_buildTextSpans(rawText.substring(lastEnd), context));
//     }

//     return RichText(
//       text: TextSpan(
//         children: spans,
//         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//               fontSize: 17,
//               letterSpacing: 0.65,
//               color: isStep
//                   ? const Color(0xff5D3891)
//                   : isAI
//                       ? Colors.black
//                       : Colors.white,
//               height: 1.8,
//             ),
//       ),
//     );
//   }

//   List<InlineSpan> _buildTextSpans(String text, BuildContext context) {
//     final spans = <InlineSpan>[];

//     // Xử lý từng dòng để phát hiện heading
//     final lines = text.split('\n');

//     for (int i = 0; i < lines.length; i++) {
//       final line = lines[i].trim();

//       // Bỏ qua dòng trống
//       if (line.isEmpty) {
//         // Chỉ thêm 1 newline cho dòng trống, không thêm extra spacing
//         spans.add(const TextSpan(text: '\n'));
//         continue;
//       }

//       // Kiểm tra heading (### Text)
//       final headingMatch = RegExp(r'^(#{1,6})\s+(.+)').firstMatch(line);
//       if (headingMatch != null) {
//         final level = headingMatch.group(1)!.length;
//         final headingText = headingMatch.group(2)!;

//         // Thêm spacing trước heading (chỉ khi không phải dòng đầu)
//         if (i > 0 && spans.isNotEmpty) {
//           spans.add(const TextSpan(text: '\n'));
//         }

//         spans.add(TextSpan(
//           text: headingText,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: _getHeadingSize(level),
//             height: 1.2, // Giảm height cho heading
//           ),
//         ));

//         // Thêm newline sau heading
//         spans.add(const TextSpan(text: '\n'));
//         continue;
//       }

//       // Xử lý text thường với bold formatting
//       _processBoldText(line, spans);

//       // Thêm newline giữa các dòng (chỉ khi không phải dòng cuối)
//       if (i < lines.length - 1) {
//         spans.add(const TextSpan(text: '\n'));
//       }
//     }

//     return spans;
//   }

// // Helper methods giữ nguyên
//   double _getHeadingSize(int level) {
//     switch (level) {
//       case 1:
//         return 24.0;
//       case 2:
//         return 22.0;
//       case 3:
//         return 20.0;
//       case 4:
//         return 18.5;
//       case 5:
//         return 17.5;
//       case 6:
//         return 17.0;
//       default:
//         return 17.0;
//     }
//   }

//   void _processBoldText(String text, List<InlineSpan> spans) {
//     final boldRegex = RegExp(r'\*\*(.+?)\*\*');
//     int lastEnd = 0;

//     for (final match in boldRegex.allMatches(text)) {
//       if (match.start > lastEnd) {
//         spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
//       }

//       final boldText = match.group(1) ?? '';
//       spans.add(TextSpan(
//         text: boldText,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//       ));

//       lastEnd = match.end;
//     }

//     if (lastEnd < text.length) {
//       spans.add(TextSpan(text: text.substring(lastEnd)));
//     }
//   }

//   Widget _buildMathWidget(BuildContext context, String mathContent) {
//     final cleanContent =
//         mathContent.replaceAllMapped(RegExp(r'\\{2,}'), (_) => '\\').trim();

//     return Container(
//       constraints: BoxConstraints(
//         maxWidth: MediaQuery.of(context).size.width * 0.7,
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         child: Math.tex(
//           cleanContent,
//           mathStyle: MathStyle.text,
//           textScaleFactor: 1.1,
//           textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontSize: 17,
//                 letterSpacing: 0.65,
//                 height: 1.8,
//                 color: isStep
//                     ? const Color(0xff5D3891)
//                     : isAI
//                         ? Colors.black
//                         : Colors.white,
//               ),
//         ),
//       ),
//     );
//   }
// }
