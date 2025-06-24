import 'package:flutter/cupertino.dart';

class UnderlineIndicator extends Decoration {
  final double width;
  final double height;
  final Color color;

  const UnderlineIndicator({
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _FixedWidthUnderlinePainter(width, height, color);
  }
}

class _FixedWidthUnderlinePainter extends BoxPainter {
  final double width;
  final double height;
  final Paint _paint;

  _FixedWidthUnderlinePainter(this.width, this.height, Color color)
      : _paint = Paint()
    ..color = color
    ..strokeWidth = height
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration config) {
    final double tabCenter = offset.dx + config.size!.width / 2;
    final double y = offset.dy + config.size!.height - height / 2 - 10;
    final double startX = tabCenter - width / 2;
    final double endX = tabCenter + width / 2;

    canvas.drawLine(Offset(startX, y), Offset(endX, y), _paint);
  }
}
