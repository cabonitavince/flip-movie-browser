import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/domain/repositories/movie_respository.dart';

class GetPopularMoviesUseCase {
  final MovieRepository _movieRepository;

  GetPopularMoviesUseCase(this._movieRepository);

  Future<List<Movie>> execute({String language = 'en-US', int page = 1}) async {
    try {
      return await _movieRepository.getPopularMovies(
          language: language, page: page);
    } catch (e) {
      rethrow;
    }
  }
}
