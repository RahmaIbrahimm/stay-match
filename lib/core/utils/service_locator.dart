import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo_impl.dart';
import 'package:stay_match/Features/chat/data/repos/chat_repo_impl.dart';
import 'package:stay_match/Features/my_properties/data/repos/my_properties_repo_impl.dart';
import 'package:stay_match/Features/other_user_profile/data/repos/other_user_profile_repo_impl.dart';
import 'package:stay_match/Features/profile/data/repos/profile_repo_impl.dart';
import 'package:stay_match/Features/profile/presentation/manager/profile_cubit.dart';
import 'package:stay_match/Features/saved/data/repos/saved_properties_repo_impl.dart';
import 'package:stay_match/core/utils/cache_service.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';

import '../../Features/add_property/data/repos/add_property_repo_impl.dart';
import '../../Features/apartments/data/repos/apartment_repo_impl.dart';
import '../../Features/auth/data/repos/auth_repo_impl.dart';
import '../../Features/chatbot/data/repos/chatbot_repo_impl.dart';
import '../../Features/filter/data/repos/location_repo_impl.dart';
import '../../Features/filter/presentation/manager/location_cubit.dart';
import '../../Features/home/data/repos/home_repo_impl.dart';
import '../../Features/my_properties/data/repos/my_properties_repo.dart';
import '../../Features/notifications/data/repos/notifications_repo_impl.dart';
import '../../Features/payment/data/repos/payment_repo_impl.dart';
import '../../Features/questions/data/repos/questions_repo_impl.dart';
import '../../Features/reviews/data/repos/reviews_repo_impl.dart';
import '../../Features/rooms/data/repos/rooms_repo_impl.dart';
import '../networking/chat_service.dart';
import '../networking/dio_consumer.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {

  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);

  getIt.registerLazySingleton<CacheService>(
          () => CacheService(sharedPrefs: getIt<SharedPreferences>())
  );

  getIt.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());

  // 2. (Networking)
  getIt.registerLazySingleton<Dio>(() => Dio()); // تسجيل Dio نفسه
  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(getIt<Dio>()));

  // 3.(Repositories - Singleton is fine here)
  getIt.registerLazySingleton<AuthRepoImpl>(() => AuthRepoImpl(getIt<DioConsumer>()));
  getIt.registerLazySingleton<ApartmentRepoImpl>(() => ApartmentRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerLazySingleton<RoomsRepoImpl>(() => RoomsRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerLazySingleton<LocationRepoImpl>(() => LocationRepoImpl());
  getIt.registerLazySingleton<ChatRepoImpl>(() => ChatRepoImpl(getIt<DioConsumer>()));
  getIt.registerLazySingleton<AddPropertyRepoImpl>(() => AddPropertyRepoImpl(getIt<DioConsumer>()));
  getIt.registerLazySingleton<MyPropertiesRepo>(() => MyPropertiesRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerLazySingleton<ProfileRepoImpl>(() => ProfileRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerLazySingleton<BookingRepoImpl>(() => BookingRepoImpl(getIt<DioConsumer>()));
  getIt.registerLazySingleton<SavedPropertiesRepoImpl>(() =>
      SavedPropertiesRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerLazySingleton<ReviewsRepoImpl>(() =>
      ReviewsRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerLazySingleton<OtherUserProfileRepoImpl>(() =>
      OtherUserProfileRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerLazySingleton<PaymentRepoImpl>(() =>
      PaymentRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerLazySingleton<QuestionsRepoImpl>(() =>
      QuestionsRepoImpl());
  getIt.registerFactory<LocationCubit>(
        () => LocationCubit(locationRepository: getIt<LocationRepoImpl>()),
  );
  getIt.registerLazySingleton<ChatbotRepoImpl>(() => ChatbotRepoImpl());
  getIt.registerLazySingleton<NotificationsRepoImpl>(() => NotificationsRepoImpl(apiService: getIt<DioConsumer>()));
  getIt.registerFactory<ProfileCubit>(
        () => ProfileCubit(profileRepo: getIt<ProfileRepoImpl>()),
  );

  getIt.registerLazySingleton<ChatService>(() => ChatService());
}