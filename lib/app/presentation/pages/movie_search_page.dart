import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/search_movie/search_movie_event.dart';
import 'package:movie_browser/app/presentation/blocs/search_movie/search_movie_state.dart';
import 'package:movie_browser/app/presentation/widgets/movie_card.dart';
import 'package:movie_browser/core/enum/message_type_enum.dart';
import 'package:movie_browser/core/enum/state_enum.dart';
import 'package:movie_browser/core/widgets/custom_loader.dart';
import 'package:movie_browser/core/widgets/custom_message.dart';
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
      appBar: buildAppBar(),
      body: BlocConsumer<SearchMovieBloc, SearchMovieState>(
        listener: (context, state) {
          //TODO: Implement listener
        },
        builder: (context, state) {
          if (state.status == StateEnum.success) {
            return ResponsiveGridViewBuilder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: state.result[index],
                    showFavoriteButton: false,
                  );
                });
          } else if (state.status == StateEnum.initial) {
            return const CustomMessage(
              message: 'Start searching for movies',
            );
          } else if (state.status == StateEnum.error) {
            return const CustomMessage(
              message: 'Something went wrong.\nPlease try again',
            );
          } else if (state.status == StateEnum.empty) {
            return const CustomMessage(
                message: 'No movies found!\nPlease type something else.');
          } else if (state.status == StateEnum.noInternet) {
            return const CustomMessage(
                type: MessageTypeEnum.warning,
                message:
                    'Please try again later!\nCheck your internet connection.');
          } else {
            return const CustomLoader();
          }
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
