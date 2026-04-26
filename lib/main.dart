import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:stay_match/core/theme/app_theme.dart';
import 'package:stay_match/core/utils/secure_storage_keys.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import 'Features/auth/manager/auth_cubit.dart';
import 'core/routing/app_routing.dart';
import 'core/utils/secure_storage_helper.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  final secureStorage = getIt.get<SecureStorageHelper>();
  String? token = await secureStorage.readFromSecureStorage(
      key: SecureStorageKeys.tokenKey);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepoImpl>())),
      ],
      child: StayMatch(isLoggedIn: token != null),
    ),
  );
}

class StayMatch extends StatelessWidget {
  const StayMatch({super.key, required this.isLoggedIn});
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;
    return ScreenUtilInit(
      designSize: Size(402, 874),
      child: DevicePreview(
        enabled: true,
        builder: (context) => MaterialApp.router(
          useInheritedMediaQuery: true,
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          routerConfig: AppRouting.router,
        ),
      ),
    );
  }
}