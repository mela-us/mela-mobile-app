// import 'package:flutter/material.dart';
// import 'package:flutter_math_fork/flutter_math.dart';
// import 'package:mela/constants/app_theme.dart';

// class ConvertStringToLatex extends StatefulWidget {
//   final String rawText;
//   bool isStep;

//   ConvertStringToLatex({required this.rawText, this.isStep = false, super.key});

//   @override
//   State<ConvertStringToLatex> createState() => _ConvertStringToLatexState();
// }

// class _ConvertStringToLatexState extends State<ConvertStringToLatex> {
//   List<InlineSpan> _parseContent(String content) {
//     final spanList = <InlineSpan>[];

//     // // Chuẩn hóa chuỗi
//     // String normalized = content
//     //   ..replaceAll(RegExp(r'[\r\n]'), '') // Loại bỏ ký tự xuống dòng
//     //       .replaceAll(RegExp(r'\\{2}n'), '') // Loại bỏ \\n sai cú pháp
//     //       .replaceAllMapped(RegExp(r'\\\\'), (_) => '\\');

//     String normalized = content
//         // Loại bỏ ký tự xuống dòng thực sự (\r, \n)
//         .replaceAll(RegExp(r'[\r\n]'), '')
//         // Loại bỏ các chuỗi \\n, \\n\\n, hoặc các biến thể (bao gồm cả \n sau khi chuẩn hóa dấu \)
//         .replaceAllMapped(RegExp(r'\\{1,2}n(?:\\{1,2}n)*'), (_) => '')
//         // Chuẩn hóa các dấu \ liên tiếp thành một dấu \
//         .replaceAllMapped(RegExp(r'\\{2,}'), (_) => '\\')
//         // Loại bỏ khoảng trắng thừa ở đầu và cuối sau khi xử lý
//         .trim();

//     final regex = RegExp(r'(\\\[(.+?)\\\]|\\\((.+?)\\\))', dotAll: true);
//     final matches = regex.allMatches(normalized);
//     int currentIndex = 0;

//     for (final match in matches) {
//       final matchStart = match.start;
//       final matchEnd = match.end;
//       final mathContent = match.group(2) ?? match.group(3)!;

//       // Thêm văn bản thường trước công thức
//       if (matchStart > currentIndex) {
//         String textPart = normalized.substring(currentIndex, matchStart);
//         spanList.add(TextSpan(text: textPart));
//       }

//       // Thêm công thức toán học
//       spanList.add(WidgetSpan(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width * 0.85,
//           ),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 2.0),
//               child: Math.tex(
//                 mathContent,
//                 mathStyle: MathStyle.text,
//                 textScaleFactor: 1.1,
//                 textStyle: const TextStyle(
//                   fontSize: 16,
//                   letterSpacing: 0.5,
//                   height: 1.4,
//                 ),

//                 // textStyle: Theme.of(context).textTheme.content.copyWith(
//                 //       color: Colors.black,
//                 //       fontSize: 16,
//                 //       letterSpacing: 0.5,
//                 //       height: 1.25,
//                 //     ),
//               ),
//             ),
//           ),
//         ),
//         alignment: PlaceholderAlignment.middle,
//         baseline: TextBaseline.alphabetic,
//       ));

//       currentIndex = matchEnd;
//     }

//     // Thêm phần văn bản còn lại
//     if (currentIndex < normalized.length) {
//       spanList.add(TextSpan(text: normalized.substring(currentIndex)));
//     }

//     return spanList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       text: TextSpan(
//         children: _parseContent(widget.rawText),
//         // style: const TextStyle(fontSize: 16, color: Colors.black, height: 2.0),
//         style: widget.isStep
//             ? Theme.of(context).textTheme.content.copyWith(
//                   color: Color(0xFF5C6BC0),
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16,
//                   letterSpacing: 0.5,
//                   height: 1.4,
//                 )
//             : Theme.of(context).textTheme.content.copyWith(
//                   color: Colors.black,
//                   fontSize: 16,
//                   letterSpacing: 0.5,
//                   height: 1.6,
//                 ),
//       ),
//       textAlign: TextAlign.left,
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter_math_fork/flutter_math.dart';

