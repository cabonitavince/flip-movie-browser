import 'package:equatable/equatable.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/core/enum/state_enum.dart';

class SearchMovieState extends Equatable {
  final StateEnum status;
  final List<Movie> result;
  final String? errorMessage;

  const SearchMovieState({
    required this.status,
    this.result = const [],
    this.errorMessage,
  });

  SearchMovieState copyWith({
    StateEnum? status,
    List<Movie>? result,
    String? errorMessage,
  }) {
    return SearchMovieState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}
