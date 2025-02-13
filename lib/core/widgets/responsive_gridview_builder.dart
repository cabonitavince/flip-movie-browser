import 'package:flutter/material.dart';
import 'package:movie_browser/utils/constants.dart';

class ResponsiveGridViewBuilder extends StatelessWidget {
  final int smallScreenCrossAxisCount;
  final int mediumScreenCrossAxisCount;
  final int largeScreenCrossAxisCount;
  final double childAspectRatio;
  final EdgeInsetsGeometry padding;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const ResponsiveGridViewBuilder({
    super.key,
    this.smallScreenCrossAxisCount = 2,
    this.mediumScreenCrossAxisCount = 4,
    this.largeScreenCrossAxisCount = 6,
    this.childAspectRatio = 0.6,
    this.padding = const EdgeInsets.all(16.0),
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        int crossAxisCount;
        if (constraints.maxWidth < AppConstants.smallScreenWidth) {
          crossAxisCount = smallScreenCrossAxisCount;
        } else if (constraints.maxWidth < AppConstants.mediumScreenWidth) {
          crossAxisCount = mediumScreenCrossAxisCount;
        } else {
          crossAxisCount = largeScreenCrossAxisCount;
        }

        return GridView.builder(
          padding: padding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}