import 'package:flutter/material.dart';

class TimelineIndicator extends StatelessWidget {
  final bool completed;
  final bool isLast;

  const TimelineIndicator({
    super.key,
    required this.completed,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: double.infinity,
      child: CustomPaint(
        painter: _TimelinePainter(
          completed: completed,
          isLast: isLast,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: Center(
          child: Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? Colors.green : Colors.grey,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  final bool completed;
  final bool isLast;
  final Color color;

  _TimelinePainter({
    required this.completed,
    required this.isLast,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final top = Offset(centerX, 0);
    final bottom = Offset(centerX, size.height);

    // Vẽ từ trên xuống dưới (trừ nếu là phần tử cuối)
    canvas.drawLine(
      top,
      isLast ? Offset(centerX, size.height / 2) : bottom,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
