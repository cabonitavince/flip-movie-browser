import 'package:movie_browser/app/data/services/local_storage_service.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';

class GetCachedMoviesUseCase {
  final LocalStorageService _localStorageService;

  GetCachedMoviesUseCase(this._localStorageService);

  Future<List<Movie>> execute() async {
    return _localStorageService.getAllMovies();
  }
}
