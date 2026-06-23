import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:stay_match/Features/saved/data/repos/saved_properties_repo_impl.dart';
import 'package:stay_match/core/data/repos/global_repo.dart';
import 'package:stay_match/core/theme/app_theme.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import 'Features/auth/manager/auth_cubit.dart';
import 'Features/notifications/data/repos/notifications_repo_impl.dart';
import 'Features/notifications/presentation/manager/notifications_cubit.dart';
import 'Features/saved/presentation/manager/saved_properties_cubit.dart';
import 'core/routing/app_routing.dart';
import 'core/utils/app_keys.dart';
import 'core/widgets/global_error_widget.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  // Catch Flutter framework errors (build, layout, etc.)
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  // Catch unhandled async / platform errors
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Unhandled error: $error\n$stack');
    return true;
  };

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepoImpl>())),
        BlocProvider(create: (context) => SavedPropertiesCubit(getIt.get<SavedPropertiesRepoImpl>())),
        BlocProvider(create: (context) => NotificationsCubit(repo: getIt.get<NotificationsRepoImpl>())..connectHub()),
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
      designSize: const Size(402, 874),
      child: DevicePreview(
        enabled: false,
        builder: (context) => MaterialApp.router(
          scaffoldMessengerKey: AppKeys.rootScaffoldMessengerKey,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            // Replace red screen globally
            ErrorWidget.builder = (FlutterErrorDetails details) {
              return SafeArea(
                child: GlobalErrorWidget(
                  onTryAgain: () {
                    // Just pop back if possible, otherwise go to login
                    final navigator = AppRouting.navigatorKey.currentState;
                    if (navigator != null && navigator.canPop()) {
                      navigator.pop();
                    } else {
                      AppRouting.navigatorKey.currentContext?.go(AppRouting.loginView);
                    }
                  },
                ),
              );
            };
            return DevicePreview.appBuilder(context, child);
          },
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          routerConfig: AppRouting.router,
        ),
      ),
    );
  }
}