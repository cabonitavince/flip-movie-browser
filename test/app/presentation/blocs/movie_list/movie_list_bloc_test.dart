import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_browser/app/domain/entities/movie.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_event.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_state.dart';
import 'package:movie_browser/core/enum/state_enum.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMoviesUseCase])
void main() {
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;

  setUp(() {
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
  });

  final tMovies = [Movie.mock()];

  group('MovieListBloc - MovieListLoad', () {
    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and loaded states when use case is successful',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenAnswer((_) async => tMovies);
        return MovieListBloc(mockGetPopularMoviesUseCase);
      },
      act: (bloc) => bloc.add(MovieListLoad()),
      expect: () => [
        MovieListState(status: StateEnum.loading),
        MovieListState(status: StateEnum.loaded, movies: tMovies),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and empty states when use case returns empty list',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenAnswer((_) async => <Movie>[]);
        return MovieListBloc(mockGetPopularMoviesUseCase);
      },
      act: (bloc) => bloc.add(MovieListLoad()),
      expect: () => [
        MovieListState(status: StateEnum.loading),
        MovieListState(status: StateEnum.empty, movies: []),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and noInternet states when use case throws NetworkException',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenThrow(NetworkException('No internet'));
        return MovieListBloc(mockGetPopularMoviesUseCase);
      },
      act: (bloc) => bloc.add(MovieListLoad()),
      expect: () => [
        MovieListState(status: StateEnum.loading),
        MovieListState(
            status: StateEnum.noInternet,
            errorMessage: 'No internet connection'),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and error states when use case throws ServiceException',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenThrow(ServiceException('Service Unavailable'));
        return MovieListBloc(mockGetPopularMoviesUseCase);
      },
      act: (bloc) => bloc.add(MovieListLoad()),
      expect: () => [
        MovieListState(status: StateEnum.loading),
        MovieListState(
            status: StateEnum.error, errorMessage: 'Service Unavailable'),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit loading and error states when use case throws generic Exception',
      build: () {
        when(mockGetPopularMoviesUseCase.execute(language: 'en-US', page: 1))
            .thenThrow(Exception('Something Went Wrong!'));
        return MovieListBloc(mockGetPopularMoviesUseCase);
      },
      act: (bloc) => bloc.add(MovieListLoad()),
      expect: () => [
        MovieListState(status: StateEnum.loading),
        MovieListState(
            status: StateEnum.error, errorMessage: 'Something Went Wrong!'),
      ],
    );
  });
}
