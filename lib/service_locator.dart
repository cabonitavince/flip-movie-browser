import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_browser/app/data/services/local_storage_service.dart';
import 'package:movie_browser/app/data/services/movie_service.dart';
import 'package:movie_browser/app/domain/repositories/movie_repository_impl.dart';
import 'package:movie_browser/app/domain/repositories/movie_respository.dart';
import 'package:movie_browser/app/domain/usecases/add_favorite_movie_usecase.dart';
import 'package:movie_browser/app/domain/usecases/get_cached_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/get_favorite_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_browser/app/domain/usecases/remove_favorite_movie_usecase.dart';
import 'package:movie_browser/app/domain/usecases/save_movies_to_cache_usecase.dart';
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
  serviceLocator.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(),
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
  serviceLocator.registerFactory(
      () => GetCachedMoviesUseCase(serviceLocator<LocalStorageService>()));
  serviceLocator.registerFactory(
      () => SaveMoviesToCacheUseCase(serviceLocator<LocalStorageService>()));
  serviceLocator.registerFactory(
      () => AddFavoriteMovieUseCase(serviceLocator<LocalStorageService>()));
  serviceLocator.registerFactory(
      () => RemoveFavoriteMovieUseCase(serviceLocator<LocalStorageService>()));
  serviceLocator.registerFactory(
      () => GetFavoriteMoviesUseCase(serviceLocator<LocalStorageService>()));

  // blocs
  serviceLocator.registerFactory(() => MovieListBloc(
      serviceLocator<GetPopularMoviesUseCase>(),
      serviceLocator<SaveMoviesToCacheUseCase>(),
      serviceLocator<GetCachedMoviesUseCase>(),
      serviceLocator<AddFavoriteMovieUseCase>(),
      serviceLocator<RemoveFavoriteMovieUseCase>(),
      serviceLocator<GetFavoriteMoviesUseCase>()));
  serviceLocator.registerFactory(
      () => SearchMovieBloc(serviceLocator<SearchMoviesUseCase>()));
}
