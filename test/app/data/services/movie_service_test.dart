import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie_browser/app/data/services/movie_service.dart';
import 'package:movie_browser/app/domain/entities/movie.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/utils/env_config.dart';

import 'movie_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late MovieService movieService;

  setUp(() async {
    await dotenv.load(fileName: '.env');
    mockHttpClient = MockClient();
    movieService = MovieService(httpClient: mockHttpClient);
  });

  group('MovieService->getPopularMovies', () {
    final tMovieJson = {
      'adult': false,
      'backdrop_path': '/test_backdrop.jpg',
      'genre_ids': [28, 12, 14],
      'id': 1,
      'original_language': 'en',
      'original_title': 'Test Movie Original',
      'overview': 'Test Overview',
      'popularity': 1000.0,
      'poster_path': '/test.jpg',
      'release_date': '2024-01-01',
      'title': 'Test Movie',
      'video': false,
      'vote_average': 7.5,
      'vote_count': 1000
    };

    final tMovie = Movie.fromJson(tMovieJson);

    // success case
    test('should return list of movies when API call is successful', () async {
      // Arrange
      final expectedUrl = Uri.parse('${EnvConfig.apiBaseUrl}/movie/popular')
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
            'results': [tMovie.toJson()],
          }),
          200));

      // Act
      final result = await movieService.getPopularMovies();

      // Assert
      expect(result, isA<List<Movie>>());
      expect(result.length, 1);
      expect(result.first, tMovie);

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
      ).thenThrow(SocketException('No internet connection'));

      // Act & Assert
      expect(() => movieService.getPopularMovies(),
          throwsA(isA<NetworkException>()));
    });
  });
}
