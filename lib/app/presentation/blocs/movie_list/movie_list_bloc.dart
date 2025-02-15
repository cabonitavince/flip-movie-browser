import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/app/domain/usecases/add_favorite_movie_usecase.dart';
import 'package:movie_browser/app/domain/usecases/get_cached_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/get_favorite_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/remove_favorite_movie_usecase.dart';
import 'package:movie_browser/app/domain/usecases/save_movies_to_cache_usecase.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_event.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_state.dart';
import 'package:movie_browser/core/enum/state_enum.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final SaveMoviesToCacheUseCase saveMoviesToCacheUseCase;
  final GetCachedMoviesUseCase getCachedMoviesUseCase;
  final AddFavoriteMovieUseCase addFavoriteMovieUseCase;
  final RemoveFavoriteMovieUseCase removeFavoriteMovieUseCase;
  final GetFavoriteMoviesUseCase getFavoriteMoviesUseCase;

  MovieListBloc(
      this.getPopularMoviesUseCase,
      this.saveMoviesToCacheUseCase,
      this.getCachedMoviesUseCase,
      this.addFavoriteMovieUseCase,
      this.removeFavoriteMovieUseCase,
      this.getFavoriteMoviesUseCase)
      : super(const MovieListState(status: StateEnum.initial)) {
    on<MovieListLoad>((event, emit) async {
      emit(state.copyWith(status: StateEnum.loading));
      List<int> favoriteMovies = await getFavoriteMoviesUseCase.execute();

      try {
        List<Movie> movies = await getPopularMoviesUseCase.execute(
            language: event.language, page: event.page);

        if (movies.isEmpty) {
          emit(state.copyWith(status: StateEnum.empty, movies: []));
        } else {
          final List<Movie> updatedMovies =
              _updateMoviesWithFavorite(movies, favoriteMovies);
          await saveMoviesToCacheUseCase.execute(updatedMovies);
          emit(state.copyWith(status: StateEnum.loaded, movies: updatedMovies));
        }
      } catch (error) {
        if (error is NetworkException) {
          // get from cache if theres no internet
          List<Movie> movies = await getCachedMoviesUseCase.execute();
          emit(state.copyWith(
              movies: _updateMoviesWithFavorite(movies, favoriteMovies),
              status: StateEnum.noInternet,
              errorMessage: 'No internet connection'));
        } else if (error is ServiceException) {
          emit(state.copyWith(
              status: StateEnum.error, errorMessage: 'Service Unavailable'));
        } else {
          emit(state.copyWith(
              status: StateEnum.error, errorMessage: 'Something Went Wrong!'));
        }
      }
    });
    on<MovieListToggleFavorite>((event, emit) async {
      List<Movie> updatedMovies = state.movies.map((movie) {
        if (movie.id == event.movie.id) {
          return movie.copyWith(isFavorite: event.isFavorite);
        }
        return movie;
      }).toList();
      if (event.isFavorite) {
        await addFavoriteMovieUseCase.execute(event.movie.id ?? 0);
      } else {
        await removeFavoriteMovieUseCase.execute(event.movie.id ?? 0);
      }

      emit(state.copyWith(movies: updatedMovies));
    });
  }

  List<Movie> _updateMoviesWithFavorite(
      List<Movie> movies, List<int> favoriteMovies) {
    return movies.map((movie) {
      if (favoriteMovies.contains(movie.id)) {
        return movie.copyWith(isFavorite: true);
      }
      return movie;
    }).toList();
  }
}
