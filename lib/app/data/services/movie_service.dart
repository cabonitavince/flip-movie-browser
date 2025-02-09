import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/utils/app_logger.dart';
import 'package:movie_browser/utils/env_config.dart';

class MovieService {
  final http.Client httpClient;

  MovieService({required this.httpClient});

  Future<Map<String, dynamic>> getPopularMovies(
      {String language = 'en-US', int page = 1}) async {
    final Uri uri = Uri.parse('${EnvConfig.apiBaseUrl}/movie/popular').replace(
      queryParameters: {
        'language': language,
        'page': page.toString(),
      },
    );

    final headers = {
      'Authorization': 'Bearer ${EnvConfig.bearerToken}',
      'accept': 'application/json',
    };

    try {
      final response = await httpClient.get(uri, headers: headers);

      if (response.statusCode == 200) {
        AppLogger.i('Fetched popular movies', stackTrace: StackTrace.current);
        return jsonDecode(response.body);
      } else {
        AppLogger.e(
            'Error fetching movies: ${response.reasonPhrase} '
            '(${response.statusCode})',
            stackTrace: StackTrace.current);
        throw ServiceException(response.reasonPhrase ?? 'Unknown error',
            statusCode: response.statusCode);
      }
    } on SocketException {
      throw NetworkException('No internet connection');
    } on ServiceException {
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
