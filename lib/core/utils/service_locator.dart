import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/apartments/data/repos/apartment_repo_impl.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/home/data/repos/home_repo_impl.dart';
import '../../features/rooms/data/repos/rooms_repo_impl.dart';
import '../networking/dio_consumer.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<DioConsumer>(DioConsumer(Dio()));
  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl(getIt.get<DioConsumer>()));
  getIt.registerLazySingleton<ApartmentRepoImpl>(
    () => ApartmentRepoImpl(apiService: getIt<DioConsumer>()),
  );
  getIt.registerLazySingleton<RoomsRepoImpl>(
    () => RoomsRepoImpl(apiService: getIt<DioConsumer>()),
  );
  getIt.registerLazySingleton<HomeRepoImpl>(
    () => HomeRepoImpl(apiService: getIt<DioConsumer>()),
  );
}