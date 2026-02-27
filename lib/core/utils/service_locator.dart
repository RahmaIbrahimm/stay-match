import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../networking/dio_consumer.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  var a = getIt.registerSingleton<DioConsumer>(DioConsumer(Dio()));
  var b = getIt.registerSingleton<AuthRepoImpl>(
      AuthRepoImpl(getIt.get<DioConsumer>())
  );
}