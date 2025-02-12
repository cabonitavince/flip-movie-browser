import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final EdgeInsetsGeometry padding;

  const GradientContainer({
    super.key,
    required this.child,
    this.colors = const [Colors.transparent, Colors.black87],
    this.padding =
        const EdgeInsets.only(top: 50, bottom: 16, left: 16, right: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}
