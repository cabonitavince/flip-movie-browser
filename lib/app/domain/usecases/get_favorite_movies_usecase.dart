import 'package:movie_browser/app/data/services/local_storage_service.dart';

class GetFavoriteMoviesUseCase {
  final LocalStorageService _localStorageService;

  GetFavoriteMoviesUseCase(this._localStorageService);

  Future<List<int>> execute() async {
    return _localStorageService.getFavoriteMovieIds();
  }
}
