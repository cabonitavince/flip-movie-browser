import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  bool? adult;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;
  int? id;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  String? overview;
  double? popularity;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  String? title;
  bool? video;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);


  // Mock data factory (optional, but highly recommended for testing)
  factory Movie.mock() => Movie(
    adult: false,
    backdropPath: "/test_backdrop.jpg",
    genreIds: const [28, 12, 14],
    id: 1,
    originalLanguage: "en",
    originalTitle: "Test Movie Original",
    overview: "Test Overview",
    popularity: 1000.0,
    posterPath: "/test.jpg",
    releaseDate: "2024-01-01", // Mock date as String to match API format
    title: "Test Movie",
    video: false,
    voteAverage: 7.5,
    voteCount: 1000,
  );
}