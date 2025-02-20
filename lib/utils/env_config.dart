import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get bearerToken => dotenv.env['BEARER_TOKEN'] ?? '';
  static String get movieImageBaseUrl => dotenv.env['MOVIE_IMAGE_BASE_URL'] ?? '';
  static String get moviePopularUrl => dotenv.env['MOVIE_POPULAR_URL'] ?? '';
  static String get movieSearchUrl => dotenv.env['MOVIE_SEARCH_URL'] ?? '';
}