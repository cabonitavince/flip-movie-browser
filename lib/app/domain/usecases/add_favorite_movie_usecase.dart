import 'package:movie_browser/app/data/services/local_storage_service.dart';

class AddFavoriteMovieUseCase {
  final LocalStorageService _localStorageService;

  AddFavoriteMovieUseCase(this._localStorageService);

  Future<void> execute(int movieId) async {
    return _localStorageService.addFavoriteMovieId(movieId);
  }
}
