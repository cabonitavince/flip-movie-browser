import 'package:movie_browser/app/data/services/movie_service.dart';
import 'package:movie_browser/app/domain/entities/movie.dart';
import 'package:movie_browser/app/domain/exceptions/impl_exception.dart';
import 'package:movie_browser/app/domain/exceptions/invalid_api_response_exception.dart';
import 'package:movie_browser/app/domain/repositories/movie_respository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieService _movieService;

  const MovieRepositoryImpl(this._movieService);

  @override
  Future<List<Movie>> getPopularMovies({String language = 'en-US', int page = 1}) async {
    final value = await _movieService.getPopularMovies(language: language, page: page);
    try {
      if (value.containsKey('results')) {
        final results = value['results'] as List<dynamic>;
        final movies =
            results.map((movieJson) => Movie.fromJson(movieJson)).toList();
        return movies;
      } else {
        throw InvalidApiResponseException('Invalid API response format');
      }
    } on InvalidApiResponseException {
      rethrow;
    } catch (e) {
      throw ImplException('Error occurred while fetching popular movies');
    }
  }
}
