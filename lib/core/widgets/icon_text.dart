import 'package:flutter/material.dart';
import 'package:movie_browser/utils/constants.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String text;
  final TextStyle? textStyle;
  final MainAxisAlignment mainAxisAlignment;

  const IconText({
    super.key,
    required this.icon,
    this.iconColor = AppConstants.primaryColor,
    this.iconSize = 16.0,
    required this.text,
    this.textStyle,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: textStyle ??
              Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
        ),
      ],
    );
  }
}
