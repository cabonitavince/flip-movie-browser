import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_event.dart';
import 'package:movie_browser/app/presentation/widgets/favorite_button.dart';
import 'package:movie_browser/core/extensions/string_ext.dart';
import 'package:movie_browser/core/widgets/app_image.dart';
import 'package:movie_browser/core/widgets/gradient_container.dart';
import 'package:movie_browser/core/widgets/icon_text.dart';
import 'package:movie_browser/utils/constants.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;
  final bool showFavoriteButton;

  const MovieDetailsPage(
      {super.key, required this.movie, this.showFavoriteButton = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        child: Stack(
          children: [
            AppImage(
              imageUrl: movie.backdropPath.absoluteImageUrlOriginal,
              height: double.maxFinite,
              width: double.maxFinite,
            ),
            Positioned(
              child: Column(
                children: [
                  buildCustomAppBar(context, movie.isFavorite, (value) {
                    context
                        .read<MovieListBloc>()
                        .add(MovieListToggleFavorite(movie, value));
                  }),
                  Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                            child: GradientContainer(
                                child: buildMovieInfoAndButton(context))),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMovieInfoAndButton(BuildContext context) {
    TextStyle? iconTextStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title ?? '',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            IconText(
              icon: Icons.star_rounded,
              text: (movie.voteAverage?.toStringAsFixed(1)) ?? '',
              textStyle: iconTextStyle,
            ),
            const SizedBox(
              width: 12.0,
            ),
            IconText(
              icon: Icons.calendar_month_rounded,
              text: movie.releaseDate.yearFromDate,
              textStyle: iconTextStyle,
            )
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          movie.overview ?? '',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white)
        ),
        const SizedBox(
          height: 32,
        ),
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
            label: Text('WATCH NOW',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget buildCustomAppBar(
      BuildContext context, bool isFavorite, Function(bool) onFavoriteChanged) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppConstants.primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          Visibility(
            visible: showFavoriteButton,
            child: FavoriteButton(
                isFavorite: isFavorite, onFavoriteChanged: onFavoriteChanged),
          )
        ],
      ),
    );
  }
}
