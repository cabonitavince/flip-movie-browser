import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;
  final Duration? fadeOutDuration;
  final Duration fadeInDuration;
  final double? height;
  final double? width;

  const AppImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.fadeOutDuration,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
      fadeOutDuration: fadeOutDuration,
      fadeInDuration: fadeInDuration,
      height: height,
      width: width,
    );
  }
}
