import 'package:movie_browser/app/domain/entities/movie/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies({String language, int page});

  Future<List<Movie>> searchMovies(String query, {String language, int page});
}
