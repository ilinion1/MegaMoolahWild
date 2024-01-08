import 'package:flutter/material.dart';
import 'package:mega_moolah/src/common/app_colors.dart';

class OutlinedText extends StatelessWidget {
  const OutlinedText({
    super.key,
    required this.text,
    required this.textStyle,
    this.strokeWidth = 5,
  });

  final String text;
  final TextStyle textStyle;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: textStyle.merge(
            TextStyle(
              letterSpacing: 1,
              fontFamily: 'Luckiest Guy',
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeCap = StrokeCap.round
                ..strokeWidth = strokeWidth
                ..color = AppColors.mainColor,
            ),
          ),
        ),
        Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: textStyle.merge(
            const TextStyle(
              letterSpacing: 1,
              fontFamily: 'Luckiest Guy',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
