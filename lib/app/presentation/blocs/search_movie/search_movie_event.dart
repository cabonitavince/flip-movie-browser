import 'package:equatable/equatable.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();
}

final class SearchMovieReset extends SearchMovieEvent {
  const SearchMovieReset();

  @override
  List<Object> get props => [];
}

final class SearchMovieQuery extends SearchMovieEvent {
  final String query;
  final String language;
  final int page;

  const SearchMovieQuery(this.query, {this.language = 'en-US', this.page = 1});

  @override
  List<Object?> get props => [query, language, page];
}
