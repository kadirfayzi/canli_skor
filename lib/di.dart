import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';
import 'core/network/connectivity_service.dart';
import 'core/network/network_cubit.dart';
import 'features/favorites/bloc/favorites_bloc.dart';
import 'features/favorites/data/storage_service.dart';
import 'features/matches/bloc/match_bloc.dart';
import 'features/matches/data/match_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  /// Register DioClient
  getIt.registerLazySingleton<Dio>(() => DioClient.create());

  /// Register Services
  getIt.registerLazySingleton<StorageService>(() => StorageService());
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  /// Register Repositories
  getIt.registerLazySingleton<MatchRepository>(() => MatchRepository(getIt<Dio>()));

  /// Register Blocs/Cubits
  getIt.registerFactory<MatchBloc>(() => MatchBloc(getIt<MatchRepository>()));
  getIt.registerFactory<FavoritesBloc>(() => FavoritesBloc(getIt<StorageService>()));
  getIt.registerFactory<NetworkCubit>(() => NetworkCubit(getIt<ConnectivityService>()));
}
