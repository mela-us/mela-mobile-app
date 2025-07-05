import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/stats_topic_personal/widgets/markdown_content_converter.dart';

import '../../../constants/assets.dart';
import '../../../domain/entity/stat/detailed_stat.dart';

class ExpandableTile extends StatefulWidget {

  final DetailedStat detailedStat;

  const ExpandableTile({
    super.key,
    required this.detailedStat,
  });

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final double excellence = widget.detailedStat.excellence;
    final String title = widget.detailedStat.topic;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        tilePadding: const EdgeInsets.symmetric(horizontal: 12.0),
        title: Text(
          title,
          style: Theme.of(context).textTheme.subTitle.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              parseExellence(excellence),
              style: Theme.of(context).textTheme.miniCaption.copyWith(
                color: parseExellenceColor(excellence, context),
              ),
            ),
            const SizedBox(width: 8.0),
            Image.asset(
              _isExpanded ? Assets.stats_hide : Assets.stats_show,
              width: 12,
              height: 12,
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: MarkdownContentConverter(rawText: "ộ i i"),
          ),
        ],
      ),
    );
  }
}

String parseExellence(double ex) {
  if (ex < 50) return "Chưa đạt";
  if (ex <= 65) return "Trung bình";
  if (ex < 80) return "Khá";
  if (ex < 90) return "Tốt";
  return "Rất Tốt";
}

Color parseExellenceColor(double ex, BuildContext context) {
  if (ex < 50) return Colors.red;
  if (ex <= 65) return Colors.orange;
  if (ex < 80) return Colors.lightGreen;
  if (ex < 90) return Colors.teal;
  return Theme.of(context).colorScheme.onTertiary;
}