// class ConvertStringToLatex extends StatelessWidget {
//   final String rawText;
//   final bool isStep;

//   const ConvertStringToLatex({
//     super.key,
//     required this.rawText,
//     this.isStep = false,
//   });

//   List<InlineSpan> _convertTextToSpans(BuildContext context, String input) {
//     final spans = <InlineSpan>[];
//     final regex = RegExp(r'(\\\[(.+?)\\\]|\\\((.+?)\\\))', dotAll: true);
//     int currentIndex = 0;

//     for (final match in regex.allMatches(input)) {
//       final start = match.start;
//       final end = match.end;
//       final mathContent = match.group(2) ?? match.group(3)!;

//       // Markdown text trước công thức
//       if (start > currentIndex) {
//         final markdownPart = input.substring(currentIndex, start);
//         spans.add(WidgetSpan(
//           child: MarkdownBody(
//             data: markdownPart,
//             styleSheet:
//                 MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
//               p: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     fontSize: 16,
//                     color: isStep ? const Color(0xFF5C6BC0) : Colors.black,
//                     fontWeight: isStep ? FontWeight.w500 : FontWeight.normal,
//                   ),
//             ),
//           ),
//         ));
//       }

//       // LaTeX
//       spans.add(WidgetSpan(
//         alignment: PlaceholderAlignment.middle,
//         baseline: TextBaseline.alphabetic,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Math.tex(
//               mathContent,
//               textStyle: const TextStyle(
//                 fontSize: 16,
//                 letterSpacing: 0.5,
//                 height: 1.4,
//               ),
//               mathStyle: MathStyle.text,
//               textScaleFactor: 1.1,
//             ),

//           ),
//         ),
//       ));

//       currentIndex = end;
//     }

//     // Phần cuối còn lại là markdown
//     if (currentIndex < input.length) {
//       final markdownPart = input.substring(currentIndex);
//       spans.add(WidgetSpan(
//         child: MarkdownBody(
//           data: markdownPart,
//           styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
//             p: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   fontSize: 16,
//                   color: isStep ? const Color(0xFF5C6BC0) : Colors.black,
//                   fontWeight: isStep ? FontWeight.w500 : FontWeight.normal,
//                 ),
//           ),
//         ),
//       ));
//     }

//     return spans;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final normalized = rawText
//         .replaceAll(RegExp(r'\\{1,2}n'), '\n')
//         .replaceAll(RegExp(r'\\{2,}'), '\\')
//         .trim();

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: RichText(
//         text: TextSpan(
//           children: _convertTextToSpans(context, normalized),
//         ),
//       ),
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutter_math_fork/flutter_math.dart';
// import 'package:markdown/markdown.dart' as md;

// class ConvertStringToLatex extends StatelessWidget {
//   final String rawText;
//   final bool isStep;

//   const ConvertStringToLatex({
//     required this.rawText,
//     this.isStep = false,
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
//             styleSheet:
//                 MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
//               p: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontSize: 16,
//                     color: isStep ? const Color(0xff5D3891) : Colors.black,
//                     height: 1.8,
//                   ),
//               strong: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: isStep ? const Color(0xff5D3891) : Colors.black,
//                   ),
//               em: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontSize: 16,
//                     fontStyle: FontStyle.italic,
//                     color: isStep ? const Color(0xff5D3891) : Colors.black,
//                   ),
//             ),
//             builders: {
//               'math': MathBuilder(isStep: isStep),
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

//   MathBuilder({required this.isStep});

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
//           child: Math.tex(
//             mathContent,
//             mathStyle: MathStyle.text,
//             textScaleFactor: 1.1,
//             textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   fontSize: 16,
//                   letterSpacing: 0.5,
//                   height: 1.8,
//                   color: isStep ? const Color(0xff5D3891) : Colors.black,
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }

