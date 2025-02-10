import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_event.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_state.dart';
import 'package:movie_browser/core/enum/state_enum.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  MovieListBloc(this.getPopularMoviesUseCase)
      : super(MovieListState(status: StateEnum.initial)) {
    on<MovieListLoad>((event, emit) async {
      emit(state.copyWith(status: StateEnum.loading));

      try {
        final movies = await getPopularMoviesUseCase.execute(
            language: event.language, page: event.page);

        if (movies.isEmpty) {
          emit(state.copyWith(status: StateEnum.empty, movies: []));
        } else {
          emit(state.copyWith(status: StateEnum.loaded, movies: movies));
        }
      } catch (error) {
        if (error is NetworkException) {
          emit(state.copyWith(
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
  }
}
