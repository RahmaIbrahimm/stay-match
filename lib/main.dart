import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/theme/app_theme.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/features/auth/data/repos/auth_repo_impl.dart';

import 'core/routing/app_routing.dart';
import 'core/utils/secure_storage_helper.dart';
import 'features/auth/manager/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.tokenKey);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepoImpl>())),
      ],
      child: StayMatch(),
    ),
  );
}

class StayMatch extends StatelessWidget {
  const StayMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(402 , 874),
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