import 'package:flutter/material.dart';
import 'package:movie_browser/app/domain/entities/movie.dart';
import 'package:movie_browser/app/presentation/widgets/favorite_button.dart';
import 'package:movie_browser/core/widgets/app_image.dart';
import 'package:movie_browser/core/widgets/gradient_container.dart';
import 'package:movie_browser/utils/constants.dart';
import 'package:movie_browser/utils/env_config.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double borderRadius = 8;

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () {},
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImage(
              imageUrl: '${EnvConfig.movieImageBaseUrl}${movie.posterPath}',
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
            Positioned(
              top: 16,
              right: 16,
              child: FavoriteButton(
                  isFavorite: movie.isFavorite,
                  onFavoriteChanged: (value) {
                    //TODO: Implement on changed
                  }),
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
          movie.releaseDate?.split('-')[0] ?? '',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
        ),
        const Spacer(),
        const Icon(
          Icons.star,
          color: AppConstants.primaryColor,
          size: 16,
        ),
        Text(
          (movie.voteAverage?.toStringAsFixed(1)).toString(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
