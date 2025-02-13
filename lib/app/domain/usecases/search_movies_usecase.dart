import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/domain/repositories/movie_respository.dart';

class SearchMoviesUseCase {
  final MovieRepository _movieRepository;

  SearchMoviesUseCase(this._movieRepository);

  Future<List<Movie>> execute(String query,
      {String language = 'en-US', int page = 1}) async {
    try {
      return await _movieRepository.searchMovies(query,
          language: language, page: page);
    } catch (e) {
      rethrow;
    }
  }
}
