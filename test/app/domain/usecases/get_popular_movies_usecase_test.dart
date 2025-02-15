import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/repositories/movie_respository.dart';
import 'package:movie_browser/app/domain/usecases/get_popular_movies_usecase.dart';

import 'get_popular_movies_usecase_test.mocks.dart';


@GenerateMocks([MovieRepository])
void main() {
  late MockMovieRepository mockMovieRepository;
  late GetPopularMoviesUseCase useCase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    useCase = GetPopularMoviesUseCase(mockMovieRepository);
  });

  group('GetPopularMoviesUseCase - execute', () {
    final tMovie = Movie.mock();
    final tMovies = [tMovie];

    test('should get popular movies from the repository', () async {
      // Arrange
      when(mockMovieRepository.getPopularMovies(
          language: 'en-US', page: 1))
          .thenAnswer((_) async => tMovies);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, tMovies);
      verify(mockMovieRepository.getPopularMovies(
          language: 'en-US', page: 1)).called(1);
    });

    test('should get popular movies from the repository with custom values',
            () async {
          // Arrange
          when(mockMovieRepository.getPopularMovies(
              language: 'es-ES', page: 2))
              .thenAnswer((_) async => tMovies);

          // Act
          final result = await useCase.execute(language: 'es-ES', page: 2);

          // Assert
          expect(result, tMovies);
          verify(mockMovieRepository.getPopularMovies(
              language: 'es-ES', page: 2)).called(1);
        });

    test('should throw exception from the repository', () async {
      // Arrange
      when(mockMovieRepository.getPopularMovies(
          language: 'en-US', page: 1))
          .thenThrow(NetworkException('No internet'));

      // Act & Assert
      expect(() => useCase.execute(), throwsA(isA<NetworkException>()));
      verify(mockMovieRepository.getPopularMovies(
          language: 'en-US', page: 1)).called(1);
    });
  });
}