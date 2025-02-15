import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';

class LocalStorageService {
  static const String moviesBoxName = 'movies';
  static const String favoritesBoxName = 'favoriteMovieIds';
  late Box<Movie> _movieBox;
  late Box<int> _favoriteMovieIdsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieAdapter());
    _movieBox = await Hive.openBox<Movie>(moviesBoxName);
    _favoriteMovieIdsBox = await Hive.openBox<int>(favoritesBoxName);
  }

  Future<void> saveMovies(List<Movie> movies) async {
    await _movieBox.clear();
    await _movieBox.putAll(
      {for (var movie in movies) movie.id: movie},
    );
  }

  List<Movie> getAllMovies() {
    return _movieBox.values.toList();
  }

  List<int> getFavoriteMovieIds() {
    return _favoriteMovieIdsBox.values.toList();
  }

  Future<void> addFavoriteMovieId(int movieId) async {
    await _favoriteMovieIdsBox.add(movieId);
  }

  Future<void> removeFavoriteMovieId(int movieId) async {
    if (_favoriteMovieIdsBox.values.contains(movieId)) {
      int? keyToRemove = _favoriteMovieIdsBox.values.toList().indexOf(movieId);
      await _favoriteMovieIdsBox.deleteAt(keyToRemove);
    }
  }
}
