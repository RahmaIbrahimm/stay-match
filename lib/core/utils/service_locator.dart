import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stay_match/Features/chat/data/repos/chat_repo_impl.dart';
import 'package:stay_match/Features/my_properties/data/repos/my_properties_repo_impl.dart';
import 'package:stay_match/Features/profile/data/repos/profile_repo_impl.dart';
import 'package:stay_match/Features/profile/presentation/manager/profile_cubit.dart';

import '../../Features/add_property/data/repos/add_property_repo_impl.dart';
import '../../Features/apartments/data/repos/apartment_repo_impl.dart';
import '../../Features/auth/data/repos/auth_repo_impl.dart';
import '../../Features/filter/data/repos/location_repo_impl.dart';
import '../../Features/filter/presentation/manager/location_cubit.dart';
import '../../Features/home/data/repos/home_repo_impl.dart';
import '../../Features/my_properties/data/repos/my_properties_repo.dart';
import '../../Features/rooms/data/repos/rooms_repo_impl.dart';
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
  getIt.registerLazySingleton<LocationRepoImpl>(() => LocationRepoImpl());
  getIt.registerLazySingleton<LocationCubit>(
        () => LocationCubit(locationRepository: getIt.get<LocationRepoImpl>()),
  );
  getIt.registerLazySingleton<ChatRepoImpl>(() =>
      ChatRepoImpl(getIt<DioConsumer>()));
  getIt.registerLazySingleton<AddPropertyRepoImpl>(() =>
      AddPropertyRepoImpl(getIt<DioConsumer>()));
  getIt.registerLazySingleton<MyPropertiesRepo>(() =>
      MyPropertiesRepoImpl( apiService: getIt<DioConsumer>(),));

  getIt.registerLazySingleton<ProfileRepoImpl>(() =>
      ProfileRepoImpl( apiService: getIt<DioConsumer>(),));
  getIt.registerLazySingleton<ProfileCubit>(() =>
      ProfileCubit( profileRepo: getIt<ProfileRepoImpl>(),));
  // getIt.registerSingleton<HubConnection>(
  //   HubConnectionBuilder()
  //       .withUrl(
  //       {${Endpoints.baseUrl}${Endpoints.startChat}, // رابط الهاب بتاعكم
  //         options: HttpConnectionOptions(
  //           accessTokenFactory: () async => "YOUR_TOKEN_HERE",
  //           // لو فيه توكن ابعته هنا
  //           logging: (level, message) => log('SignalR: $message'),
  //         ),
  //   )
  //       .withAutomaticReconnect() // عشان لو النت قطع يرجع يوصل لوحده
  //       .build(),
  // );


}