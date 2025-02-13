import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie_browser/app/data/services/movie_service.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/utils/api_util.dart'; // Import ApiUtil
import 'package:movie_browser/utils/env_config.dart';

import 'movie_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late ApiUtil apiUtil;
  late MovieService movieService;

  setUp(() async {
    await dotenv.load(fileName: '.env');
    mockHttpClient = MockClient();
    apiUtil = ApiUtil(httpClient: mockHttpClient);
    movieService = MovieService(apiUtil: apiUtil);
  });

  group('MovieService->getPopularMovies', () {
    final tMovieJson = Movie.mock().toJson();

    // success case
    test('should return list of movies when API call is successful', () async {
      // Arrange
      final expectedUrl =
          Uri.parse('${EnvConfig.apiBaseUrl}${EnvConfig.moviePopularUrl}')
              .replace(queryParameters: {
        'language': 'en-US',
        'page': '1',
      });
      final headers = {
        'Authorization': 'Bearer ${EnvConfig.bearerToken}',
        'accept': 'application/json',
      };

      when(
        mockHttpClient.get(
          expectedUrl,
          headers: headers,
        ),
      ).thenAnswer((_) async => http.Response(
          json.encode({
            'results': [tMovieJson],
          }),
          200));

      // Act
      final result = await movieService.getPopularMovies();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['results'], isA<List<dynamic>>());
      expect(result['results'].length, 1);
      expect(result['results'].first, tMovieJson);

      verify(
        mockHttpClient.get(
          expectedUrl,
          headers: headers,
        ),
      );
    });

    // service exception case
    test('should throw ServiceException when API returns error status code',
        () async {
      // Arrange
      when(
        mockHttpClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response('Error message', 404));

      // Act & Assert
      expect(() => movieService.getPopularMovies(),
          throwsA(isA<ServiceException>()));
    });

    // network exception case
    test('should throw NetworkException when there is no internet connection',
        () async {
      // Arrange
      when(
        mockHttpClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenThrow(const SocketException('No internet connection'));

      // Act & Assert
      expect(() => movieService.getPopularMovies(),
          throwsA(isA<NetworkException>()));
    });
  });
}
