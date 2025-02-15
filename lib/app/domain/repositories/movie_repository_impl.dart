import 'package:movie_browser/app/data/services/movie_service.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/domain/exceptions/impl_exception.dart';
import 'package:movie_browser/app/domain/exceptions/invalid_api_response_exception.dart';
import 'package:movie_browser/app/domain/repositories/movie_respository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieService _movieService;

  const MovieRepositoryImpl(this._movieService);

  Future<List<Movie>> _fetchMovies(Future<Map<String, dynamic>> future) async {
    final value = await future;
    try {
      if (value.containsKey('results')) {
        final results = value['results'] as List<dynamic>;
        return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        throw InvalidApiResponseException('Invalid API response format');
      }
    } on InvalidApiResponseException {
      rethrow;
    } catch (e) {
      throw ImplException('Error occurred while fetching movies');
    }
  }

  @override
  Future<List<Movie>> getPopularMovies(
      {String language = 'en-US', int page = 1}) async {
    return _fetchMovies(
        _movieService.getPopularMovies(language: language, page: page));
  }

  @override
  Future<List<Movie>> searchMovies(String query,
      {String language = 'en-US', int page = 1}) async {
    return _fetchMovies(
        _movieService.searchMovies(query, language: language, page: page));
  }
}
