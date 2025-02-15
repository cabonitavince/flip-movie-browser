import 'package:movie_browser/app/domain/entities/api_response/api_response.dart';
import 'package:movie_browser/utils/api_util.dart';
import 'package:movie_browser/utils/env_config.dart';

class MovieService {
  final ApiUtil apiUtil;

  MovieService({required this.apiUtil});

  Future<Map<String, dynamic>> getPopularMovies(
      {String language = 'en-US', int page = 1}) async {
    ApiResponse response = await apiUtil
        .makeApiRequest(EnvConfig.moviePopularUrl, queryParameters: {
      'language': language,
      'page': page.toString(),
    });

    return response.responseBody;
  }

  Future<Map<String, dynamic>> searchMovies(String query,
      {String language = 'en-US', int page = 1}) async {
    ApiResponse response = await apiUtil
        .makeApiRequest(EnvConfig.movieSearchUrl, queryParameters: {
      'query': query,
      'language': language,
      'page': page.toString(),
    });

    return response.responseBody;
  }
}
