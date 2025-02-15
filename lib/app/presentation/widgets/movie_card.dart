import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_event.dart';
import 'package:movie_browser/app/presentation/pages/movie_details_page.dart';
import 'package:movie_browser/app/presentation/widgets/favorite_button.dart';
import 'package:movie_browser/core/extensions/string_ext.dart';
import 'package:movie_browser/core/widgets/app_image.dart';
import 'package:movie_browser/core/widgets/gradient_container.dart';
import 'package:movie_browser/core/widgets/icon_text.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool showFavoriteButton;

  const MovieCard(
      {super.key, required this.movie, this.showFavoriteButton = true});

  @override
  Widget build(BuildContext context) {
    double borderRadius = 8;

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailsPage(
                    movie: movie,
                    showFavoriteButton: showFavoriteButton,
                  )),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImage(
              imageUrl: movie.posterPath.absoluteImageUrlW500,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GradientContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  buildYearAndRating(context),
                ],
              )),
            ),
            Visibility(
              visible: showFavoriteButton,
              child: Positioned(
                top: 16,
                right: 16,
                child: FavoriteButton(
                    isFavorite: movie.isFavorite,
                    onFavoriteChanged: (value) {
                      context
                          .read<MovieListBloc>()
                          .add(MovieListToggleFavorite(movie, value));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildYearAndRating(BuildContext context) {
    return Row(
      children: [
        Text(
          movie.releaseDate.yearFromDate,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Spacer(),
        IconText(
            icon: Icons.star_rounded,
            text: (movie.voteAverage?.toStringAsFixed(1)) ?? '')
      ],
    );
  }
}
