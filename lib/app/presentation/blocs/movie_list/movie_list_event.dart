import 'package:equatable/equatable.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();
}

final class MovieListLoad extends MovieListEvent {
  final String language;
  final int page;

  const MovieListLoad({this.language = 'en-US', this.page = 1});

  @override
  List<Object?> get props => [language, page];
}

final class MovieListToggleFavorite extends MovieListEvent {
  final Movie movie;
  final bool isFavorite;
  const MovieListToggleFavorite(this.movie, this.isFavorite);

  @override
  List<Object> get props => [movie];
}


