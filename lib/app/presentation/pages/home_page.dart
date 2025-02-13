import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/domain/entities/movie/movie.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_event.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_state.dart';
import 'package:movie_browser/app/presentation/pages/movie_search_page.dart';
import 'package:movie_browser/app/presentation/widgets/movie_card.dart';
import 'package:movie_browser/app/presentation/widgets/no_connection_widget.dart';
import 'package:movie_browser/core/enum/message_type_enum.dart';
import 'package:movie_browser/core/enum/state_enum.dart';
import 'package:movie_browser/core/widgets/custom_loader.dart';
import 'package:movie_browser/core/widgets/custom_message.dart';
import 'package:movie_browser/core/widgets/responsive_gridview_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Popular Movies',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF8B7DFF),
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold)),
          elevation: 0,
          centerTitle: false,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.refresh,
                ),
                onPressed: () => _handleOnRefreshTap()),
            IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () => _handleOnSearchTap()),
          ],
          bottom: context.watch<MovieListBloc>().state.status ==
                  StateEnum.noInternet
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: NoConnectionWidget(),
                )
              : null,
        ),
        body: BlocBuilder<MovieListBloc, MovieListState>(
            builder: (context, state) {
          if (state.status == StateEnum.error) {
            return const CustomMessage(
                type: MessageTypeEnum.error,
                message: 'Something went wrong!\nPlease try again later.');
          } else if (state.status == StateEnum.loaded) {
            return buildMovieList(state.movies);
          } else if (state.status == StateEnum.noInternet) {
            return state.movies.isEmpty
                ? const CustomMessage(
                    type: MessageTypeEnum.warning,
                    message:
                        'Please try again later!\nCheck your internet connection.')
                : buildMovieList(state.movies);
          } else if (state.status == StateEnum.empty) {
            return const CustomMessage(
                type: MessageTypeEnum.info,
                message: 'No Movies Found!\nPlease try again later.');
          } else {
            return const CustomLoader();
          }
        }));
  }

  ResponsiveGridViewBuilder buildMovieList(List<Movie> movies) {
    return ResponsiveGridViewBuilder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieCard(movie: movies[index]);
        });
  }

  void _handleOnSearchTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MovieSearchPage()),
    );
  }

  void _handleOnRefreshTap() {
    context.read<MovieListBloc>().add(const MovieListLoad());
    // show snack bar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Movies refreshed!'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
