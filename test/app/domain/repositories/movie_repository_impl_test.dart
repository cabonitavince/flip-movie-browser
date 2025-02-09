import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_browser/app/data/services/movie_service.dart';
import 'package:movie_browser/app/domain/entities/movie.dart';
import 'package:movie_browser/app/domain/exceptions/invalid_api_response_exception.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/app/domain/repositories/movie_repository_impl.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateMocks([MovieService])
void main() {
  late MockMovieService mockMovieService;
  late MovieRepositoryImpl movieRepository;

  setUp(() {
    mockMovieService = MockMovieService();
    movieRepository = MovieRepositoryImpl(mockMovieService);
  });

  group('MovieRepositoryImpl - getPopularMovies', () {
    final tMovieJson = {
      'adult': false,
      'backdrop_path': '/test_backdrop.jpg',
      'genre_ids': [1, 2, 3],
      'id': 1,
      'original_language': 'en',
      'original_title': 'Test Movie',
      'overview': 'Test overview',
      'popularity': 10.0,
      'poster_path': '/test_poster.jpg',
      'release_date': '2024-01-01',
      'title': 'Test Movie',
      'video': false,
      'vote_average': 7.5,
      'vote_count': 100,
    };
    final tMovie = Movie.fromJson(tMovieJson);

    test('should return list of movies when MovieService call is successful',
        () async {
      // Arrange
      when(mockMovieService.getPopularMovies()).thenAnswer((_) async => {
            'results': [tMovieJson]
          });

      // Act
      final result = await movieRepository.getPopularMovies();

      // Assert
      expect(result, isA<List<Movie>>());
      expect(result.length, 1);
      expect(result.first, tMovie);
      verify(mockMovieService.getPopularMovies()).called(1);
    });

    test(
        'should throw NetworkException when MovieService throws NetworkException',
        () async {
      // Arrange
      when(mockMovieService.getPopularMovies())
          .thenThrow(NetworkException('No internet'));

      // Act & Assert
      expect(() => movieRepository.getPopularMovies(),
          throwsA(isA<NetworkException>()));
      verify(mockMovieService.getPopularMovies()).called(1);
    });

    test(
        'should throw ServiceException when MovieService throws ServiceException',
        () async {
      // Arrange
      when(mockMovieService.getPopularMovies())
          .thenThrow(ServiceException('API Error', statusCode: 400));

      // Act & Assert
      expect(() => movieRepository.getPopularMovies(),
          throwsA(isA<ServiceException>()));
      verify(mockMovieService.getPopularMovies()).called(1);
    });

    test(
        'should throw InvalidApiResponseException when API response format is invalid',
        () async {
      // Arrange
      when(mockMovieService.getPopularMovies())
          .thenAnswer((_) async => {'invalid_key': 'invalid_value'});

      // Act & Assert
      expect(() => movieRepository.getPopularMovies(),
          throwsA(isA<InvalidApiResponseException>()));
      verify(mockMovieService.getPopularMovies()).called(1);
    });
  });
}
