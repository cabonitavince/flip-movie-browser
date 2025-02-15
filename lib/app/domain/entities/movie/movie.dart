import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Movie extends HiveObject {
  @HiveField(0)
  bool? adult;

  @HiveField(1)
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  @HiveField(2)
  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;

  @HiveField(3)
  int? id;

  @HiveField(4)
  @JsonKey(name: 'original_language')
  String? originalLanguage;

  @HiveField(5)
  @JsonKey(name: 'original_title')
  String? originalTitle;

  @HiveField(6)
  String? overview;

  @HiveField(7)
  double? popularity;

  @HiveField(8)
  @JsonKey(name: 'poster_path')
  String? posterPath;

  @HiveField(9)
  @JsonKey(name: 'release_date')
  String? releaseDate;

  @HiveField(10)
  String? title;

  @HiveField(11)
  bool? video;

  @HiveField(12)
  @JsonKey(name: 'vote_average')
  double? voteAverage;

  @HiveField(13)
  @JsonKey(name: 'vote_count')
  int? voteCount;

  @HiveField(14)
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

  Movie copyWith({
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
    bool? isFavorite,
  }) {
    return Movie(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Movie &&
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
