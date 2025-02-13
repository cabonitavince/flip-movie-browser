import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_browser/app/data/services/movie_service.dart';
import 'package:movie_browser/app/domain/repositories/movie_repository_impl.dart';
import 'package:movie_browser/app/domain/repositories/movie_respository.dart';
import 'package:movie_browser/app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/search_movies_usecase.dart';
import 'package:movie_browser/app/presentation/blocs/movie_list/movie_list_bloc.dart';
import 'package:movie_browser/app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_browser/utils/api_util.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // http client
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());

  // api util
  serviceLocator.registerLazySingleton(
      () => ApiUtil(httpClient: serviceLocator<http.Client>()));

  // services
  serviceLocator.registerLazySingleton<MovieService>(
    () => MovieService(apiUtil: serviceLocator<ApiUtil>()),
  );

  // repositories
  serviceLocator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(serviceLocator<MovieService>()),
  );

  // use cases
  serviceLocator.registerFactory(
      () => GetPopularMoviesUseCase(serviceLocator<MovieRepository>()));
  serviceLocator.registerFactory(
      () => SearchMoviesUseCase(serviceLocator<MovieRepository>()));

  // blocs
  serviceLocator.registerFactory(
      () => MovieListBloc(serviceLocator<GetPopularMoviesUseCase>()));
  serviceLocator.registerFactory(
      () => SearchMovieBloc(serviceLocator<SearchMoviesUseCase>()));
}
