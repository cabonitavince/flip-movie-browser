import 'package:movie_browser/app/data/services/movie_service.dart';
import 'package:movie_browser/app/domain/entities/movie.dart';
import 'package:movie_browser/app/domain/repositories/movie_respository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieService _movieService;

  const MovieRepositoryImpl(this._movieService);

  @override
  Future<Movie> getMovie() {
    // TODO: implement getMovie
    throw UnimplementedError();
  }
}
