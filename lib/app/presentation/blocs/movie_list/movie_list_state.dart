import 'package:equatable/equatable.dart';
import 'package:movie_browser/app/domain/entities/movie.dart';
import 'package:movie_browser/core/enum/state_enum.dart';

class MovieListState extends Equatable {
  final StateEnum status;
  final List<Movie> movies;
  final String? errorMessage;

  const MovieListState({
    required this.status,
    this.movies = const [],
    this.errorMessage,
  });

  MovieListState copyWith({
    StateEnum? status,
    List<Movie>? movies,
    String? errorMessage,
  }) {
    return MovieListState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, movies, errorMessage];
}
