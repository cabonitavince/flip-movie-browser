import 'package:equatable/equatable.dart';

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
