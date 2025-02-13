import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_event.dart';
import 'package:movie_browser/app/presentation/pages/home_page.dart';
import 'package:movie_browser/service_locator.dart';

Future<void> main() async {
  setupServiceLocator();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieListBloc>(
            create: (context) =>
                serviceLocator<MovieListBloc>()..add(const MovieListLoad()),
          ),
        ],
        child: MaterialApp(
            title: 'Flip Take Home Challenge - Movie Browser App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const HomePage()));
  }
}
