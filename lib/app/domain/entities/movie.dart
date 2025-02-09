import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  // mock data
  factory Movie.mock() => Movie(
        adult: false,
        backdropPath: '/test_backdrop.jpg',
        genreIds: const [28, 12, 14],
        id: 1,
        originalLanguage: 'en',
        originalTitle: 'Test Movie Original',
        overview: 'Test Overview',
        popularity: 1000.0,
        posterPath: '/test.jpg',
        releaseDate: '2024-01-01',
        title: 'Test Movie',
        video: false,
        voteAverage: 7.5,
        voteCount: 1000,
      );
}
