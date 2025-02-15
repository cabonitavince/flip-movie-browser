import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/app/domain/usecases/add_favorite_movie_usecase.dart';
import 'package:movie_browser/app/domain/usecases/get_cached_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/get_favorite_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/remove_favorite_movie_usecase.dart';
import 'package:movie_browser/app/domain/usecases/save_movies_to_cache_usecase.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_event.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_state.dart';
import 'package:movie_browser/core/enum/state_enum.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularMoviesUseCase,
  SaveMoviesToCacheUseCase,
  GetCachedMoviesUseCase,
  AddFavoriteMovieUseCase,
  RemoveFavoriteMovieUseCase,
  GetFavoriteMoviesUseCase
])
void main() {
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late MockSaveMoviesToCacheUseCase mockSaveMoviesToCacheUseCase;
  late MockGetCachedMoviesUseCase mockGetCachedMoviesUseCase;
  late MockAddFavoriteMovieUseCase mockAddFavoriteMovieUseCase;
  late MockRemoveFavoriteMovieUseCase mockRemoveFavoriteMovieUseCase;
  late MockGetFavoriteMoviesUseCase mockGetFavoriteMoviesUseCase;

  setUp(() {
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    mockSaveMoviesToCacheUseCase = MockSaveMoviesToCacheUseCase();
    mockGetCachedMoviesUseCase = MockGetCachedMoviesUseCase();
    mockAddFavoriteMovieUseCase = MockAddFavoriteMovieUseCase();
    mockRemoveFavoriteMovieUseCase = MockRemoveFavoriteMovieUseCase();
    mockGetFavoriteMoviesUseCase = MockGetFavoriteMoviesUseCase();
  });

  final tMovies = [Movie.mock()];
  final tFavoriteMovies = [1];

  group('MovieListBloc - MovieListLoad', () {
    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and loaded states when use case is successful',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenAnswer((_) async => tMovies);
        when(mockGetFavoriteMoviesUseCase.execute())
            .thenAnswer((_) async => tFavoriteMovies);
        return MovieListBloc(
            mockGetPopularMoviesUseCase,
            mockSaveMoviesToCacheUseCase,
            mockGetCachedMoviesUseCase,
            mockAddFavoriteMovieUseCase,
            mockRemoveFavoriteMovieUseCase,
            mockGetFavoriteMoviesUseCase);
      },
      act: (bloc) => bloc.add(const MovieListLoad()),
      expect: () => [
        const MovieListState(status: StateEnum.loading),
        MovieListState(
            status: StateEnum.loaded,
            movies: tMovies
                .map((movie) => movie.copyWith(isFavorite: true))
                .toList()),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and empty states when use case returns empty list',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenAnswer((_) async => <Movie>[]);
        when(mockGetFavoriteMoviesUseCase.execute())
            .thenAnswer((_) async => tFavoriteMovies);
        return MovieListBloc(
            mockGetPopularMoviesUseCase,
            mockSaveMoviesToCacheUseCase,
            mockGetCachedMoviesUseCase,
            mockAddFavoriteMovieUseCase,
            mockRemoveFavoriteMovieUseCase,
            mockGetFavoriteMoviesUseCase);
      },
      act: (bloc) => bloc.add(const MovieListLoad()),
      expect: () => [
        const MovieListState(status: StateEnum.loading),
        const MovieListState(status: StateEnum.empty, movies: []),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and noInternet states when use case throws NetworkException and get cached movies',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenThrow(NetworkException('No internet'));
        when(mockGetCachedMoviesUseCase.execute())
            .thenAnswer((_) async => tMovies);
        when(mockGetFavoriteMoviesUseCase.execute())
            .thenAnswer((_) async => tFavoriteMovies);
        return MovieListBloc(
            mockGetPopularMoviesUseCase,
            mockSaveMoviesToCacheUseCase,
            mockGetCachedMoviesUseCase,
            mockAddFavoriteMovieUseCase,
            mockRemoveFavoriteMovieUseCase,
            mockGetFavoriteMoviesUseCase);
      },
      act: (bloc) => bloc.add(const MovieListLoad()),
      expect: () => [
        const MovieListState(status: StateEnum.loading),
        MovieListState(
            status: StateEnum.noInternet,
            movies: tMovies
                .map((movie) => movie.copyWith(isFavorite: true))
                .toList(),
            errorMessage: 'No internet connection'),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and error states when use case throws ServiceException',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenThrow(ServiceException('Service Unavailable'));
        when(mockGetFavoriteMoviesUseCase.execute())
            .thenAnswer((_) async => tFavoriteMovies);
        return MovieListBloc(
            mockGetPopularMoviesUseCase,
            mockSaveMoviesToCacheUseCase,
            mockGetCachedMoviesUseCase,
            mockAddFavoriteMovieUseCase,
            mockRemoveFavoriteMovieUseCase,
            mockGetFavoriteMoviesUseCase);
      },
      act: (bloc) => bloc.add(const MovieListLoad()),
      expect: () => [
        const MovieListState(status: StateEnum.loading),
        const MovieListState(
            status: StateEnum.error, errorMessage: 'Service Unavailable'),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and error states when use case throws generic Exception',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenThrow(Exception('Something Went Wrong!'));
        when(mockGetFavoriteMoviesUseCase.execute())
            .thenAnswer((_) async => tFavoriteMovies);
        return MovieListBloc(
            mockGetPopularMoviesUseCase,
            mockSaveMoviesToCacheUseCase,
            mockGetCachedMoviesUseCase,
            mockAddFavoriteMovieUseCase,
            mockRemoveFavoriteMovieUseCase,
            mockGetFavoriteMoviesUseCase);
      },
      act: (bloc) => bloc.add(const MovieListLoad()),
      expect: () => [
        const MovieListState(status: StateEnum.loading),
        const MovieListState(
            status: StateEnum.error, errorMessage: 'Something Went Wrong!'),
      ],
    );
  });

  group('MovieListBloc - MovieListToggleFavorite', () {
    blocTest<MovieListBloc, MovieListState>(
      'should add movie to favorites when MovieListToggleFavorite is added with isFavorite true',
      build: () {
        when(mockAddFavoriteMovieUseCase.execute(any))
            .thenAnswer((_) async => {});
        return MovieListBloc(
            mockGetPopularMoviesUseCase,
            mockSaveMoviesToCacheUseCase,
            mockGetCachedMoviesUseCase,
            mockAddFavoriteMovieUseCase,
            mockRemoveFavoriteMovieUseCase,
            mockGetFavoriteMoviesUseCase);
      },
      seed: () => MovieListState(status: StateEnum.loaded, movies: tMovies),
      act: (bloc) => bloc.add(MovieListToggleFavorite(tMovies.first, true)),
      expect: () => [
        MovieListState(
            status: StateEnum.loaded,
            movies: tMovies
                .map((movie) => movie.copyWith(isFavorite: true))
                .toList()),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should remove movie from favorites when MovieListToggleFavorite is added with isFavorite false',
      build: () {
        when(mockRemoveFavoriteMovieUseCase.execute(any))
            .thenAnswer((_) async => {});
        return MovieListBloc(
            mockGetPopularMoviesUseCase,
            mockSaveMoviesToCacheUseCase,
            mockGetCachedMoviesUseCase,
            mockAddFavoriteMovieUseCase,
            mockRemoveFavoriteMovieUseCase,
            mockGetFavoriteMoviesUseCase);
      },
      seed: () => MovieListState(
          status: StateEnum.loaded,
          movies: tMovies
              .map((movie) => movie.copyWith(isFavorite: true))
              .toList()),
      act: (bloc) => bloc.add(MovieListToggleFavorite(tMovies.first, false)),
      expect: () => [
        MovieListState(
            status: StateEnum.loaded,
            movies: tMovies
                .map((movie) => movie.copyWith(isFavorite: false))
                .toList()),
      ],
    );
  });
}
