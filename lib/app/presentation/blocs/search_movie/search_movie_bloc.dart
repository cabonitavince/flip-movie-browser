import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/domain/exceptions/network_exception.dart';
import 'package:movie_browser/app/domain/exceptions/service_exception.dart';
import 'package:movie_browser/app/domain/usecases/search_movies_usecase.dart';
import 'package:movie_browser/app/presentation/blocs/search_movie/search_movie_event.dart';
import 'package:movie_browser/app/presentation/blocs/search_movie/search_movie_state.dart';
import 'package:movie_browser/core/enum/state_enum.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  SearchMovieBloc(this.searchMoviesUseCase)
      : super(const SearchMovieState(status: StateEnum.initial)) {
    on<SearchMovieReset>((event, emit) async {
      emit(const SearchMovieState(status: StateEnum.initial));
    });
    on<SearchMovieQuery>((event, emit) async {
      emit(state.copyWith(status: StateEnum.searching));

      try {
        final result = await searchMoviesUseCase.execute(event.query,
            language: event.language, page: event.page);

        if (result.isEmpty) {
          emit(state.copyWith(status: StateEnum.empty, result: []));
        } else {
          emit(state.copyWith(status: StateEnum.success, result: result));
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
