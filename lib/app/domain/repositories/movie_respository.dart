import 'package:movie_browser/app/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies({String language, int page});
}
