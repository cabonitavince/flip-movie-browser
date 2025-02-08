import 'package:http/http.dart' as http;
import 'package:movie_browser/app/domain/entities/movie.dart';

class MovieService {
  final http.Client httpClient;

  MovieService({required this.httpClient});

  Future<List<Movie>> getMovies() async {
    // TODO: implement getMovie
    throw UnimplementedError();
  }

}