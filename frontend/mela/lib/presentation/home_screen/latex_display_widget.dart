import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
// Mẫu để test, cái cuối là tự custom để test phần mixed_content. có thể coi để hiểu luồng.
//  LaTeXDisplayWidget(
//   text:
//       "Đây **là bài toán về tính** tích phân xác định của một hàm tổng: \\( \\tan x \\) và \\( e^{\\sin x} \\cos x \\). Yêu cầu của đề bài là tính giá trị của biểu thức này trên đoạn từ 0 đến \\( \\frac{\\pi}{4} \\). Ta phải xét từng phần riêng biệt: tích phân của \\( \\tan x \\) và tích phân của \\( e^{\\sin x} \\cos x \\). Công cụ có thể dùng gồm phân tích tổng thành hai tích phân nhỏ, sử dụng công thức tích phân cơ bản, nhận dạng hàm hợp và biến đổi vi phân.",
// ),
// LaTeXDisplayWidget(
//   text:
//       "Tính F(2): \n\n- \\( x^3 = 2^3 = 8 \\)\n- \\( -\\frac{7}{2}x^2 = -\\frac{7}{2} \\times 4 = -14 \\)\n- \\( \\ln|2+1| = \\ln 3 \\)\n\\( \\Rightarrow F(2) = 8 - 14 + \\ln 3 = -6 + \\ln 3 \\)\n\nTính F(0): \n- \\( x^3 = 0 \\)\n- \\( -\\frac{7}{2}x^2 = 0 \\)\n- \\( \\ln|0+1| = \\ln 1 = 0 \\)\n\\( \\Rightarrow F(0) = 0 \\)",
// ),
// SizedBox(height: 20),
// LaTeXDisplayWidget(
//     text:
//         "\\[ \\int_{0}^{2} (3x^2 - 7x + \\frac{1}{x+1}) dx = F(2) - F(0) = (-6 + \\ln 3) - 0 = -6 + \\ln 3 \\]"),
// SizedBox(height: 20),
// LaTeXDisplayWidget(
//   text:
//       "Dĩ nhiên rồi!\n\n Mình sẽ chia lời giải thành hai phần rõ ràng với Heading 1 và Heading 2 để bạn dễ hiểu hơn nhé.\n\n# 1. Xác định nửa chu vi và lập phương trình\n\n- Chu vi hình chữ nhật là 190 m.\n- Gọi chiều dài là \\(d\\), chiều rộng là \\(r\\).\n- Ta biết chiều dài hơn chiều rộng 15 m, tức là: \\(d = r + 15\\).\n\nCông thức chu vi hình chữ nhật: \\(P = 2 \\times (d + r)\\).\n\nVậy ta có:\n\\[ \n2 \\times (d + r) = 190 \n\\]\nChia cả hai vế cho 2:\n\\[\nd + r = 95\n\\]\n\n# 2. Tính chiều rộng\n\nThay \\(d = r + 15\\) vào phương trình trên:\n\\[\n(r + 15) + r = 95\n\\]\n\\[\n2r + 15 = 95\n\\]\n\\[\n2r = 95 - 15\n\\]\n\\[\n2r = 80\n\\]\n\\[\nr = 40\n\\]\n\nVậy chiều rộng của hình chữ nhật là 40 m.\n\nNếu còn chỗ nào chưa rõ, bạn cứ hỏi thêm nhé!",
// ),
//  LaTeXDisplayWidget(
//   text:
//       "Dĩ nhiên rồi!\n\n Mình sẽ chia lời giải thành hai phần rõ ràng với\nHeading 1 và Heading 2\n để bạn dễ hiểu hơn nhé.\n\n# 1. Xác định nửa chu vi và lập phương trình\n\n- Chu vi hình chữ nhật là 190 m.\n- abc\n\nNếu còn chỗ nào chưa rõ, bạn cứ hỏi thêm nhé!",
// ),

class LaTeXDisplayWidget extends StatefulWidget {
  final String text;
  final bool isAI;

  const LaTeXDisplayWidget({
    super.key,
    required this.text,
    this.isAI = true,
  });

  @override
  State<LaTeXDisplayWidget> createState() => _LaTeXDisplayWidgetState();
}

