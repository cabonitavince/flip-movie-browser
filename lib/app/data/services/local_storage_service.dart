import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';

class LocalStorageService {
  static const String boxName = 'movies';
  late Box<Movie> _movieBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieAdapter());
    _movieBox = await Hive.openBox<Movie>(boxName);
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

  Future<void> clearAll() async {
    await _movieBox.clear();
  }
}
