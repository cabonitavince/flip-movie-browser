import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_state.dart';
import 'package:movie_browser/app/presentation/widgets/movie_card.dart';
import 'package:movie_browser/core/enum/state_enum.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF111111),
        appBar: AppBar(
          backgroundColor: Color(0xFF111111),
          title: Text(
            'Popular Movies',
            style: TextStyle(
              color: Color(0xFF8B7DFF),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          elevation: 0,
          centerTitle: false,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 25,
                ),
                onPressed: () {}),
          ],
        ),
        body: BlocBuilder<MovieListBloc, MovieListState>(
            builder: (context, state) {
          if (state.status == StateEnum.loading) {
            //TODO: Add a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == StateEnum.loaded) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                int crossAxisCount;
                if (constraints.maxWidth < 600) {
                  crossAxisCount = 2;
                } else if (constraints.maxWidth < 1000) {
                  crossAxisCount = 4;
                } else {
                  crossAxisCount = 6;
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  // Adjust padding as needed
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(movie: state.movies[index]);
                  },
                );
              },
            );
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
}