class _LaTeXDisplayWidgetState extends State<LaTeXDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    final parsedContent = _parseContent(widget.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parsedContent.map((item) {
        switch (item['type']) {
          case 'latex_block':
            return _buildLatexBlock(item['content']!);
          case 'mixed_content':
            return _buildMixedContent(item['content']!);
          default:
            return const SizedBox.shrink();
        }
      }).toList(),
    );
  }

  List<Map<String, String>> _parseContent(String content) {
    List<Map<String, String>> result = [];

    // Tìm tất cả LaTeX blocks \[...\]
    final blockLatexRegex = RegExp(r'\\\[(.*?)\\\]', dotAll: true);

    List<_LatexMatch> blockMatches = [];

    // Tìm block LaTeX
    for (final match in blockLatexRegex.allMatches(content)) {
      blockMatches.add(_LatexMatch(
        start: match.start,
        end: match.end,
        type: 'latex_block',
        content: match.group(1)!.trim(),
      ));
    }

    // Sắp xếp theo vị trí
    blockMatches.sort((a, b) => a.start.compareTo(b.start));

    int currentIndex = 0;

    for (final blockMatch in blockMatches) {
      // Thêm mixed content (markdown + inline latex) trước block này
      if (currentIndex < blockMatch.start) {
        final mixedContent = content.substring(currentIndex, blockMatch.start);
        if (mixedContent.trim().isNotEmpty) {
          result.add({
            'type': 'mixed_content',
            'content': mixedContent,
          });
        }
      }

      // Thêm LaTeX block
      result.add({
        'type': 'latex_block',
        'content': blockMatch.content,
      });

      currentIndex = blockMatch.end;
    }

    // Thêm phần mixed content còn lại
    if (currentIndex < content.length) {
      final remaining = content.substring(currentIndex);
      if (remaining.trim().isNotEmpty) {
        result.add({
          'type': 'mixed_content',
          'content': remaining,
        });
      }
    }

    // Nếu không có LaTeX block nào, trả về toàn bộ như mixed content
    if (result.isEmpty && content.trim().isNotEmpty) {
      result.add({
        'type': 'mixed_content',
        'content': content,
      });
    }

    return result;
  }

  Widget _buildLatexBlock(String latex) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF0F9FF),
              Color(0xFFE0F2FE),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: const Color(0xFF0EA5E9), // Sky 500
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0EA5E9).withOpacity(0.2),
              blurRadius: 2.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(
            latex,
            textStyle: Theme.of(context).textTheme.displaySmall!,
            mathStyle: MathStyle.display,
          ),
        ),
      ),
    );
  }

  Widget _buildMixedContent(String content) {
    // Parse markdown đầu tiên để có structure
    return _MarkdownWithInlineLatex(content: content, isAI: widget.isAI);
  }
}

class _MarkdownWithInlineLatex extends StatefulWidget {
  final String content;
  final bool isAI;

  const _MarkdownWithInlineLatex({required this.content, required this.isAI});

  @override
  State<_MarkdownWithInlineLatex> createState() =>
      _MarkdownWithInlineLatexState();
}

class _MarkdownWithInlineLatexState extends State<_MarkdownWithInlineLatex> {
  @override
  Widget build(BuildContext context) {
    // Tách content thành các đoạn dựa trên markdown structure
    final sections = _parseMarkdownSections(widget.content);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) => _buildSection(section)).toList(),
    );
  }

  List<Map<String, dynamic>> _parseMarkdownSections(String content) {
    final lines = content.split('\n');
    print("Line=========> $lines");
    List<Map<String, dynamic>> sections = [];

    String currentParagraph = '';

    for (String line in lines) {
      final trimmedLine = line.trim();

      // Headers
      if (trimmedLine.startsWith('#')) {
        // Flush current paragraph
        if (currentParagraph.isNotEmpty) {
          sections.add({
            'type': 'paragraph',
            'content': currentParagraph.trim(),
          });
          currentParagraph = '';
        }

        // Add header
        int level = 0;
        for (int i = 0; i < trimmedLine.length && trimmedLine[i] == '#'; i++) {
          level++;
        }
        sections.add({
          'type': 'header',
          'level': level,
          'content': trimmedLine.substring(level).trim(),
        });
      }
      // List items
      else if (trimmedLine.startsWith('-') || trimmedLine.startsWith('*')) {
        // Flush current paragraph
        if (currentParagraph.isNotEmpty) {
          sections.add({
            'type': 'paragraph',
            'content': currentParagraph.trim(),
          });
          currentParagraph = '';
        }

        sections.add({
          'type': 'list_item',
          'content': trimmedLine.substring(1).trim(),
        });
      }
      // Empty lines
      else if (trimmedLine.isEmpty) {
        if (currentParagraph.isNotEmpty) {
          sections.add({
            'type': 'paragraph',
            'content': currentParagraph.trim(),
          });
          currentParagraph = '';
        }
      }
      // Regular text
      else {
        if (currentParagraph.isNotEmpty) {
          currentParagraph += ' ';
        }
        currentParagraph += line;
      }
    }

    // Flush remaining paragraph
    if (currentParagraph.isNotEmpty) {
      sections.add({
        'type': 'paragraph',
        'content': currentParagraph.trim(),
      });
    }

    return sections;
  }

  Widget _buildSection(Map<String, dynamic> section) {
    switch (section['type']) {
      case 'header':
        return _buildHeader(section['content'], section['level']);
      case 'paragraph':
        return _buildParagraphWithInlineLatex(section['content']);
      case 'list_item':
        return _buildListItem(section['content']);
      default:
        return const SizedBox.shrink();
    }
  }

