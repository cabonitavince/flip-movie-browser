import 'package:movie_browser/app/data/services/local_storage_service.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';

class SaveMoviesToCacheUseCase {
  final LocalStorageService _localStorageService;

  SaveMoviesToCacheUseCase(this._localStorageService);

  Future<void> execute(List<Movie> movies) async {
    return _localStorageService.saveMovies(movies);
  }
}
