import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:markdown/markdown.dart' as md;

class ConvertStringHintToLatex extends StatelessWidget {
  final String rawText;

  const ConvertStringHintToLatex({
    required this.rawText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildContent(context, rawText),
    );
  }

  List<Widget> _buildContent(BuildContext context, String content) {
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (final line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 6));
        continue;
      }

      widgets.add(
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: MarkdownBody(
            data: line,
            softLineBreak: false, // Ngăn tự động xuống dòng
            styleSheet:
                MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              p: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    letterSpacing: 0.65,
                    color: const Color(0xff5D3891),
                    height: 1.8,
                  ),
              strong: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    letterSpacing: 0.65,
                    height: 1.8,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff5D3891),
                  ),
              em: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    letterSpacing: 0.65,
                    height: 1.8,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xff5D3891),
                  ),
            ),
            builders: {
              'math': MathBuilder(),
            },
            extensionSet: md.ExtensionSet(
              md.ExtensionSet.gitHubFlavored.blockSyntaxes,
              [
                md.EmojiSyntax(),
                ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
                MathSyntax(),
              ],
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}

class MathSyntax extends md.InlineSyntax {
  MathSyntax() : super(r'\\\((.+?)\\\)|\\\[(.+?)\\\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final mathContent = match[1] ?? match[2] ?? '';
    parser.addNode(md.Element('math', [md.Text(mathContent)]));
    return true;
  }
}

class MathBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final mathContent = element.textContent
        .replaceAllMapped(RegExp(r'\\{2,}'), (_) => '\\')
        .trim();

    return Builder(
      builder: (context) => ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics:
              const ClampingScrollPhysics(), // Ngăn bouncing không cần thiết
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Math.tex(
                mathContent,
                mathStyle: MathStyle.text,
                textScaleFactor: 1.1,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      letterSpacing: 0.65,
                      height: 1.8,
                      color: const Color(0xff5D3891),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
