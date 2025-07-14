import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

class CoverImageWidget extends StatefulWidget {
  final void Function() onPressed;

  const CoverImageWidget({super.key, required this.onPressed});

  @override
  _CoverImageWidgetState createState() => _CoverImageWidgetState();
}

class _CoverImageWidgetState extends State<CoverImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    // _animation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final containerWidth = screenWidth * 0.75;
    final containerHeight =
        containerWidth * (290 / 384); // Maintain aspect ratio
    final imageHeight = containerWidth * (257 / 384); // Scale image height
    final buttonWidth = containerWidth * (250 / 384); // Scale button width
    final buttonHeight = containerHeight * (34 / 260); // Scale button height

    final fontSize = buttonWidth * (16 / 250);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Layer 0: Container
        Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inverseSurface,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        // Layer 1: Image
        Positioned(
          top: 0,
          child: Column(
            children: [
              Image.asset(
                'assets/images/cover.jpeg',
                width: containerWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        // Layer 2: Button "Học toán hàng ngày với Mela"
        Positioned(
          bottom: containerHeight * (10 / 290),
          child: SizedBox(
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
              ),
              child: Text(
                'Học toán hàng ngày với Mela',
                style: Theme.of(context).textTheme.subTitle.copyWith(
                      color: Colors.white,
                      fontSize: fontSize,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
