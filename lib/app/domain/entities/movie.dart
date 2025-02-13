import 'package:flutter/foundation.dart';
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
  bool isFavorite;

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
    this.isFavorite = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

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
        releaseDate: "2024-01-01",
        title: "Test Movie",
        video: false,
        voteAverage: 7.5,
        voteCount: 1000,
        isFavorite: false,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    other is Movie &&
        adult == other.adult &&
        backdropPath == other.backdropPath &&
        listEquals(genreIds, other.genreIds) &&
        id == other.id &&
        originalLanguage == other.originalLanguage &&
        originalTitle == other.originalTitle &&
        overview == other.overview &&
        popularity == other.popularity &&
        posterPath == other.posterPath &&
        releaseDate == other.releaseDate &&
        title == other.title &&
        video == other.video &&
        voteAverage == other.voteAverage &&
        voteCount == other.voteCount &&
        isFavorite == other.isFavorite;
    return true;
  }

  @override
  int get hashCode => Object.hash(
      adult,
      backdropPath,
      Object.hashAll(genreIds ?? []),
      id,
      originalLanguage,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      title,
      video,
      voteAverage,
      voteCount,
      isFavorite);
}
