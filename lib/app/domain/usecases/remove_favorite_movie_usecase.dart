import 'package:movie_browser/app/data/services/local_storage_service.dart';

class RemoveFavoriteMovieUseCase {
  final LocalStorageService _localStorageService;

  RemoveFavoriteMovieUseCase(this._localStorageService);

  Future<void> execute(int movieId) async {
    return _localStorageService.removeFavoriteMovieId(movieId);
  }
}
