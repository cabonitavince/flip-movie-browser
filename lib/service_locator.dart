import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_browser/app/data/services/movie_service.dart';
import 'package:movie_browser/app/domain/repositories/movie_repository_impl.dart';
import 'package:movie_browser/app/domain/repositories/movie_respository.dart';
import 'package:movie_browser/app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // http client
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());

  // services
  serviceLocator.registerLazySingleton<MovieService>(
    () => MovieService(httpClient: serviceLocator<http.Client>()),
  );

  // repositories
  serviceLocator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(serviceLocator<MovieService>()),
  );

  // use cases
  serviceLocator.registerFactory(
      () => GetPopularMoviesUseCase(serviceLocator<MovieRepository>()));

  // blocs
  serviceLocator.registerFactory(
      () => MovieListBloc(serviceLocator<GetPopularMoviesUseCase>()));
}
