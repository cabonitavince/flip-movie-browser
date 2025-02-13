import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_state.dart';
import 'package:movie_browser/app/presentation/pages/movie_search_page.dart';
import 'package:movie_browser/app/presentation/widgets/movie_card.dart';
import 'package:movie_browser/app/presentation/widgets/no_connection_widget.dart';
import 'package:movie_browser/core/enum/state_enum.dart';
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
          if (state.status == StateEnum.loading) {
            //TODO: Add a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == StateEnum.loaded) {
            return ResponsiveGridViewBuilder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(movie: state.movies[index]);
                });
          } else if (state.status == StateEnum.error) {
            // TODO: Add an error message
            return Center(
                child: Text(state.errorMessage ?? 'Something Went Wrong!'));
          } else if (state.status == StateEnum.noInternet) {
            // TODO: Add a no internet message
            return Center(
                child: Text(state.errorMessage ?? 'No internet connection'));
          } else if (state.status == StateEnum.empty) {
            return const Center(child: Text('No Movies Found!'));
          } else {
            return const Center(child: Text('Something Went Wrong!'));
          }
        }));
  }

  void _handleOnSearchTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MovieSearchPage()),
    );
  }
}