//- 3 phần lớn
  Widget _buildHeader(String content, int level) {
    double fontSize;
    FontWeight fontWeight;

    switch (level) {
      case 1:
        fontSize = 18.0;
        fontWeight = FontWeight.bold;
        break;
      case 2:
        fontSize = 16.0;
        fontWeight = FontWeight.bold;
        break;
      case 3:
        fontSize = 14.0;
        fontWeight = FontWeight.w600;
        break;
      default:
        fontSize = 12.0;
        fontWeight = FontWeight.w600;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: _buildTextWithInlineLatex(
          content,
          Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: fontSize,
                fontWeight: fontWeight,
                height: 1.2,
              )),
    );
  }

  Widget _buildParagraphWithInlineLatex(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: _buildTextWithInlineLatex(
          content,
          Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(height: 1.8, fontSize: 17, letterSpacing: 0.65)),
    );
  }

  Widget _buildListItem(String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(height: 1.8, fontSize: 17, letterSpacing: 0.65)),
          Expanded(
            child: _buildTextWithInlineLatex(
                content,
                Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(height: 1.8, fontSize: 17, letterSpacing: 0.65)),
          ),
        ],
      ),
    );
  }

// Xử lý inline LaTeX trong đoạn văn bản các hàm con
  Widget _buildTextWithInlineLatex(String text, TextStyle baseStyle) {
    final inlineLatexRegex = RegExp(r'\\\((.*?)\\\)');
    final matches = inlineLatexRegex.allMatches(text).toList();

    if (matches.isEmpty) {
      // Xử lý markdown formatting cho text thuần
      return _buildFormattedText(text, baseStyle);
    }

    List<InlineSpan> spans = [];
    int currentIndex = 0;

    for (final match in matches) {
      // Thêm text trước LaTeX
      if (currentIndex < match.start) {
        final textBefore = text.substring(currentIndex, match.start);
        spans.addAll(_buildTextSpans(textBefore, baseStyle));
      }

      // Thêm LaTeX inline
      spans.add(WidgetSpan(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: const Color(0xFFDEF7EC), // Emerald 50
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: const Color(0xFF10B981), // Emerald 500
              width: 1.0,
            ),
          ),
          child: Math.tex(
            match.group(1)!.trim(),
            textStyle: TextStyle(
              fontSize: baseStyle.fontSize! * 0.95,
              color: const Color(0xFF064E3B), // Emerald 900
              fontWeight: FontWeight.w500,
            ),
            mathStyle: MathStyle.text,
          ),
        ),
        alignment: PlaceholderAlignment.middle,
      ));

      currentIndex = match.end;
    }

    // Thêm text còn lại
    if (currentIndex < text.length) {
      final textAfter = text.substring(currentIndex);
      spans.addAll(_buildTextSpans(textAfter, baseStyle));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _buildFormattedText(String text, TextStyle baseStyle) {
    final spans = _buildTextSpans(text, baseStyle);
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  List<InlineSpan> _buildTextSpans(String text, TextStyle baseStyle) {
    List<InlineSpan> spans = [];

    // Xử lý bold **text**
    final boldRegex = RegExp(r'\*\*(.*?)\*\*');
    final boldMatches = boldRegex.allMatches(text).toList();

    if (boldMatches.isEmpty) {
      spans.add(TextSpan(text: text, style: baseStyle));
      return spans;
    }

    int currentIndex = 0;
    for (final match in boldMatches) {
      // Text trước bold
      if (currentIndex < match.start) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: baseStyle,
        ));
      }

      // Bold text
      spans.add(TextSpan(
        text: match.group(1)!,
        style: baseStyle.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ));

      currentIndex = match.end;
    }

    // Text còn lại
    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
        style: baseStyle,
      ));
    }

    return spans;
  }
}

class _LatexMatch {
  final int start;
  final int end;
  final String type;
  final String content;

  _LatexMatch({
    required this.start,
    required this.end,
    required this.type,
    required this.content,
  });
}
