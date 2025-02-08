import 'package:movie_browser/app/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Movie> getMovie();
}
