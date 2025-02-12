import 'package:flutter/material.dart';
import 'package:movie_browser/app/domain/entities/movie.dart';
import 'package:movie_browser/core/widgets/app_image.dart';
import 'package:movie_browser/core/widgets/gradient_container.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          //TODO: handle this base path in a better way
          AppImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GradientContainer(
              child: Text(
                movie.title ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
