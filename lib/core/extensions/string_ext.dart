import 'package:movie_browser/utils/env_config.dart';

extension StringExt on String? {
  String get absoluteImageUrlW500 =>
      '${EnvConfig.movieImageBaseUrl}/w500${this ?? ''}';

  String get absoluteImageUrlOriginal =>
      '${EnvConfig.movieImageBaseUrl}/original${this ?? ''}';

  String get yearFromDate {
    if (this == null || this!.isEmpty) return "";

    final parts = this!.split('-');
    if (parts.isNotEmpty) {
      final year = int.tryParse(parts[0]);
      if (year != null) {
        return parts[0];
      }
    }
    return "";
  }
}
