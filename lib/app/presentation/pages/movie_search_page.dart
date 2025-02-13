import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/search_movie/search_movie_event.dart';
import 'package:movie_browser/app/presentation/blocs/search_movie/search_movie_state.dart';
import 'package:movie_browser/app/presentation/widgets/movie_card.dart';
import 'package:movie_browser/core/enum/state_enum.dart';
import 'package:movie_browser/core/widgets/responsive_gridview_builder.dart';
import 'package:movie_browser/utils/constants.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          cursorColor: AppConstants.primaryColor,
          style: const TextStyle(color: Colors.white),
          controller: _searchController,
          onSubmitted: _handleSubmit,
          decoration: InputDecoration(
            hintText: 'Search movies...',
            suffixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () => _handleSubmit(_searchController.text)),
          ),
        ),
        elevation: 0,
        centerTitle: false,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: SizedBox(),
        ),
      ),
      body: BlocConsumer<SearchMovieBloc, SearchMovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == StateEnum.success) {
            return ResponsiveGridViewBuilder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  return MovieCard(movie: state.result[index]);
                });
          } else if (state.status == StateEnum.initial) {
            //TODO: Add an initial widget
            return const Center(
              child: Text('Search for a movie'),
            );
          } else if (state.status == StateEnum.error) {
            //TODO: Add an error widget
            return const Center(
              child: Text('An error occurred'),
            );
          } else if (state.status == StateEnum.empty) {
            //TODO: Add an empty widget
            return const Center(
              child: Text('No movies found'),
            );
          } else if (state.status == StateEnum.noInternet) {
            //TODO: Add a no internet widget
            return const Center(
              child: Text('No internet connection'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _handleSubmit(String query) {
    if (query.trim().isNotEmpty) {
      FocusScope.of(context).unfocus();
      _searchController.clear();
      context.read<SearchMovieBloc>().add(SearchMovieQuery(query));
    }
  }
}
